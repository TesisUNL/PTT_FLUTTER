# PTT_MBS_APP

Project mobile for the tourist route Mancomunidad Bosque Seco

## Getting Started

### Requirements
- [Flutter](https://docs.flutter.dev/get-started/install) sdk version >=2.16.1 <3.0.0
- You must have to connect your device in developer mode or install and connect an emulator

### How to install and run the project

1. Install dependencies
```
flutter pub get
```

2. Run project, before this please verify that you have connected devices
```
flutter run lib/main.dart
```

Notes:

In case flutter run command open web browser, please set false enable-web

```
flutter config --no-enable-web
```

If you recieve a message of
**No supported devices connected.** verify that you have connected devices: emulator or smartphone.

```
flutter run -d <devide_id> lib/main.dart
```

If you don't know the id of the device, you can see it in VS code with the command palette
```
Ctrl + Shift + P
```
And search **Flutter: Select device**


## Branch and commit format

### Branch
The name of new branches should have the name of the feature, e.g:

```
feature-create-project-structure
```

### Commit message

Examples:
```
feat: modify readme 
fix: fix layout in component A
```

Commit example with message:
```
git commit -m "feat: whatever what you do"
```

Commit types:

- fix: hotfix or something that was fixed because of a bug
- feat: refers to a feature, a new requirement
- test: refers to test code, e.g unit testing, integration testing
- refactor: refers something was modified in the code, e.g. naming


## Unit testing
Test directories for new implementation should have the same project structure, that means if a new folder is created, the folder must be created in test directory.

To run unit tests in flutter use the following command:
```
flutter test
```


## Project structure
The project has folders for assets, env variables and source code (lib) which has core folder to place all shareable code or resources and features.
```
.
├── assets
├── env
├── lib
│   ├── core
│   └── features
```

## Dependencies

To add new dependencies, it must be placed in [pubspec.yaml file](pubspec.yaml).

```
dev_dependencies:
  flutter_test:
    sdk: flutter
    flutter_lints: ^1.0.0
```

To update the dependencies, just run the following command:
```
flutter pub get
```

## Read more

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Flutter documentation](https://flutter.dev/docs)
- [Clean architecture with flutter](https://devmuaz.medium.com/flutter-clean-architecture-series-part-1-d2d4c2e75c47)
- [Videos: clean architecture](https://www.youtube.com/watch?v=KjE2IDphA_U&list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech)
