/// iOS-specific location tracking settings.
///
/// This library provides [IOSSettings] for configuring background location
/// tracking on iOS. Use this class to customize the background location
/// indicator visibility and app termination behavior for iOS devices.
///
/// See [IOSSettings] for usage examples and API documentation.
library;

import 'package:location_tracking/keys.dart';

import 'locator_settings.dart';

/// iOS-specific settings for background location tracking.
///
/// [IOSSettings] extends [LocatorSettings] and provides iOS-specific
/// configuration options for location tracking. It allows you to control
/// the background location indicator and app termination behavior.
///
/// Example:
/// ```dart
/// final iosSettings = IOSSettings(
///   accuracy: LocationAccuracy.NAVIGATION,
///   distanceFilter: 10,
///   showsBackgroundLocationIndicator: true,
///   stopWithTerminate: false,
/// );
/// ```
class IOSSettings extends LocatorSettings {
  /// Whether to show the blue background location indicator in the status bar.
  ///
  /// When true, a blue bar or pill appears in the status bar to indicate
  /// that the app is using location services in the background.
  /// Default: false
  final bool showsBackgroundLocationIndicator;

  /// Whether to stop location tracking when the app is terminated.
  ///
  /// When true, location tracking stops if the user force-closes the app.
  /// When false, location tracking continues even after app termination.
  /// Default: false
  final bool stopWithTerminate;
  
  /// Creates an [IOSSettings] instance.
  ///
  /// Parameters:
  /// - [accuracy]: The accuracy of location updates. Default is [LocationAccuracy.NAVIGATION].
  /// - [distanceFilter]: Minimum distance in meters to trigger a location update. Default is 0 meters.
  /// - [showsBackgroundLocationIndicator]: Whether to show the blue background location indicator.
  ///   Default is false.
  /// - [stopWithTerminate]: Whether to stop tracking when the app is terminated.
  ///   Default is false.
  const IOSSettings({
    LocationAccuracy accuracy = LocationAccuracy.NAVIGATION,
    double distanceFilter = 0,
    this.showsBackgroundLocationIndicator = false,
    this.stopWithTerminate = false,
  }) : super(accuracy: accuracy, distanceFilter: distanceFilter); //minutes

  /// Converts this [IOSSettings] to a map for native platform communication.
  ///
  /// Returns:
  /// A map containing all iOS-specific settings with keys defined in [Keys].
  Map<String, dynamic> toMap() {
    return {
      Keys.SETTINGS_ACCURACY: accuracy.value,
      Keys.SETTINGS_DISTANCE_FILTER: distanceFilter,
      Keys.SETTINGS_IOS_SHOWS_BACKGROUND_LOCATION_INDICATOR:
          showsBackgroundLocationIndicator,
      Keys.SETTINGS_IOS_STOP_WITH_TERMINATE: stopWithTerminate,
    };
  }
}
