import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../models/filter_rule.dart";
import "../models/form_entry.dart";
import "../providers/table_controller.dart";

/// A floating dropdown panel for constructing and applying filter rules.
class FilterBuilderDropdown extends HookConsumerWidget {
  final VoidCallback onClose;

  const FilterBuilderDropdown({required this.onClose, super.key});

  /// Builds the dropdown UI containing
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableCtrl = ref.read(tableControllerProvider.notifier);

    // State: list of filter rows
    final rows = useState<List<_FilterRowData>>(
      tableCtrl.getActiveFilters().isNotEmpty
          ? tableCtrl
                .getActiveFilters()
                .map(
                  (f) => _FilterRowData(
                    field: f.asFilterRule().field.text,
                    op: f.asFilterRule().operator.text,
                    initialValue: f.asFilterRule().value,
                  ),
                )
                .toList()
          : [_FilterRowData()],
    );

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
              //
              // Filters
              for (var i = 0; i < rows.value.length; i++)
                _FilterRow(
                  data: rows.value[i],
                  onDelete: () {
                    rows.value = [...rows.value]..removeAt(i);
                  },
                  onFieldChanged: (f) {
                    rows.value[i].field = f;
                    rows.value = [...rows.value];
                  },
                  onOpChanged: (o) {
                    rows.value[i].op = o;
                    rows.value = [...rows.value];
                  },
                ),
              SizedBox(height: 8),
              //
              // Buttons
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      if (rows.value.last.isValid()) {
                        rows.value = [...rows.value, _FilterRowData()];
                      }
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add New Filter"),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        for (var i = 0; i < rows.value.length; i++) {
                          final rowData = rows.value[i];
                          if (rowData.isValid()) {
                            tableCtrl.addFilter(
                              FilterRule(
                                field: Field.fromText(rowData.field),
                                value: rowData.controller.text,
                                operator: FilterOperator.fromText(rowData.op),
                              ),
                            );
                          }
                        }
                        print(tableCtrl.getActiveFilters());
                        // Close the dropdown panel
                        onClose();
                      },
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
  final _FilterRowData data;
  final VoidCallback onDelete;
  final ValueChanged<String> onFieldChanged;
  final ValueChanged<String> onOpChanged;
  const _FilterRow({
    required this.data,
    required this.onDelete,
    required this.onFieldChanged,
    required this.onOpChanged,
  });

  /// Builds the UI for one filter clause: field dropdown, operator dropdown,
  /// text input, and delete button.
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: data.field,
              hint: Text("Choose a field"),
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  value: "Choose a field",
                  child: Text("Choose a field"),
                ),
                ...Field.values.map(
                  (f) => DropdownMenuItem(value: f.text, child: Text(f.text)),
                ),
              ],
              onChanged: (f) => f != null ? onFieldChanged(f) : null,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: data.op,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "includes", child: Text("includes")),
                DropdownMenuItem(value: "equals", child: Text("equals")),
              ],
              onChanged: (o) => o != null ? onOpChanged(o) : null,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: data.controller,
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
        IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
      ],
    );
  }
}

class _FilterRowData {
  String field;
  String op;
  TextEditingController controller;

  _FilterRowData({String? field, String? op, String? initialValue})
    : field = field ?? "Choose a field",
      op = op ?? 'includes',
      controller = TextEditingController(text: initialValue);

  bool isValid() {
    try {
      return Field.values.contains(Field.fromText(field)) &&
          controller.text.isNotEmpty;
    } on Exception catch (_) {
      return false;
    }
  }
}
