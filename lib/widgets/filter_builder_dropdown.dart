import 'package:flutter/material.dart';

import '../models/form_entry.dart';

/// A floating dropdown panel for constructing and applying filter rules.
class FilterBuilderDropdown extends StatelessWidget {
  const FilterBuilderDropdown({super.key});

  /// Builds the dropdown UI containing
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Advanced Filters",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              _FilterRow(),
              SizedBox(height: 8),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text("Add New Filter"),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Apply Filters"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single row in the filter builder, allowing selection of:
/// - a field
/// - an operator (includes or equals)
/// - a value, with a delete action.
class _FilterRow extends StatelessWidget {
  const _FilterRow({super.key});

  /// Builds the UI for one filter clause: field dropdown, operator dropdown,
  /// text input, and delete button.
  @override
  Widget build(BuildContext context) {
    final Field field = Field.values.first;
    final String op = "includes";

    return Row(
      children: [
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Field>(
              value: field,
              isExpanded: true,
              items: Field.values
                  .map((f) => DropdownMenuItem(value: f, child: Text(f.text)))
                  .toList(),
              onChanged: (_) {},
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: op,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "includes", child: Text("includes")),
                DropdownMenuItem(value: "equals", child: Text("equals")),
              ],
              onChanged: (_) {},
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
      ],
    );
  }
}
