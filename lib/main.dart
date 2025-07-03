import "package:flutter/material.dart";
import "package:flutter/rendering.dart" show debugPaintSizeEnabled;

import "package:hooks_riverpod/hooks_riverpod.dart";

import "shared/theme/shadcn_theme.dart";
import "features/entry_table/presentation/table_screen.dart";

void main() {
  debugPaintSizeEnabled = false;
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: shadcnTheme, home: TableScreen());
  }
}
