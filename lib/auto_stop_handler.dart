/// Automatic location tracking lifecycle management.
///
/// This library provides [AutoStopHandler], a widget binding observer that
/// automatically stops background location tracking when the app lifecycle
/// changes. Use this to conserve battery by stopping location updates when
/// the user is not actively using the app.
library;

import 'package:flutter/material.dart';

import 'background_locator.dart';

/// Handles automatic stopping of location tracking when the app lifecycle changes.
///
/// [AutoStopHandler] is a [WidgetsBindingObserver] that automatically stops
/// background location tracking when the app transitions to inactive, paused,
/// detached, or hidden states. This is useful when you want to conserve battery
/// by stopping location updates when the user is not actively using the app.
///
/// This handler is automatically registered when [BackgroundLocator.registerLocationUpdate]
/// is called with `autoStop: true`.
///
/// Example:
/// ```dart
/// // Automatically stop tracking when app goes to background
/// await BackgroundLocator.registerLocationUpdate(
///   (location) => print('Location: $location'),
///   autoStop: true,
/// );
/// ```
class AutoStopHandler extends WidgetsBindingObserver {
  /// Called when the app lifecycle state changes.
  ///
  /// Stops location tracking when the app enters inactive, paused, detached,
  /// or hidden states. Resumes normal operation when the app is resumed.
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        await BackgroundLocator.unRegisterLocationUpdate();
        break;
      case AppLifecycleState.resumed:
        break;
    }
  }
}
