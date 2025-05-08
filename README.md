# Daily Focus Tracker

A Flutter application for tracking daily focus tasks and productivity.

## Features

- Clean Architecture implementation
- State management with Riverpod
- Navigation with GoRouter
- Material 3 design system
- Smooth animations and transitions
- Theme switching (Light/Dark/System)
- Multi-language support (English/Spanish)
- Task management with persistence
- Statistics and progress tracking

## Project Structure

lib/
├── core/
│   ├── theme/
│   ├── constants/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── tasks/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── stats/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── settings/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── l10n/
└── main.dart

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

- flutter_riverpod: ^2.4.9
- go_router: ^13.1.0
- shared_preferences: ^2.2.2
- flutter_animate: ^4.5.0
- intl: ^0.18.1
- uuid: ^4.3.3

## Architecture

The project follows Clean Architecture principles with three main layers:

1. **Presentation Layer**: Contains UI components, pages, and providers
2. **Domain Layer**: Contains business logic and entities
3. **Data Layer**: Handles data sources and repositories

## State Management

The app uses Riverpod for state management, with the following providers:

- `taskProvider`: Manages the list of tasks
- `themeProvider`: Controls the app theme
- `languageProvider`: Manages the app locale

## Navigation

Navigation is handled by GoRouter with the following routes:

- `/`: Home page
- `/tasks`: Tasks management
- `/stats`: Statistics and progress
- `/settings`: App settings

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request
