/// Platform channel communication constants for the location_tracking plugin.
///
/// This library provides the [Keys] class containing all constant strings
/// used for communication between Dart and native platform code (Android/iOS).
library;

/// Constants used for platform channel communication and data mapping.
///
/// [Keys] defines all the constant strings used for:
/// - Method channel names and method identifiers
/// - Argument keys for passing data between Dart and native code
/// - Settings keys for configuration options
/// - Broadcast message identifiers for background events
///
/// These constants ensure consistent communication between the Flutter plugin
/// and the native Android/iOS implementations.
class Keys {
  /// Platform channel ID for main plugin communication.
  static const String CHANNEL_ID = 'app.yukams/locator_plugin';

  /// Platform channel ID for background service communication.
  static const String BACKGROUND_CHANNEL_ID =
      'app.yukams/locator_plugin_background';

  // Method names for platform channel communication
  /// Method name: Service initialization notification.
  static const String METHOD_SERVICE_INITIALIZED = 'LocatorService.initialized';

  /// Method name: Initialize the location service.
  static const String METHOD_PLUGIN_INITIALIZE_SERVICE =
      'LocatorPlugin.initializeService';

  /// Method name: Register for location updates.
  static const String METHOD_PLUGIN_REGISTER_LOCATION_UPDATE =
      'LocatorPlugin.registerLocationUpdate';

  /// Method name: Unregister from location updates.
  static const String METHOD_PLUGIN_UN_REGISTER_LOCATION_UPDATE =
      'LocatorPlugin.unRegisterLocationUpdate';

  /// Method name: Check if location updates are registered.
  static const String METHOD_PLUGIN_IS_REGISTER_LOCATION_UPDATE =
      'LocatorPlugin.isRegisterLocationUpdate';

  /// Method name: Check if the service is running.
  static const String METHOD_PLUGIN_IS_SERVICE_RUNNING =
      'LocatorPlugin.isServiceRunning';

  /// Method name: Update notification text.
  static const String METHOD_PLUGIN_UPDATE_NOTIFICATION =
      'LocatorPlugin.updateNotification';

  // Argument keys for location data
  /// Argument key: Whether location is from a mock provider.
  static const String ARG_IS_MOCKED = 'is_mocked';

  /// Argument key: Latitude coordinate.
  static const String ARG_LATITUDE = 'latitude';

  /// Argument key: Longitude coordinate.
  static const String ARG_LONGITUDE = 'longitude';

  /// Argument key: Altitude in meters.
  static const String ARG_ALTITUDE = 'altitude';

  /// Argument key: Location accuracy in meters.
  static const String ARG_ACCURACY = 'accuracy';

  /// Argument key: Speed in meters per second.
  static const String ARG_SPEED = 'speed';

  /// Argument key: Speed accuracy in meters per second.
  static const String ARG_SPEED_ACCURACY = 'speed_accuracy';

  /// Argument key: Heading in degrees (0-360).
  static const String ARG_HEADING = 'heading';

  /// Argument key: Timestamp in milliseconds since epoch.
  static const String ARG_TIME = 'time';

  /// Argument key: Location provider name (e.g., 'gps', 'network').
  static const String ARG_PROVIDER = 'provider';

  /// Argument key: Location update callback handle.
  static const String ARG_CALLBACK = 'callback';

  /// Argument key: Notification tap callback handle.
  static const String ARG_NOTIFICATION_CALLBACK = 'notificationCallback';

  /// Argument key: Service initialization callback handle.
  static const String ARG_INIT_CALLBACK = 'initCallback';

  /// Argument key: Data passed to initialization callback.
  static const String ARG_INIT_DATA_CALLBACK = 'initDataCallback';

  /// Argument key: Service disposal callback handle.
  static const String ARG_DISPOSE_CALLBACK = 'disposeCallback';

  /// Argument key: Location data object.
  static const String ARG_LOCATION = 'location';

  /// Argument key: Settings configuration object.
  static const String ARG_SETTINGS = 'settings';

  /// Argument key: Callback dispatcher handle.
  static const String ARG_CALLBACK_DISPATCHER = 'callbackDispatcher';

  // Settings keys
  /// Settings key: Location accuracy level.
  static const String SETTINGS_ACCURACY = 'settings_accuracy';

  /// Settings key: Update interval in seconds.
  static const String SETTINGS_INTERVAL = 'settings_interval';

  /// Settings key: Distance filter in meters.
  static const String SETTINGS_DISTANCE_FILTER = 'settings_distanceFilter';

  /// Settings key: Auto-stop on app background.
  static const String SETTINGS_AUTO_STOP = 'settings_autoStop';

  /// Settings key: Android notification channel name.
  static const String SETTINGS_ANDROID_NOTIFICATION_CHANNEL_NAME =
      'settings_android_notificationChannelName';

  /// Settings key: Android notification title.
  static const String SETTINGS_ANDROID_NOTIFICATION_TITLE =
      'settings_android_notificationTitle';

  /// Settings key: Android notification message.
  static const String SETTINGS_ANDROID_NOTIFICATION_MSG =
      'settings_android_notificationMsg';

  /// Settings key: Android notification expanded message.
  static const String SETTINGS_ANDROID_NOTIFICATION_BIG_MSG =
      'settings_android_notificationBigMsg';

  /// Settings key: Android notification icon name.
  static const String SETTINGS_ANDROID_NOTIFICATION_ICON =
      'settings_android_notificationIcon';

  /// Settings key: Android notification icon color.
  static const String SETTINGS_ANDROID_NOTIFICATION_ICON_COLOR =
      'settings_android_notificationIconColor';

  /// Settings key: Android wake lock time in minutes.
  static const String SETTINGS_ANDROID_WAKE_LOCK_TIME =
      'settings_android_wakeLockTime';

  /// Settings key: Android location client type.
  static const String SETTINGS_ANDROID_LOCATION_CLIENT =
      "settings_android_location_client";

  /// Settings key: iOS background location indicator visibility.
  static const String SETTINGS_IOS_SHOWS_BACKGROUND_LOCATION_INDICATOR =
      'settings_ios_showsBackgroundLocationIndicator';

  /// Settings key: iOS stop tracking on app termination.
  static const String SETTINGS_IOS_STOP_WITH_TERMINATE =
      'settings_ios_stopWithTerminate';

  // Broadcast message identifiers
  /// Broadcast message: Location update received.
  static const String BCM_SEND_LOCATION = 'BCM_SEND_LOCATION';

  /// Broadcast message: Notification clicked.
  static const String BCM_NOTIFICATION_CLICK = 'BCM_NOTIFICATION_CLICK';

  /// Broadcast message: Service initialized.
  static const String BCM_INIT = 'BCM_INIT';

  /// Broadcast message: Service disposed.
  static const String BCM_DISPOSE = 'BCM_DISPOSE';
}
