import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "views/table_screen.dart";

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TableScreen());
  }
}
