import 'package:flutter/material.dart';

class FilterBuilderDropdown extends StatelessWidget {
  const FilterBuilderDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use themed surface color and outline from Shadcn theme
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      width: 300,
      height: 300,
      padding: const EdgeInsets.all(16),
      child: const SizedBox.shrink(),
    );
  }
}
