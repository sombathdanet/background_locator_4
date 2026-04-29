/// Android-specific location tracking settings.
///
/// This library provides [AndroidSettings] and [AndroidNotificationSettings]
/// for configuring background location tracking on Android. Use these classes
/// to customize notification appearance, wake lock duration, update intervals,
/// and location provider selection for Android devices.
///
/// See [AndroidSettings] for usage examples and API documentation.
library;

import 'package:location_tracking/keys.dart';
import 'package:location_tracking/settings/locator_settings.dart';
import 'package:flutter/material.dart';

/// Enum for selecting the location provider on Android.
///
/// - [LocationClient.google]: Uses Google Play Services for location updates.
///   Generally more accurate and battery-efficient.
/// - [LocationClient.android]: Uses Android's native location services.
enum LocationClient { google, android }

/// Configuration for Android notification settings.
///
/// [AndroidNotificationSettings] allows you to customize the notification
/// that appears in the notification drawer while the app is tracking location
/// in the background. This notification is required on Android to keep the
/// location service running.
///
/// Example:
/// ```dart
/// final notificationSettings = AndroidNotificationSettings(
///   notificationTitle: 'Tracking Your Location',
///   notificationMsg: 'Location tracking is active',
///   notificationIcon: 'ic_launcher',
/// );
/// ```
class AndroidNotificationSettings {
  /// The name of the notification channel.
  /// Used for grouping notifications on Android 8.0+.
  final String notificationChannelName;

  /// The title displayed in the notification.
  /// Default: 'Start Location Tracking'
  final String notificationTitle;

  /// The message displayed in the notification.
  /// Default: 'Track location in background'
  final String notificationMsg;

  /// The expanded message shown when the notification is expanded.
  /// Default: 'Background location is on to keep the app up-to-date with your location...'
  final String notificationBigMsg;

  /// The icon name for the notification.
  /// Should be located in the 'mipmap' directory.
  /// Must have a transparent background and black/white shape to comply with Android rules.
  /// Default: app icon
  final String notificationIcon;

  /// The color of the notification icon in the notification drawer.
  /// Default: Colors.grey
  final Color notificationIconColor;

  /// Optional callback triggered when the notification is tapped.
  final VoidCallback? notificationTapCallback;

  /// Creates an [AndroidNotificationSettings] instance.
  ///
  /// All parameters are optional and have sensible defaults.
  const AndroidNotificationSettings(
      {this.notificationChannelName = 'Location tracking',
      this.notificationTitle = 'Start Location Tracking',
      this.notificationMsg = 'Track location in background',
      this.notificationBigMsg =
          'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
      this.notificationIcon = '',
      this.notificationIconColor = Colors.grey,
      this.notificationTapCallback});
}

/// Android-specific settings for background location tracking.
///
/// [AndroidSettings] extends [LocatorSettings] and provides Android-specific
/// configuration options for location tracking, including notification settings,
/// wake lock duration, update interval, and location provider selection.
///
/// Example:
/// ```dart
/// final androidSettings = AndroidSettings(
///   accuracy: LocationAccuracy.NAVIGATION,
///   interval: 5,
///   distanceFilter: 10,
///   wakeLockTime: 60,
///   client: LocationClient.google,
///   androidNotificationSettings: AndroidNotificationSettings(
///     notificationTitle: 'Tracking Active',
///   ),
/// );
/// ```
class AndroidSettings extends LocatorSettings {
  /// Notification settings for the background service.
  final AndroidNotificationSettings androidNotificationSettings;

  /// Duration in minutes that the service will stay alive in the background.
  /// Default: 60 minutes
  final int wakeLockTime;

  /// Interval in seconds between location updates.
  /// Default: 5 seconds
  final int interval;

  /// The location provider to use for obtaining location updates.
  /// Default: [LocationClient.google]
  final LocationClient client;

  /// Creates an [AndroidSettings] instance.
  ///
  /// Parameters:
  /// - [accuracy]: The accuracy of location updates. Default is [LocationAccuracy.NAVIGATION].
  /// - [interval]: Interval in seconds between location updates. Default is 5 seconds.
  /// - [distanceFilter]: Minimum distance in meters to trigger a location update. Default is 0 meters.
  /// - [androidNotificationSettings]: Customization for the background notification.
  /// - [wakeLockTime]: Duration in minutes to keep the service alive. Default is 60 minutes.
  /// - [client]: Location provider to use. Default is [LocationClient.google].
  const AndroidSettings(
      {LocationAccuracy accuracy = LocationAccuracy.NAVIGATION,
      this.interval = 5,
      double distanceFilter = 0,
      this.androidNotificationSettings = const AndroidNotificationSettings(),
      this.wakeLockTime = 60,
      this.client = LocationClient.google})
      : super(accuracy: accuracy, distanceFilter: distanceFilter);

  /// Converts this [AndroidSettings] to a map for native platform communication.
  ///
  /// Returns:
  /// A map containing all Android-specific settings with keys defined in [Keys].
  Map<String, dynamic> toMap() {
    return {
      Keys.SETTINGS_ACCURACY: accuracy.value,
      Keys.SETTINGS_INTERVAL: interval,
      Keys.SETTINGS_DISTANCE_FILTER: distanceFilter,
      Keys.SETTINGS_ANDROID_WAKE_LOCK_TIME: wakeLockTime,
      Keys.SETTINGS_ANDROID_NOTIFICATION_CHANNEL_NAME:
          androidNotificationSettings.notificationChannelName,
      Keys.SETTINGS_ANDROID_NOTIFICATION_TITLE:
          androidNotificationSettings.notificationTitle,
      Keys.SETTINGS_ANDROID_NOTIFICATION_MSG:
          androidNotificationSettings.notificationMsg,
      Keys.SETTINGS_ANDROID_NOTIFICATION_BIG_MSG:
          androidNotificationSettings.notificationBigMsg,
      Keys.SETTINGS_ANDROID_NOTIFICATION_ICON:
          androidNotificationSettings.notificationIcon,
      Keys.SETTINGS_ANDROID_NOTIFICATION_ICON_COLOR:
          androidNotificationSettings.notificationIconColor.toARGB32(),
      Keys.SETTINGS_ANDROID_LOCATION_CLIENT: client.index
    };
  }
}
