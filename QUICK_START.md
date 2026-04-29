# Quick Start Guide - location_tracking

Get up and running with background location tracking in 5 minutes!

## 1. Install Package

Add to `pubspec.yaml`:

```yaml
dependencies:
  location_tracking: ^2.0.7
  permission_handler: ^11.3.1
```

Run:
```bash
flutter pub get
```

## 2. Configure Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION" />
    
    <application>
        <!-- Your app content -->
    </application>
</manifest>
```

## 3. Configure iOS

Add to `ios/Runner/Info.plist`:

```xml
<dict>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>We need your location when using the app</string>
    
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>We need your location in the background</string>
    
    <key>UIBackgroundModes</key>
    <array>
        <string>location</string>
    </array>
</dict>
```

## 4. Create Callbacks

Create `lib/location_callbacks.dart`:

```dart
import 'package:location_tracking/location_dto.dart';

@pragma('vm:entry-point')
void locationCallback(LocationDto location) {
  print('📍 Location: ${location.latitude}, ${location.longitude}');
}

@pragma('vm:entry-point')
void initCallback(Map<dynamic, dynamic> params) {
  print('✅ Location service started');
}

@pragma('vm:entry-point')
void disposeCallback() {
  print('🛑 Location service stopped');
}
```

## 5. Implement in Your App

```dart
import 'package:flutter/material.dart';
import 'package:location_tracking/background_locator.dart';
import 'package:location_tracking/settings/android_settings.dart';
import 'package:location_tracking/settings/ios_settings.dart';
import 'package:location_tracking/settings/locator_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'location_callbacks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundLocator.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _isTracking = false;

  Future<void> _startTracking() async {
    // Request permissions
    final status = await Permission.location.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permission denied')),
      );
      return;
    }

    // Request background permission (Android 10+)
    await Permission.locationAlways.request();

    // Start tracking
    await BackgroundLocator.registerLocationUpdate(
      locationCallback,
      initCallback: initCallback,
      disposeCallback: disposeCallback,
      androidSettings: AndroidSettings(
        accuracy: LocationAccuracy.HIGH,
        interval: 5,
        distanceFilter: 10,
        androidNotificationSettings: AndroidNotificationSettings(
          notificationChannelName: 'Location Tracking',
          notificationTitle: 'Tracking Active',
          notificationMsg: 'Your location is being tracked',
        ),
      ),
      iosSettings: IOSSettings(
        accuracy: LocationAccuracy.HIGH,
        distanceFilter: 10,
      ),
    );

    setState(() => _isTracking = true);
  }

  Future<void> _stopTracking() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    setState(() => _isTracking = false);
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
            Icon(
              _isTracking ? Icons.location_on : Icons.location_off,
              size: 100,
              color: _isTracking ? Colors.green : Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              _isTracking ? 'Tracking Active' : 'Tracking Inactive',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isTracking ? _stopTracking : _startTracking,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                _isTracking ? 'Stop Tracking' : 'Start Tracking',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## 6. Run Your App

```bash
flutter run
```

## That's It! 🎉

Your app now tracks location in the background!

## Next Steps

- **Customize Settings**: Adjust accuracy, interval, and distance filter
- **Save Location Data**: Store locations in a database or send to a server
- **Handle Errors**: Add proper error handling and edge cases
- **Optimize Battery**: Fine-tune settings for your use case

## Common Customizations

### Change Update Frequency

```dart
AndroidSettings(
  interval: 10,  // Update every 10 seconds instead of 5
)
```

### Change Accuracy

```dart
AndroidSettings(
  accuracy: LocationAccuracy.BALANCED,  // Use less battery
)
```

### Increase Distance Filter

```dart
AndroidSettings(
  distanceFilter: 50,  // Only update when moved 50 meters
)
```

### Custom Notification

```dart
AndroidNotificationSettings(
  notificationTitle: 'My Custom Title',
  notificationMsg: 'My custom message',
  notificationIconColor: Colors.blue,
)
```

## Troubleshooting

### Location updates not working?

1. Check permissions are granted
2. Test on a real device (not emulator)
3. Check notification appears on Android
4. Verify Info.plist is correct on iOS

### High battery usage?

1. Increase update interval
2. Increase distance filter
3. Use lower accuracy
4. Stop tracking when not needed

## Need More Help?

- 📖 [Full Documentation](README.md)
- 🔧 [Setup Guide](SETUP_GUIDE.md)
- 💡 [Example App](example/)
- 🐛 [Report Issues](https://github.com/sombathdanet/location-tracking/issues)

---

**Happy Tracking! 🚀**
