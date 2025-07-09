/// Module: Main Entry Point
///
/// Configures and launches the Flutter application. Sets debug flags,
/// wraps the app in a Riverpod `ProviderScope`, and applies the custom theme.
library;

import "package:flutter/material.dart";
import "package:flutter/rendering.dart" show debugPaintSizeEnabled;

import "package:hooks_riverpod/hooks_riverpod.dart";

import "ui/core/themes/shadcn_theme.dart";
import "ui/mentor_table/widgets/table_screen.dart";

/// Application entry point.
///
/// Initializes debugging options and runs the app inside a `ProviderScope`.
void main() {
  debugPaintSizeEnabled = false;
  runApp(ProviderScope(child: const MainApp()));
}

/// The root widget of the application.
///
/// Builds a `MaterialApp` using `shadcnTheme` and sets `TableScreen` as home.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  /// Builds the main `MaterialApp`.
  ///
  /// **Parameters:**
  /// - `context` (`BuildContext`): The build context.
  ///
  /// **Returns:** A configured `MaterialApp` with theme and home screen.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: shadcnTheme, home: TableScreen());
  }
}
