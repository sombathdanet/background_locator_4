# Background Locator 2 - Example App

This example demonstrates how to use the `background_locator_2` plugin to track location in the background.

## Features Demonstrated

- ✅ Initialize background location tracking
- ✅ Request location permissions
- ✅ Start/Stop location updates
- ✅ Receive location updates in background
- ✅ Display location data in UI
- ✅ Configure Android notification
- ✅ Handle iOS background location

## Running the Example

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run on Android:**
   ```bash
   flutter run
   ```

3. **Run on iOS:**
   ```bash
   cd ios
   pod install
   cd ..
   flutter run
   ```

## How It Works

### 1. Initialization

The app initializes the background locator when it starts:

```dart
await BackgroundLocator.initialize();
```

### 2. Permission Request

Before starting location tracking, the app requests necessary permissions:

```dart
final access = await LocationPermissions().requestPermissions();
```

### 3. Start Tracking

Location tracking is started with custom settings:

```dart
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
    ),
  ),
  iosSettings: IOSSettings(
    accuracy: LocationAccuracy.NAVIGATION,
    distanceFilter: 0,
  ),
);
```

### 4. Callback Functions

The app defines three callback functions:

- **locationCallback**: Called when a new location is received
- **initCallback**: Called when the background service initializes
- **disposeCallback**: Called when the background service is disposed

These must be top-level or static functions with the `@pragma('vm:entry-point')` annotation.

### 5. Stop Tracking

To stop location tracking:

```dart
await BackgroundLocator.unRegisterLocationUpdate();
```

## Testing Background Location

### Android

1. Start the app and begin tracking
2. Press the home button or switch to another app
3. The notification should remain visible
4. Location updates continue in the background
5. Check the app to see updated locations

### iOS

1. Start the app and begin tracking
2. Press the home button
3. A blue bar may appear indicating background location usage
4. Location updates continue in the background
5. Return to the app to see updated locations

## Troubleshooting

### Android

**Issue**: Location updates stop when app is killed

**Solution**: 
- Ensure foreground service notification is configured
- Check that all permissions are granted
- Verify device isn't in battery optimization mode

**Issue**: Notification doesn't appear

**Solution**:
- Check notification settings in AndroidManifest.xml
- Verify notification channel is properly configured
- Ensure FOREGROUND_SERVICE permission is granted

### iOS

**Issue**: Location updates stop in background

**Solution**:
- Verify Info.plist has all required keys
- Check that "Always" location permission is granted
- Ensure background modes include "location"

**Issue**: Blue bar doesn't appear

**Solution**:
- Set `showsBackgroundLocationIndicator: true` in IOSSettings
- This is expected behavior on iOS 11+

## File Structure

```
example/
├── lib/
│   ├── main.dart                          # Main app entry point
│   ├── location_service_repository.dart   # Location service logic
│   └── file_manager.dart                  # File handling utilities
├── android/
│   └── app/src/main/AndroidManifest.xml  # Android permissions
├── ios/
│   └── Runner/Info.plist                  # iOS permissions
└── pubspec.yaml                           # Dependencies
```

## Key Files

### main.dart
Contains the UI and main app logic. Shows how to:
- Initialize the plugin
- Request permissions
- Start/stop tracking
- Display location data

### location_service_repository.dart
Contains the callback functions that run in the background:
- `locationCallback`: Processes location updates
- `initCallback`: Initializes background service
- `disposeCallback`: Cleans up when service stops

### file_manager.dart
Utility for saving location data to files (optional feature).

## Configuration

### Android Notification

Customize the notification shown during background tracking:

```dart
androidNotificationSettings: AndroidNotificationSettings(
  notificationChannelName: 'Location tracking',
  notificationTitle: 'Your Title',
  notificationMsg: 'Your message',
  notificationBigMsg: 'Detailed message',
  notificationIconColor: Colors.blue,
),
```

### Location Accuracy

Choose accuracy level based on your needs:

- `LocationAccuracy.POWERLOW` - Low power, less accurate
- `LocationAccuracy.LOW` - Balanced power and accuracy
- `LocationAccuracy.BALANCED` - Good accuracy
- `LocationAccuracy.HIGH` - High accuracy
- `LocationAccuracy.NAVIGATION` - Best accuracy for navigation

### Update Interval

Control how often location updates are received:

```dart
interval: 5,  // Update every 5 seconds
```

### Distance Filter

Only receive updates when device moves a certain distance:

```dart
distanceFilter: 10,  // Update only when moved 10 meters
```

## Best Practices

1. **Request permissions properly**: Always check and request permissions before starting tracking
2. **Use appropriate accuracy**: Higher accuracy drains battery faster
3. **Set reasonable intervals**: More frequent updates = more battery usage
4. **Use distance filter**: Reduces unnecessary updates when stationary
5. **Stop tracking when not needed**: Always unregister when tracking is no longer required
6. **Handle errors gracefully**: Check for permission denials and service failures
7. **Test on real devices**: Background location behaves differently on emulators

## Additional Resources

- [Main package README](../README.md)
- [Publishing guide](../PUBLISHING.md)
- [Flutter location best practices](https://flutter.dev/docs/development/data-and-backend/location)
