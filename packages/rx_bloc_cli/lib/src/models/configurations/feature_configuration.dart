/// Feature Configuration
class FeatureConfiguration {
  /// Feature Configuration constructor
  FeatureConfiguration({
    required this.changeLanguageEnabled,
    required this.counterEnabled,
    required this.widgetToolkitEnabled,
    required this.analyticsEnabled,
    required this.pushNotificationsEnabled,
    required this.realtimeCommunicationEnabled,
    required this.deepLinkEnabled,
    required this.devMenuEnabled,
    required this.patrolTestsEnabled,
    required this.cicdEnabled,
  });

  /// Analytics
  final bool analyticsEnabled;

  /// Push notifications
  final bool pushNotificationsEnabled;

  /// Realtime communication
  final bool realtimeCommunicationEnabled;

  /// Deep links
  final bool deepLinkEnabled;

  /// Change language
  final bool changeLanguageEnabled;

  /// Counter
  final bool counterEnabled;

  /// Widget toolkit
  final bool widgetToolkitEnabled;

  /// Dev menu
  final bool devMenuEnabled;

  /// Patrol tests
  final bool patrolTestsEnabled;

  /// CICD
  final bool cicdEnabled;

  /// Uses Firebase
  bool get usesFirebase => analyticsEnabled || pushNotificationsEnabled;
}
