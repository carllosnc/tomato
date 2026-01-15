# Tomato Pomodoro

> A comprehensive time management application built with Flutter, designed to help you focus, track time, and manage your tasks efficiently.

## Features

- **Focus & Break Timer**: Classic Pomodoro technique implementation with customizable durations.
- **Multiple Timers**: Create and manage multiple timers for different tasks or workflows.
- **Last Time Since**: Track the last time you performed specific activities (New).
- **Customization**:
    - Customizable timer durations.
    - Sound and vibration feedback.
    - Dark/Light mode support (implicit via theme).
- **Persistency**: Data is saved locally using SQLite and Shared Preferences.

## Tech Stack

This project is built using:

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **Routing**: [go_router](https://pub.dev/packages/go_router)
- **Local Storage**:
    - [sqflite](https://pub.dev/packages/sqflite) (SQLite)
    - [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Audio & Haptics**:
    - [audioplayers](https://pub.dev/packages/audioplayers)
    - [vibration](https://pub.dev/packages/vibration)
- **Code Generation**: [build_runner](https://pub.dev/packages/build_runner), [json_serializable](https://pub.dev/packages/json_serializable)

## Project Structure

The project follows a feature-first architecture:

- `lib/core`: Core utilities, routing, themes, and shared services.
- `lib/domain`: Domain models and entities.
- `lib/features`: Feature-specific code (UI and logic), e.g., `home`, `focus_break`, `multiple_timers`.
- `lib/shared_state`: Global state management logic.
- `lib/styles`: Design system tokens (typography, colors, components).

## Getting Started

1.  **Prerequisites**: Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the App**:
    ```bash
    flutter run
    ```

## Development Commands

**Code Generation** (Run this after changing models or routes if applicable):
```bash
dart run build_runner build --delete-conflicting-outputs
```

**launcher Icons**:
```bash
dart run flutter_launcher_icons dart
```

**Splash Screen**:
```bash
dart run flutter_native_splash:create
```

**Linting**:
```bash
flutter analyze
```

**Testing**:
```bash
flutter test
```

---

## License

MIT © [Carlos Costa](https://github.com/C4co)
