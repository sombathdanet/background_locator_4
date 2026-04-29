/// Background location tracking API.
///
/// This library provides the [BackgroundLocator] class for managing background
/// location tracking on Android and iOS. Use this to register location update
/// callbacks that continue running even when the app is in the background or
/// terminated.
///
/// See [BackgroundLocator] for usage examples and API documentation.
library;

import 'dart:async';
import 'dart:ui';

import 'package:location_tracking/settings/android_settings.dart';
import 'package:location_tracking/settings/ios_settings.dart';
import 'package:location_tracking/utils/settings_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'auto_stop_handler.dart';
import 'callback_dispatcher.dart';
import 'keys.dart';
import 'location_dto.dart';

/// Main class for managing background location tracking.
///
/// [BackgroundLocator] provides a static interface to control background location
/// tracking on both Android and iOS platforms. It allows you to:
/// - Initialize the location tracking service
/// - Register and unregister location update callbacks
/// - Check if location tracking is active
/// - Update notification text on Android
///
/// Example usage:
/// ```dart
/// // Initialize the service
/// await BackgroundLocator.initialize();
///
/// // Register location updates
/// await BackgroundLocator.registerLocationUpdate(
///   (LocationDto location) {
///     print('Location: ${location.latitude}, ${location.longitude}');
///   },
///   androidSettings: AndroidSettings(),
///   iosSettings: IOSSettings(),
/// );
///
/// // Check if tracking is running
/// bool isRunning = await BackgroundLocator.isServiceRunning();
///
/// // Unregister when done
/// await BackgroundLocator.unRegisterLocationUpdate();
/// ```
class BackgroundLocator {
  static const MethodChannel _channel = const MethodChannel(Keys.CHANNEL_ID);

  /// Initializes the background location tracking service.
  ///
  /// This method must be called before any other BackgroundLocator methods.
  /// It sets up the native platform channels and prepares the service for
  /// receiving location updates.
  ///
  /// Throws a [PlatformException] if initialization fails on the native side.
  static Future<void> initialize() async {
    final CallbackHandle callback =
        PluginUtilities.getCallbackHandle(callbackDispatcher)!;
    await _channel.invokeMethod(Keys.METHOD_PLUGIN_INITIALIZE_SERVICE,
        {Keys.ARG_CALLBACK_DISPATCHER: callback.toRawHandle()});
  }

  static WidgetsBinding? get _widgetsBinding => WidgetsBinding.instance;

  /// Registers a callback to receive location updates in the background.
  ///
  /// This method starts background location tracking and calls [callback] whenever
  /// a new location is available. The callback will be invoked even when the app
  /// is in the background or terminated.
  ///
  /// Parameters:
  /// - [callback]: Function called with each location update. Required.
  /// - [initCallback]: Optional function called when the location service initializes.
  /// - [initDataCallback]: Optional data passed to [initCallback].
  /// - [disposeCallback]: Optional function called when the service is disposed.
  /// - [autoStop]: If true, automatically stops tracking when app goes to background.
  ///   Default is false.
  /// - [androidSettings]: Platform-specific settings for Android. Default uses
  ///   [AndroidSettings] with default values.
  /// - [iosSettings]: Platform-specific settings for iOS. Default uses
  ///   [IOSSettings] with default values.
  ///
  /// Throws a [PlatformException] if registration fails.
  ///
  /// Example:
  /// ```dart
  /// await BackgroundLocator.registerLocationUpdate(
  ///   (location) => print('Got location: $location'),
  ///   initCallback: (data) => print('Service initialized'),
  ///   disposeCallback: () => print('Service disposed'),
  ///   autoStop: true,
  /// );
  /// ```
  static Future<void> registerLocationUpdate(
      void Function(LocationDto) callback,
      {void Function(Map<String, dynamic>)? initCallback,
      Map<String, dynamic> initDataCallback = const {},
      void Function()? disposeCallback,
      bool autoStop = false,
      AndroidSettings androidSettings = const AndroidSettings(),
      IOSSettings iosSettings = const IOSSettings()}) async {
    if (autoStop) {
      _widgetsBinding!.addObserver(AutoStopHandler());
    }

    final args = SettingsUtil.getArgumentsMap(
        callback: callback,
        initCallback: initCallback,
        initDataCallback: initDataCallback,
        disposeCallback: disposeCallback,
        androidSettings: androidSettings,
        iosSettings: iosSettings);

    await _channel.invokeMethod(
        Keys.METHOD_PLUGIN_REGISTER_LOCATION_UPDATE, args);
  }

  /// Unregisters the location update callback and stops background tracking.
  ///
  /// After calling this method, no more location updates will be received.
  /// The location service will be stopped on both Android and iOS.
  ///
  /// Throws a [PlatformException] if unregistration fails.
  static Future<void> unRegisterLocationUpdate() async {
    await _channel.invokeMethod(Keys.METHOD_PLUGIN_UN_REGISTER_LOCATION_UPDATE);
  }

  /// Checks if a location update callback is currently registered.
  ///
  /// Returns true if [registerLocationUpdate] has been called and the service
  /// is actively tracking location. Returns false if the service is not registered.
  ///
  /// Returns:
  /// A [Future] that resolves to true if location tracking is registered, false otherwise.
  static Future<bool> isRegisterLocationUpdate() async {
    return (await _channel
        .invokeMethod<bool>(Keys.METHOD_PLUGIN_IS_REGISTER_LOCATION_UPDATE))!;
  }

  /// Checks if the background location tracking service is currently running.
  ///
  /// Returns true if the location service is active and running in the background.
  /// This is useful to determine the current state of the service.
  ///
  /// Returns:
  /// A [Future] that resolves to true if the service is running, false otherwise.
  static Future<bool> isServiceRunning() async {
    return (await _channel
        .invokeMethod<bool>(Keys.METHOD_PLUGIN_IS_SERVICE_RUNNING))!;
  }

  /// Updates the notification text displayed while tracking in the background on Android.
  ///
  /// This method allows you to dynamically update the notification title and message
  /// that appears in the notification drawer while the app is tracking location in
  /// the background. This is Android-specific and has no effect on iOS.
  ///
  /// Parameters:
  /// - [title]: Optional new notification title. If null, the current title is unchanged.
  /// - [msg]: Optional new notification message. If null, the current message is unchanged.
  /// - [bigMsg]: Optional new expanded notification message. If null, the current
  ///   expanded message is unchanged.
  ///
  /// Example:
  /// ```dart
  /// await BackgroundLocator.updateNotificationText(
  ///   title: 'Tracking Active',
  ///   msg: 'Your location is being tracked',
  /// );
  /// ```
  static Future<void> updateNotificationText(
      {String? title, String? msg, String? bigMsg}) async {
    final Map<String, dynamic> arg = {};

    if (title != null) {
      arg[Keys.SETTINGS_ANDROID_NOTIFICATION_TITLE] = title;
    }

    if (msg != null) {
      arg[Keys.SETTINGS_ANDROID_NOTIFICATION_MSG] = msg;
    }

    if (bigMsg != null) {
      arg[Keys.SETTINGS_ANDROID_NOTIFICATION_BIG_MSG] = bigMsg;
    }

    await _channel.invokeMethod(Keys.METHOD_PLUGIN_UPDATE_NOTIFICATION, arg);
  }
}
