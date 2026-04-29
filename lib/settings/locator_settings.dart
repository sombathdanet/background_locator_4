/// Base location tracking settings.
///
/// This library provides [LocatorSettings] and [LocationAccuracy] for configuring
/// location tracking behavior. [LocatorSettings] serves as the base class for
/// platform-specific settings ([AndroidSettings] and [IOSSettings]), defining
/// common configuration options like accuracy and distance filtering.
///
/// See [LocatorSettings] for usage examples and API documentation.
library;

/// Enum-like class representing location accuracy levels.
///
/// [LocationAccuracy] defines different accuracy levels for location updates,
/// ranging from power-saving (less accurate) to navigation (most accurate).
/// Higher accuracy levels consume more battery.
///
/// Available levels:
/// - [POWERSAVE]: Lowest accuracy, best battery life
/// - [LOW]: Low accuracy
/// - [BALANCED]: Balanced accuracy and battery consumption
/// - [HIGH]: High accuracy
/// - [NAVIGATION]: Highest accuracy, best for navigation (default)
class LocationAccuracy {
  const LocationAccuracy._internal(this.value);

  /// The numeric value representing this accuracy level.
  final int value;

  /// Power-saving mode with lowest accuracy.
  static const POWERSAVE = LocationAccuracy._internal(0);

  /// Low accuracy mode.
  static const LOW = LocationAccuracy._internal(1);

  /// Balanced accuracy and battery consumption.
  static const BALANCED = LocationAccuracy._internal(2);

  /// High accuracy mode.
  static const HIGH = LocationAccuracy._internal(3);

  /// Navigation mode with highest accuracy (default).
  static const NAVIGATION = LocationAccuracy._internal(4);
}

/// Base class for platform-specific location tracking settings.
///
/// [LocatorSettings] provides common configuration options for location tracking
/// that apply to both Android and iOS platforms. Platform-specific settings
/// are provided by [AndroidSettings] and [IOSSettings] subclasses.
///
/// Example:
/// ```dart
/// final settings = LocatorSettings(
///   accuracy: LocationAccuracy.HIGH,
///   distanceFilter: 10,
/// );
/// ```
class LocatorSettings {
  /// The accuracy level for location updates.
  /// Default: [LocationAccuracy.NAVIGATION]
  final LocationAccuracy accuracy;

  /// Minimum distance in meters between location updates.
  /// Location updates are only triggered if the device moves at least
  /// this distance from the last reported location.
  /// Default: 0 meters (all updates are reported)
  final double distanceFilter;

  /// Creates a [LocatorSettings] instance.
  ///
  /// Parameters:
  /// - [accuracy]: The desired accuracy level for location updates.
  /// - [distanceFilter]: Minimum distance in meters to trigger updates.
  const LocatorSettings({required this.accuracy, required this.distanceFilter});
}
