/// Location data transfer objects for the location_tracking package.
///
/// This library provides [LocationDto], a data transfer object that represents
/// a single location update with coordinates, accuracy, altitude, speed, and
/// heading information. It is used to pass location data from the native
/// platform (Android/iOS) to Dart/Flutter code.
library;

import 'dart:io' show Platform;

import 'keys.dart';

/// Data transfer object representing a single location update.
///
/// [LocationDto] contains all the information about a location point including
/// coordinates, accuracy, altitude, speed, and heading. It is used to pass
/// location data from the native platform to the Dart/Flutter code.
///
/// All distance measurements are in meters, speed in meters per second,
/// and heading in degrees (0-360).
///
/// Example:
/// ```dart
/// LocationDto location = LocationDto.fromJson(jsonData);
/// print('Latitude: ${location.latitude}');
/// print('Longitude: ${location.longitude}');
/// print('Accuracy: ${location.accuracy}m');
/// print('Speed: ${location.speed}m/s');
/// ```
class LocationDto {
  /// The latitude coordinate of the location.
  final double latitude;

  /// The longitude coordinate of the location.
  final double longitude;

  /// The accuracy of the location in meters.
  /// Lower values indicate higher accuracy.
  final double accuracy;

  /// The altitude above sea level in meters.
  final double altitude;

  /// The speed of movement in meters per second.
  final double speed;

  /// The accuracy of the speed measurement in meters per second.
  final double speedAccuracy;

  /// The heading (direction) of movement in degrees (0-360).
  /// 0 degrees represents true north.
  final double heading;

  /// The timestamp of the location in milliseconds since epoch.
  final double time;

  /// Whether this location was obtained from a mock provider.
  /// On iOS, this is always false. On Android, it indicates if the location
  /// came from a mock location app.
  final bool isMocked;

  /// The name of the location provider (e.g., 'gps', 'network', 'fused').
  /// Android-specific field.
  final String provider;

  LocationDto._(
    this.latitude,
    this.longitude,
    this.accuracy,
    this.altitude,
    this.speed,
    this.speedAccuracy,
    this.heading,
    this.time,
    this.isMocked,
    this.provider,
  );

  /// Creates a [LocationDto] from a JSON map.
  ///
  /// This factory constructor is used internally to convert location data
  /// received from the native platform into a Dart object.
  ///
  /// Parameters:
  /// - [json]: A map containing location data with keys defined in [Keys].
  ///
  /// Returns:
  /// A new [LocationDto] instance populated with data from the JSON map.
  factory LocationDto.fromJson(Map<dynamic, dynamic> json) {
    bool isLocationMocked =
        Platform.isAndroid ? json[Keys.ARG_IS_MOCKED] : false;
    return LocationDto._(
      json[Keys.ARG_LATITUDE],
      json[Keys.ARG_LONGITUDE],
      json[Keys.ARG_ACCURACY],
      json[Keys.ARG_ALTITUDE],
      json[Keys.ARG_SPEED],
      json[Keys.ARG_SPEED_ACCURACY],
      json[Keys.ARG_HEADING],
      json[Keys.ARG_TIME],
      isLocationMocked,
      json[Keys.ARG_PROVIDER] ?? '',
    );
  }

  /// Converts this [LocationDto] to a JSON map.
  ///
  /// This method serializes the location data into a map format that can be
  /// easily transmitted or stored.
  ///
  /// Returns:
  /// A map representation of this location with string keys and dynamic values.
  Map<String, dynamic> toJson() {
    return {
      Keys.ARG_LATITUDE: this.latitude,
      Keys.ARG_LONGITUDE: this.longitude,
      Keys.ARG_ACCURACY: this.accuracy,
      Keys.ARG_ALTITUDE: this.altitude,
      Keys.ARG_SPEED: this.speed,
      Keys.ARG_SPEED_ACCURACY: this.speedAccuracy,
      Keys.ARG_HEADING: this.heading,
      Keys.ARG_TIME: this.time,
      Keys.ARG_IS_MOCKED: this.isMocked,
      Keys.ARG_PROVIDER: this.provider,
    };
  }

  @override
  String toString() {
    return 'LocationDto{latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, speed: $speed, speedAccuracy: $speedAccuracy, heading: $heading, time: $time, isMocked: $isMocked, provider: $provider}';
  }
}
