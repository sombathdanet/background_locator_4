# location_tracking

[![pub package](https://img.shields.io/pub/v/location_tracking.svg)](https://pub.dev/packages/location_tracking)

A Flutter plugin for receiving location updates even when the app is terminated. Works on both iOS and Android platforms with full support for background execution.

## Features

- 🌍 Continuous location tracking in background
- 📱 Works even when app is killed/terminated
- 🔋 Battery-efficient location updates
- 🎯 Configurable accuracy and update intervals
- 🔔 Android notification support
- 📍 Distance filter to reduce unnecessary updates
- 🔄 Auto-restart after device reboot (Android)
- ⚙️ Platform-specific settings for iOS and Android

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  location_tracking: ^2.0.7
```

Then run:

```bash
flutter pub get
```

## Platform Setup

### Android

Add the following permissions to your `AndroidManifest.xml`:

```xml
<manifest>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
</manifest>
```

### iOS

Add the following to your `Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when in use</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs access to location in background</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location in background</string>
<key>UIBackgroundModes</key>
<array>
    <string>location</string>
    <string>fetch</string>
</array>
```

## Usage

### Basic Example

```dart
import 'package:location_tracking/background_locator.dart';
import 'package:location_tracking/location_dto.dart';
import 'package:location_tracking/settings/android_settings.dart';
import 'package:location_tracking/settings/ios_settings.dart';
import 'package:location_tracking/settings/locator_settings.dart';

// Initialize the plugin
await BackgroundLocator.initialize();

// Register location update
await BackgroundLocator.registerLocationUpdate(
  locationCallback,
  initCallback: initCallback,
  disposeCallback: disposeCallback,
  androidSettings: AndroidSettings(
    accuracy: LocationAccuracy.NAVIGATION,
    interval: 5,
    distanceFilter: 0,
    androidNotificationSettings: AndroidNotificationSettings(
      notificationChannelName: 'Location tracking',
      notificationTitle: 'Start Location Tracking',
      notificationMsg: 'Track location in background',
      notificationBigMsg: 'Background location is on to keep the app up-to-date with your location.',
    ),
  ),
  iosSettings: IOSSettings(
    accuracy: LocationAccuracy.NAVIGATION,
    distanceFilter: 0,
  ),
);

// Callback functions (must be top-level or static)
@pragma('vm:entry-point')
static void locationCallback(LocationDto locationDto) {
  print('Location: ${locationDto.latitude}, ${locationDto.longitude}');
}

@pragma('vm:entry-point')
static void initCallback(Map<dynamic, dynamic> params) {
  print('Callback initialized');
}

@pragma('vm:entry-point')
static void disposeCallback() {
  print('Callback disposed');
}

// Stop location updates
await BackgroundLocator.unRegisterLocationUpdate();
```

## Configuration Options

### Android Settings

- `accuracy`: Location accuracy (POWERLOW, LOW, BALANCED, HIGH, NAVIGATION)
- `interval`: Update interval in seconds
- `distanceFilter`: Minimum distance (meters) to trigger update
- `androidNotificationSettings`: Notification configuration for foreground service

### iOS Settings

- `accuracy`: Location accuracy
- `distanceFilter`: Minimum distance (meters) to trigger update
- `showsBackgroundLocationIndicator`: Show blue bar indicator
- `stopWithTerminate`: Stop tracking when app terminates

## Additional Resources

For more detailed information, check out:
- [Example app](example/) - Complete working example
- [API Documentation](https://pub.dev/documentation/location_tracking/latest/)

## Important Notes

- Callback functions must be top-level functions or static methods
- Use `@pragma('vm:entry-point')` annotation on callbacks
- Request location permissions before starting tracking
- On Android 10+, background location permission requires user approval
- iOS requires "Always" location permission for background tracking

## Troubleshooting

### Android
- Ensure all required permissions are in AndroidManifest.xml
- Check that notification settings are properly configured
- Verify foreground service is running

### iOS
- Ensure Info.plist has all required location keys
- Check that background modes include "location"
- Verify "Always" permission is granted

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributors

Thanks to all who have contributed to this plugin:
* Original creators and maintainers of background_locator
* [Yukams](https://github.com/Yukams) - background_locator_2 fork
* [Rekab](https://github.com/rekabhq) - Original background_locator creator
* All other contributors who have helped improve this package

## Credits

This package is based on the excellent work of the background_locator community. Special thanks to:
- Natnael Seyoum and Tekletsadik Aknaw for background_locator_3
- Yukams for background_locator_2
- The original Rekab team for creating background_locator
