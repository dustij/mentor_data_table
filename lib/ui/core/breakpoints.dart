// lib/ui/core/breakpoints.dart
import "package:flutter/widgets.dart";

/// Tailwind CSS–style breakpoints (in logical pixels).
class Breakpoints {
  static const _sm = 640.0;
  static const _md = 768.0;
  static const _lg = 1024.0;
  static const _xl = 1280.0;
  static const _xxl = 1536.0;

  /// Returns which breakpoint bucket the current width falls into.
  static String of(double width) {
    if (width >= _xxl) return "2xl";
    if (width >= _xl) return "xl";
    if (width >= _lg) return "lg";
    if (width >= _md) return "md";
    if (width >= _sm) return "sm";
    return "xs";
  }

  /// Convenience getters for booleans:
  static bool isXs(double width) => width < _sm;
  static bool isSm(double width) => width >= _sm && width < _md;
  static bool isMd(double width) => width >= _md && width < _lg;
  static bool isLg(double width) => width >= _lg && width < _xl;
  static bool isXl(double width) => width >= _xl && width < _xxl;
  static bool is2xl(double width) => width >= _xxl;
}

/// Shortcut to pull width from context:
extension BuildContextBreakpoints on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  bool get isXs => Breakpoints.isXs(screenWidth);
  bool get isSm => Breakpoints.isSm(screenWidth);
  bool get isMd => Breakpoints.isMd(screenWidth);
  bool get isLg => Breakpoints.isLg(screenWidth);
  bool get isXl => Breakpoints.isXl(screenWidth);
  bool get is2xl => Breakpoints.is2xl(screenWidth);
}

extension ResponsiveValue on BuildContext {
  /// Pick a value based on Tailwind-style breakpoints:
  ///  • xs (default) for width < 640
  ///  • sm for width ≥ 640 && < 768
  ///  • md for width ≥ 768 && < 1024
  ///  • lg for width ≥ 1024 && < 1280
  ///  • xl for width ≥ 1280 && < 1536
  ///  • 2xl for width ≥ 1536
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
