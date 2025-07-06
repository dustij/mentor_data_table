/// Defines the custom `shadcnTheme` used throughout the app.
///
/// This theme applies a design inspired by Tailwind’s color palette and includes
/// customized styling for buttons, input fields, cards, typography, snackbar, and layout.
library;

import "package:flutter/material.dart";

/// A slate gray palette derived from OKL-ch values for consistent slate tones.
class Slate {
  Slate._();

  /// OKL-ch(98.4% 0.003 247.858)
  static const Color slate50 = Color(0xFFF9FAFB);

  /// OKL-ch(96.8% 0.007 247.896)
  static const Color slate100 = Color(0xFFF3F4F6);

  /// OKL-ch(92.9% 0.013 255.508)
  static const Color slate200 = Color(0xFFE5E7EB);

  /// OKL-ch(86.9% 0.022 252.894)
  static const Color slate300 = Color(0xFFD1D5DB);

  /// OKL-ch(70.4% 0.04 256.788)
  static const Color slate400 = Color(0xFF9CA3AF);

  /// OKL-ch(55.4% 0.046 257.417)
  static const Color slate500 = Color(0xFF6B7280);

  /// OKL-ch(44.6% 0.043 257.281)
  static const Color slate600 = Color(0xFF4B5563);

  /// OKL-ch(37.2% 0.044 257.287)
  static const Color slate700 = Color(0xFF374151);

  /// OKL-ch(27.9% 0.041 260.031)
  static const Color slate800 = Color(0xFF1E293B);

  /// OKL-ch(20.8% 0.042 265.755)
  static const Color slate900 = Color(0xFF111827);

  /// OKL-ch(12.9% 0.042 264.695)
  static const Color slate950 = Color(0xFF0F172A);
}

/// A set of custom colors derived from Tailwind CSS palette used in the app’s UI theme.
class ShadcnColors {
  static const Color primary = Color(0xFF3B82F6); // blue-500
  static const Color primaryDark = Color(0xFF1E40AF); // blue-800
  static const Color background = Slate.slate50; // slate-50
  static const Color surface = Colors.white;
  static const Color border = Slate.slate300;
  static const Color borderVariant = Slate.slate400;
  static const Color text = Slate.slate700; // slate-700
  static const Color textSecondary = Slate.slate500; // slate-500
  static const Color error = Color(0xFFEF4444); // red-500
}

/// The main `ThemeData` instance used in the app.
///
/// This theme includes custom color schemes, typography, input decorations, button themes,
/// and scaffold background styling to provide a cohesive visual design.
final ThemeData shadcnTheme = ThemeData(
  brightness: Brightness.light,
  // Use Inter
  fontFamily: "Inter",

  // ColorScheme backs most Material widgets
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: ShadcnColors.primary,
    onPrimary: Colors.white,
    secondary: ShadcnColors.primary.withValues(alpha: 0.1),
    onSecondary: ShadcnColors.primaryDark,
    surface: ShadcnColors.surface,
    onSurface: ShadcnColors.text,
    surfaceContainer: ShadcnColors.background,
    surfaceDim: Slate.slate100,
    onSurfaceVariant: Slate.slate500,
    error: ShadcnColors.error,
    onError: Colors.white,
    outline: ShadcnColors.border,
    outlineVariant: ShadcnColors.borderVariant,
  ),

  // AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: ShadcnColors.background,
    foregroundColor: ShadcnColors.text,
    elevation: 1,
    surfaceTintColor: Colors.transparent,
  ),

  // Input fields
  inputDecorationTheme: InputDecorationTheme(
    filled: false,
    fillColor: ShadcnColors.surface,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: ShadcnColors.borderVariant),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ShadcnColors.borderVariant),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ShadcnColors.primary),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ShadcnColors.error),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: ShadcnColors.error, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: const TextStyle(color: ShadcnColors.textSecondary),
    hintStyle: const TextStyle(color: ShadcnColors.textSecondary),
  ),

  // ElevatedButton (solid)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ShadcnColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      minimumSize: const Size(64, 40),
      elevation: 0,
    ),
  ),

  // OutlinedButton (stroke)
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ShadcnColors.primary,
      side: const BorderSide(color: ShadcnColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  // TextButton (link-style)
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: ShadcnColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    ),
  ),

  // Typography
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: ShadcnColors.text),
    bodyMedium: TextStyle(fontSize: 14, color: ShadcnColors.text),
    titleSmall: TextStyle(fontSize: 14, color: ShadcnColors.textSecondary),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),

  // Card styling
  cardTheme: CardThemeData(
    color: ShadcnColors.surface,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: ShadcnColors.borderVariant),
    ),
    elevation: 0,
  ),

  // Scaffold background
  scaffoldBackgroundColor: ShadcnColors.background,

  // Snackbar styling
  snackBarTheme: SnackBarThemeData(
    backgroundColor: ShadcnColors.surface,
    contentTextStyle: const TextStyle(color: ShadcnColors.text, fontSize: 14),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: ShadcnColors.borderVariant),
    ),
    actionTextColor: ShadcnColors.primary,
  ),

  // Search view styling
  searchViewTheme: const SearchViewThemeData(shrinkWrap: true),
);

/// A dedicated theme for delete-style outlined buttons (red-outlined).
class ShadcnTheme {
  ShadcnTheme._(); // private constructor

  static final OutlinedButtonThemeData deleteOutlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ShadcnColors.text,
          side: const BorderSide(color: ShadcnColors.borderVariant),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  // Filter button
  static final FilledButtonThemeData filterButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      elevation: 0,
      backgroundColor: Slate.slate100,
      foregroundColor: Slate.slate500,
      side: const BorderSide(color: ShadcnColors.borderVariant),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.zero,
          bottomLeft: Radius.zero,
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
    ),
  );

  // Old table theme (not used)
  static final DataTableThemeData tableTheme = DataTableThemeData(
    decoration: BoxDecoration(
      border: BoxBorder.all(color: ShadcnColors.border),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
}
