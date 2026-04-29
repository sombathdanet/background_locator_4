# Setup Guide for location_tracking

This guide will help you set up and configure the `location_tracking` package in your Flutter project.

## Table of Contents

1. [Installation](#installation)
2. [Android Setup](#android-setup)
3. [iOS Setup](#ios-setup)
4. [Basic Implementation](#basic-implementation)
5. [Advanced Configuration](#advanced-configuration)
6. [Troubleshooting](#troubleshooting)

## Installation

### Step 1: Add Dependency

Add `location_tracking` to your `pubspec.yaml`:

```yaml
dependencies:
  location_tracking: ^2.0.7
  permission_handler: ^11.3.1  # For handling permissions
```

### Step 2: Install Packages

```bash
flutter pub get
```

## Android Setup

### Step 1: Update AndroidManifest.xml

Open `android/app/src/main/AndroidManifest.xml` and add the following permissions:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Location Permissions -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    
    <!-- Background Location (Android 10+) -->
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    
    <!-- Foreground Service -->
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION" />
    
    <!-- Wake Lock -->
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    
    <!-- Boot Receiver (Optional - for restart on reboot) -->
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>

    <application
        android:label="Your App Name"
        android:icon="@mipmap/ic_launcher">
        
        <!-- Your activities here -->
        
    </application>
</manifest>
```

### Step 2: Update build.gradle

Ensure your `android/app/build.gradle` has the correct SDK versions:

```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

### Step 3: Add Notification Icon (Optional)

For a custom notification icon:

1. Create a notification icon (must be white on transparent background)
2. Place it in `android/app/src/main/res/drawable/`
3. Name it something like `notification_icon.png`
4. Reference it in your code: `notificationIcon: 'notification_icon'`

## iOS Setup

### Step 1: Update Info.plist

Open `ios/Runner/Info.plist` and add the following keys:

```xml
<dict>
    <!-- Existing keys... -->
    
    <!-- Location Permissions -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app needs access to your location when in use</string>
    
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>This app needs access to your location in the background to track your position</string>
    
    <key>NSLocationAlwaysUsageDescription</key>
    <string>This app needs access to your location in the background</string>
    
    <!-- Background Modes -->
    <key>UIBackgroundModes</key>
    <array>
        <string>location</string>
        <string>fetch</string>
        <string>processing</string>
    </array>
</dict>
```

### Step 2: Update Podfile

Ensure your `ios/Podfile` has the correct platform version:

```ruby
platform :ios, '12.0'
```

### Step 3: Install Pods

```bash
cd ios
pod install
cd ..
```

## Basic Implementation

### Step 1: Create Callback File

Create a new file `lib/location_callbacks.dart`:

```dart
import 'package:location_tracking/location_dto.dart';

// IMPORTANT: These must be top-level functions (not inside a class)
// and must have the @pragma annotation

@pragma('vm:entry-point')
void locationCallback(LocationDto locationDto) {
  print('Location Update:');
  print('Latitude: ${locationDto.latitude}');
  print('Longitude: ${locationDto.longitude}');
  print('Accuracy: ${locationDto.accuracy}');
  print('Altitude: ${locationDto.altitude}');
  print('Speed: ${locationDto.speed}');
  print('Heading: ${locationDto.heading}');
  
  // TODO: Save to database, send to server, etc.
}

@pragma('vm:entry-point')
void initCallback(Map<dynamic, dynamic> params) {
  print('Background location service initialized');
  print('Init params: $params');
  
  // TODO: Initialize any resources needed for background tracking
}

@pragma('vm:entry-point')
void disposeCallback() {
  print('Background location service disposed');
  
  // TODO: Clean up resources
}
```

### Step 2: Initialize and Start Tracking

In your main app file:

```dart
import 'package:flutter/material.dart';
import 'package:location_tracking/background_locator.dart';
import 'package:location_tracking/settings/android_settings.dart';
import 'package:location_tracking/settings/ios_settings.dart';
import 'package:location_tracking/settings/locator_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'location_callbacks.dart';

class LocationService {
  static Future<void> initialize() async {
    await BackgroundLocator.initialize();
  }
  
  static Future<bool> requestPermissions() async {
    // Request location permission
    var status = await Permission.location.request();
    
    if (status.isGranted) {
      // For Android 10+, also request background location
      if (await Permission.locationAlways.isDenied) {
        status = await Permission.locationAlways.request();
      }
    }
    
    return status.isGranted;
  }
  
  static Future<void> startTracking() async {
    await BackgroundLocator.registerLocationUpdate(
      locationCallback,
      initCallback: initCallback,
      initDataCallback: {
        'userId': 'user123',
        'sessionId': 'session456',
      },
      disposeCallback: disposeCallback,
      androidSettings: AndroidSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        interval: 5,
        distanceFilter: 10,
        androidNotificationSettings: AndroidNotificationSettings(
          notificationChannelName: 'Location Tracking',
          notificationTitle: 'Tracking Location',
          notificationMsg: 'Your location is being tracked',
          notificationBigMsg: 'Background location tracking is active',
          notificationIconColor: Colors.blue,
        ),
      ),
      iosSettings: IOSSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        distanceFilter: 10,
        showsBackgroundLocationIndicator: true,
      ),
    );
  }
  
  static Future<void> stopTracking() async {
    await BackgroundLocator.unRegisterLocationUpdate();
  }
  
  static Future<bool> isTracking() async {
    return await BackgroundLocator.isServiceRunning();
  }
}

// Usage in your widget
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isTracking = false;
  
  @override
  void initState() {
    super.initState();
    _initializeService();
  }
  
  Future<void> _initializeService() async {
    await LocationService.initialize();
    final isTracking = await LocationService.isTracking();
    setState(() {
      _isTracking = isTracking;
    });
  }
  
  Future<void> _toggleTracking() async {
    if (_isTracking) {
      await LocationService.stopTracking();
      setState(() {
        _isTracking = false;
      });
    } else {
      final hasPermission = await LocationService.requestPermissions();
      if (hasPermission) {
        await LocationService.startTracking();
        setState(() {
          _isTracking = true;
        });
      } else {
        // Show permission denied message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permission denied')),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isTracking ? 'Tracking Active' : 'Tracking Inactive',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleTracking,
              child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Advanced Configuration

### Location Accuracy Options

```dart
LocationAccuracy.POWERLOW    // Lowest accuracy, best battery
LocationAccuracy.LOW         // Low accuracy
LocationAccuracy.BALANCED    // Balanced accuracy and battery
LocationAccuracy.HIGH        // High accuracy
LocationAccuracy.NAVIGATION  // Best accuracy, most battery usage
```

### Update Interval

Control how often you receive updates:

```dart
AndroidSettings(
  interval: 5,  // Update every 5 seconds
)
```

### Distance Filter

Only receive updates when device moves:

```dart
AndroidSettings(
  distanceFilter: 10,  // Update only when moved 10 meters
)
```

### Custom Notification

```dart
AndroidNotificationSettings(
  notificationChannelName: 'My Channel',
  notificationTitle: 'Custom Title',
  notificationMsg: 'Custom message',
  notificationBigMsg: 'Detailed message shown when expanded',
  notificationIcon: 'my_icon',  // Icon in drawable folder
  notificationIconColor: Colors.green,
)
```

### iOS Background Indicator

```dart
IOSSettings(
  showsBackgroundLocationIndicator: true,  // Show blue bar on iOS
)
```

## Troubleshooting

### Android Issues

**Problem**: Location updates stop when app is killed

**Solutions**:
- Ensure foreground service notification is configured
- Check battery optimization settings
- Verify all permissions are granted
- Test on a real device (not emulator)

**Problem**: Notification doesn't appear

**Solutions**:
- Check AndroidManifest.xml has FOREGROUND_SERVICE permission
- Verify notification channel name is set
- Check device notification settings

### iOS Issues

**Problem**: Location updates stop in background

**Solutions**:
- Verify Info.plist has all required keys
- Check that "Always" permission is granted
- Ensure background modes include "location"
- Test on a real device

**Problem**: Permission dialog doesn't show

**Solutions**:
- Check Info.plist has usage description strings
- Ensure you're requesting the right permission level
- Try uninstalling and reinstalling the app

### General Issues

**Problem**: Callbacks not being called

**Solutions**:
- Ensure callbacks are top-level functions (not inside classes)
- Add `@pragma('vm:entry-point')` annotation
- Check that initialize() was called before registerLocationUpdate()
- Verify permissions are granted

**Problem**: High battery usage

**Solutions**:
- Increase update interval
- Increase distance filter
- Use lower accuracy setting
- Stop tracking when not needed

## Best Practices

1. **Always request permissions before starting tracking**
2. **Use appropriate accuracy for your use case** (higher accuracy = more battery)
3. **Set reasonable update intervals** (more frequent = more battery)
4. **Use distance filter** to avoid updates when stationary
5. **Stop tracking when not needed**
6. **Test on real devices** (emulators don't simulate background behavior well)
7. **Handle permission denials gracefully**
8. **Provide clear notification messages** to users
9. **Save location data efficiently** (batch updates, compress data)
10. **Monitor battery usage** and adjust settings accordingly

## Testing Checklist

- [ ] Permissions requested and granted
- [ ] Location updates received in foreground
- [ ] Location updates received in background
- [ ] Location updates received when app is killed
- [ ] Notification appears on Android
- [ ] Notification can be customized
- [ ] Service stops when requested
- [ ] Service restarts after device reboot (if configured)
- [ ] Battery usage is acceptable
- [ ] Works on both Android and iOS
- [ ] Works on different OS versions

## Additional Resources

- [Main README](README.md)
- [Example App](example/)
- [Publishing Guide](PUBLISHING.md)
- [Flutter Location Best Practices](https://flutter.dev/docs/development/data-and-backend/location)
- [Android Location Guide](https://developer.android.com/training/location)
- [iOS Location Guide](https://developer.apple.com/documentation/corelocation)
