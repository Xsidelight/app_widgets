# App Widgets

A Flutter project demonstrating how to create and update home screen widgets for both iOS and Android platforms.

## Overview

This project showcases how to implement home screen widgets that can be updated from a Flutter app. It uses platform-specific implementations (Kotlin for Android and Swift for iOS) together with Flutter's MethodChannel for cross-platform communication.

## Features

- Android home screen widgets using AppWidgetProvider
- iOS home screen widgets using WidgetKit and SwiftUI
- Bidirectional communication between Flutter and native widgets
- Real-time widget updates from the Flutter app
- Shared data storage between app and widgets

## Getting Started

### Prerequisites

- Flutter SDK (^3.7.0)
- Android Studio / Xcode 
- iOS 14.0+ (for iOS widget support)
- Android API level 21+ (for Android widget support)

### Installation

1. Clone the repository:
    ```
    git clone https://github.com/yourusername/app_widgets.git
    ```

2. Navigate to the project directory:
    ```
    cd app_widgets
    ```

3. Install dependencies:
    ```
    flutter pub get
    ```

4. iOS specific setup:
   - Open the iOS project in Xcode
   - Set up App Groups capability for both the main app and widget extension
   - Update the App Group identifier in the code if needed
   - Ensure minimum deployment target is iOS 14.0+

5. Run the app:
    ```
    flutter run
    ```

## Project Structure

- `android/app/src/main/kotlin/` - Android Kotlin implementation with AppWidgetProvider
- `ios/MyWidget/` - iOS Swift widget extension using WidgetKit
- `ios/Runner/` - iOS main app with method channel implementation
- `lib/` - Flutter application source code
- `build/` - Build artifacts

## How It Works

1. The Flutter app stores data using shared preferences
2. When data is updated, Flutter invokes a method channel
3. Native code (Kotlin/Swift) receives the update via the method channel
4. Native code updates the widget using platform-specific APIs

## Dependencies

- Flutter SDK
- shared_preferences: ^2.5.2
- cupertino_icons: ^1.0.8

## Configuration

### Android Widget Setup

The Android widget is implemented using AppWidgetProvider and broadcasts to handle data updates from the Flutter app.

### iOS Widget Setup

The iOS widgets are implemented using SwiftUI and WidgetKit with a TimelineProvider to manage widget updates.

### Flutter Integration

The Flutter application communicates with both platforms through MethodChannels and shared data storage mechanisms.

## Future Improvements

- Add widget configuration options
- Support for multiple widget types
- Interactive widgets with actions
- Background updates

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.