import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

class FilterMenu extends ConsumerWidget {
  final void Function() onClose;

  const FilterMenu({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntrinsicHeight(
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: [Text("Advanced Filters")]),
        ),
      ),
    );
  }
}
