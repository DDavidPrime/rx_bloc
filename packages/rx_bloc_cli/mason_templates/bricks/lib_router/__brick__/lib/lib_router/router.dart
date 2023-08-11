{{> licence.dart }}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../base/common_blocs/coordinator_bloc.dart';{{#enable_feature_deeplinks}}
import '../base/models/deep_link_model.dart';{{/enable_feature_deeplinks}}{{#enable_feature_counter}}
import '../feature_counter/di/counter_page_with_dependencies.dart';{{/enable_feature_counter}}
import '../feature_dashboard/di/dashboard_page_with_dependencies.dart';{{#enable_feature_deeplinks}}
import '../feature_deep_link_details/di/deep_link_details_page_with_dependencies.dart';
import '../feature_deep_link_list/di/deep_link_list_page_with_dependencies.dart';
import '../feature_enter_message/di/enter_message_with_dependencies.dart';{{/enable_feature_deeplinks}}
import '../feature_home/views/home_page.dart';{{#has_authentication}}{{#enable_login}}
import '../feature_login/di/login_page_with_dependencies.dart';{{/enable_login}}{{^enable_login}}
import '../feature_login/views/login_page.dart';{{/enable_login}}{{/has_authentication}}
import '../feature_notifications/di/notifications_page_with_dependencies.dart';{{#enable_feature_otp}}
import '../feature_otp/di/otp_page_with_dependencies.dart';{{/enable_feature_otp}}
import '../feature_profile/di/profile_page_with_dependencies.dart';
import '../feature_splash/di/splash_page_with_dependencies.dart';
import '../feature_splash/services/splash_service.dart';{{#enable_feature_widget_toolkit}}
import '../feature_widget_toolkit/di/widget_toolkit_with_dependencies.dart';{{/enable_feature_widget_toolkit}}
import '../lib_permissions/services/permissions_service.dart';
import 'models/route_data_model.dart';
import 'models/route_model.dart';
import 'models/routes_path.dart';
import 'views/error_page.dart';

part 'router.g.dart';{{#has_authentication}}
part 'routes/onboarding_routes.dart';{{/has_authentication}}
part 'routes/profile_routes.dart';
part 'routes/routes.dart';
part 'routes/showcase_routes.dart';

/// A wrapper class implementing all the navigation logic and providing
/// [GoRouter] instance through its getter method [AppRouter.router].
///
/// `AppRouter` depends on [CoordinatorBloc] so the user can be redirected to
/// specific page if the `isAuthenticated` state changes (It can be used with
/// some other global state change as well).
class AppRouter {
  AppRouter({
    required this.coordinatorBloc,
    required this.rootNavigatorKey,
  });

  final CoordinatorBlocType coordinatorBloc;
  final GlobalKey<NavigatorState> rootNavigatorKey;

  late final _GoRouterRefreshStream _refreshListener =
      _GoRouterRefreshStream(coordinatorBloc.states.isAuthenticated,
{{#enable_feature_otp}}coordinatorBloc.states.isOtpConfirmed {{/enable_feature_otp}});

  GoRouter get router => _goRouter;

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: const SplashRoute().location,
    routes: $appRoutes,
    redirect: _pageRedirections,
    refreshListenable: _refreshListener,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
  );

  /// This method contains all redirection logic.
  FutureOr<String?> _pageRedirections(
    BuildContext context,
    GoRouterState state,
  ) async { {{#has_authentication}}
    if (_refreshListener.isLoggedIn && state.uri.queryParameters['from'] != null) {
      return state.uri.queryParameters['from'];
    }
    {{^enable_feature_otp}}
    if (_refreshListener.isLoggedIn &&
        state.matchedLocation == const LoginRoute().location) {
      return const DashboardRoute().location;
    }{{/enable_feature_otp}}
 
    {{#enable_feature_otp}}
    if (_refreshListener.isLoggedIn &&
        state.matchedLocation == const LoginRoute().location) {
      return const OtpRoute().location;
    }
    if (_refreshListener.isLoggedIn &&
        _refreshListener.isOtpConfirmed &&
        state.matchedLocation == const OtpRoute().location) {
      return const DashboardRoute().location;
    }
    {{/enable_feature_otp}}{{/has_authentication}}
    if (state.matchedLocation == const SplashRoute().location) {
      return null;
    }
    if (!context.read<SplashService>().isAppInitialized) {
      return '${const SplashRoute().location}?from=${state.uri.toString()}';
    }

    final pathInfo =
        router.routeInformationParser.configuration.findMatch(state.uri.toString());

    final routeName = RouteModel.getRouteNameByFullPath(pathInfo.fullPath);

    final hasPermissions = routeName != null
        ? await context
            .read<PermissionsService>()
            .hasPermission(routeName, graceful: true)
        : true; {{#has_authentication}}

    if (!_refreshListener.isLoggedIn && !hasPermissions) {
      return '${const LoginRoute().location}?from=${state.uri.toString()}';
    }{{/has_authentication}}

    
    if (!hasPermissions) {
      return const DashboardRoute().location;
    }

    return null;
  }
}
class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<bool> stream,
{{#enable_feature_otp}} Stream<bool> streamOTP{{/enable_feature_otp}}) {
    _subscription =
      stream.listen(
        (bool isLoggedIn) {
          this.isLoggedIn = isLoggedIn;
          notifyListeners();
        },
      );
{{#enable_feature_otp}}
     _subscriptionOtp = streamOTP.listen((bool isOtpConfirmed) {
        this.isOtpConfirmed = isOtpConfirmed;
        notifyListeners();
      });{{/enable_feature_otp}}
  }

  late final StreamSubscription<bool> _subscription;{{#enable_feature_otp}}
  late final StreamSubscription<bool> _subscriptionOtp; {{/enable_feature_otp}}
  late bool isLoggedIn = false;
  {{#enable_feature_otp}}
  late bool isOtpConfirmed = false;{{/enable_feature_otp}}
  @override
  void dispose() {

    _subscription.cancel();{{#enable_feature_otp}}
    _subscriptionOtp.cancel();{{/enable_feature_otp}}
    super.dispose();
  }
}
