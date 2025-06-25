import 'package:flutter/material.dart';

import '../models/form_entry.dart';

class FilterBuilderDropdown extends StatelessWidget {
  const FilterBuilderDropdown({super.key});

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
                  SizedBox(width: 16),
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

class _FilterRow extends StatelessWidget {
  const _FilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final Field field = Field.values.first;
    final String op = "includes";

    return Row(
      children: [
        DropdownButton<Field>(
          value: field,
          items: Field.values
              .map((f) => DropdownMenuItem(value: f, child: Text(f.name)))
              .toList(),
          onChanged: (_) {},
        ),
        SizedBox(width: 8),
        DropdownButton<String>(
          value: op,
          items: const [
            DropdownMenuItem(value: "includes", child: Text("includes")),
            DropdownMenuItem(value: "equals", child: Text("equals")),
          ],
          onChanged: (_) {},
        ),
      ],
    );
  }
}
