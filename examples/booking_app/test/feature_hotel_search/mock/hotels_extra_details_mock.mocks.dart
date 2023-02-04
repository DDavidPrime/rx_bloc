// Mocks generated by Mockito 5.3.2 from annotations
// in booking_app/test/feature_hotel_search/mock/hotels_extra_details_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:booking_app/base/common_blocs/hotels_extra_details_bloc.dart'
    as _i2;
import 'package:favorites_advanced_base/core.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeHotelsExtraDetailsBlocEvents_0 extends _i1.SmartFake
    implements _i2.HotelsExtraDetailsBlocEvents {
  _FakeHotelsExtraDetailsBlocEvents_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHotelsExtraDetailsBlocStates_1 extends _i1.SmartFake
    implements _i2.HotelsExtraDetailsBlocStates {
  _FakeHotelsExtraDetailsBlocStates_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HotelsExtraDetailsBlocStates].
///
/// See the documentation for Mockito's code generation for more information.
class MockHotelsExtraDetailsBlocStates extends _i1.Mock
    implements _i2.HotelsExtraDetailsBlocStates {
  MockHotelsExtraDetailsBlocStates() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [HotelsExtraDetailsBlocEvents].
///
/// See the documentation for Mockito's code generation for more information.
class MockHotelsExtraDetailsBlocEvents extends _i1.Mock
    implements _i2.HotelsExtraDetailsBlocEvents {
  MockHotelsExtraDetailsBlocEvents() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void fetchExtraDetails(
    _i3.Hotel? hotel, {
    bool? allProps = false,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #fetchExtraDetails,
          [hotel],
          {#allProps: allProps},
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [HotelsExtraDetailsBlocType].
///
/// See the documentation for Mockito's code generation for more information.
class MockHotelsExtraDetailsBlocType extends _i1.Mock
    implements _i2.HotelsExtraDetailsBlocType {
  MockHotelsExtraDetailsBlocType() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.HotelsExtraDetailsBlocEvents get events => (super.noSuchMethod(
        Invocation.getter(#events),
        returnValue: _FakeHotelsExtraDetailsBlocEvents_0(
          this,
          Invocation.getter(#events),
        ),
      ) as _i2.HotelsExtraDetailsBlocEvents);
  @override
  _i2.HotelsExtraDetailsBlocStates get states => (super.noSuchMethod(
        Invocation.getter(#states),
        returnValue: _FakeHotelsExtraDetailsBlocStates_1(
          this,
          Invocation.getter(#states),
        ),
      ) as _i2.HotelsExtraDetailsBlocStates);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
