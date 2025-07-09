/// Module: Responsive Breakpoints & Utilities
///
/// Defines screen-size breakpoints and convenience methods for responsive UI
/// development, inspired by Tailwind CSS. Includes:
/// - `Breakpoints` class for breakpoint thresholds and checks.
/// - `BuildContextBreakpoints` extension for accessing breakpoints via context.
/// - `ResponsiveValue` extension for responsive values per breakpoint.
library;

import "package:flutter/widgets.dart";

/// A set of named screen-size thresholds and helpers for breakpoint detection.
///
/// Breakpoints (xs, sm, md, lg, xl, 2xl) defined in logical pixels.
/// Provides methods to determine the current breakpoint or boolean checks.
class Breakpoints {
  static const _sm = 640.0;
  static const _md = 768.0;
  static const _lg = 1024.0;
  static const _xl = 1280.0;
  static const _xxl = 1536.0;

  /// Determines the breakpoint name for a given width.
  ///
  /// **Parameters:**
  /// - `width` (`double`): The width in logical pixels.
  ///
  /// **Returns:** `String` one of "xs", "sm", "md", "lg", "xl", "2xl".
  ///
  /// **Example:**
  /// ```dart
  /// final bp = Breakpoints.of(800); // "md"
  /// ```
  static String of(double width) {
    if (width >= _xxl) return "2xl";
    if (width >= _xl) return "xl";
    if (width >= _lg) return "lg";
    if (width >= _md) return "md";
    if (width >= _sm) return "sm";
    return "xs";
  }

  /// `true` if `width` is less than the small breakpoint (< 640px).
  static bool isXs(double width) => width < _sm;

  /// `true` if `width` is between small (640px) and medium (768px).
  static bool isSm(double width) => width >= _sm && width < _md;

  /// `true` if `width` is between medium (768px) and large (1024px).
  static bool isMd(double width) => width >= _md && width < _lg;

  /// `true` if `width` is between large (1024px) and extra-large (1280px).
  static bool isLg(double width) => width >= _lg && width < _xl;

  /// `true` if `width` is between extra-large (1280px) and 2× extra-large (1536px).
  static bool isXl(double width) => width >= _xl && width < _xxl;

  /// `true` if `width` is greater than or equal to 2× extra-large (1536px).
  static bool is2xl(double width) => width >= _xxl;
}

/// Extension adding breakpoint properties to `BuildContext`.
///
/// Provides:
/// - `screenWidth`: the current screen width in logical pixels.
/// - Boolean getters (`isXs`, `isSm`, etc.) for breakpoint checks.
extension BuildContextBreakpoints on BuildContext {
  /// The width of the screen in logical pixels.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// `true` if the screen width is less than the small breakpoint (< 640px).
  bool get isXs => Breakpoints.isXs(screenWidth);

  /// `true` if the screen width is between small (640px) and medium (768px).
  bool get isSm => Breakpoints.isSm(screenWidth);

  /// `true` if the screen width is between medium (768px) and large (1024px).
  bool get isMd => Breakpoints.isMd(screenWidth);

  /// `true` if the screen width is between large (1024px) and extra-large (1280px).
  bool get isLg => Breakpoints.isLg(screenWidth);

  /// `true` if the screen width is between extra-large (1280px) and 2× extra-large (1536px).
  bool get isXl => Breakpoints.isXl(screenWidth);

  /// `true` if the screen width is greater than or equal to 2× extra-large (1536px).
  bool get is2xl => Breakpoints.is2xl(screenWidth);
}

/// Extension to choose responsive values based on current breakpoint.
///
/// Allows specifying a base value and optional overrides for each breakpoint.
extension ResponsiveValue on BuildContext {
  /// Returns a value based on the current breakpoint.
  ///
  /// **Parameters:**
  /// - `base` (`T`): Default value when no breakpoint override applies.
  /// - `sm` (`T?`): Value for small screens (width ≥ 640px).
  /// - `md` (`T?`): Value for medium screens (width ≥ 768px).
  /// - `lg` (`T?`): Value for large screens (width ≥ 1024px).
  /// - `xl` (`T?`): Value for extra-large screens (width ≥ 1280px).
  /// - `xxl` (`T?`): Value for 2× extra-large screens (width ≥ 1536px).
  ///
  /// **Returns:** `T` the appropriate value for the current screen width.
  ///
  /// **Example:**
  /// ```dart
  /// final padding = context.responsive<double>(base: 8, md: 12, lg: 16);
  /// ```
  T responsive<T>({required T base, T? sm, T? md, T? lg, T? xl, T? xxl}) {
    final w = screenWidth;
    if (w >= Breakpoints._xxl && xxl != null) return xxl;
    if (w >= Breakpoints._xl && xl != null) return xl;
    if (w >= Breakpoints._lg && lg != null) return lg;
    if (w >= Breakpoints._md && md != null) return md;
    if (w >= Breakpoints._sm && sm != null) return sm;
    return base;
  }
}
