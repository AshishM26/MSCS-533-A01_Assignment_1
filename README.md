# Measures Converter

## Overview

Measures Converter is a Flutter and Dart application that converts measurements between metric and imperial units. It supports length and mass conversions while preventing incompatible conversions between categories.

## Features

- Accepts whole-number, decimal, and signed numeric input
- Converts between metric and imperial measurements
- Limits destination units to the selected measurement category
- Supports same-unit and repeated conversions
- Displays clear validation for empty or invalid input
- Formats results with practical decimal precision

## Supported Units

Length:

- meters
- kilometers
- feet
- miles

Mass:

- kilograms
- grams
- pounds
- ounces

## Technologies

- Dart
- Flutter
- Android emulator
- Git
- GitHub
- VS Code

## Project Structure

```text
lib/
  main.dart                         Application UI and interaction state
  models/conversion_unit.dart       Unit definitions and categories
  services/conversion_service.dart  Base-unit conversion logic
test/
  conversion_service_test.dart      Conversion-service unit tests
  measures_converter_widget_test.dart  UI behavior tests
android/app/src/main/AndroidManifest.xml  Android application manifest
```

## Conversion Design

The application converts each source value to a category base unit and then converts that base value to the destination unit. Meters are the base unit for length, and kilograms are the base unit for mass. This avoids separate formulas for every possible unit pair and keeps conversion logic out of the UI.

## Running the Application

Confirm that an Android emulator is running, then execute:

```bash
flutter pub get
flutter run
```

## Testing

Run the unit and widget tests with:

```bash
flutter test
```

## Code Quality

Format and analyze the project with:

```bash
dart format .
flutter analyze
```

## Screenshot

The repository includes a real Android emulator capture at [screenshots/measures_converter.png](screenshots/measures_converter.png). It shows the completed conversion `115 kilometers are 71.457687 miles` and can be included in the Blackboard Word document.

## Repository

<https://github.com/AshishM26/MSCS-533-A01_Assignment_1>

## Development / AI Assistance

AI-assisted development tools supported environment setup, implementation review, troubleshooting, and testing. The student reviews and tests the implementation before submission.
