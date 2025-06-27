import "package:flutter/material.dart";

import "../models/form_entry.dart";
import "../models/sort_state.dart";

/// A widget that displays a list of [FormEntry] items in a scrollable table.
///
/// The table supports:
/// - Columns defined by `FormEntry.fields`.
/// - Sort indicators based on [sortOrder].
/// - Column header taps invoking [onSort] with the associated [Field].
class FormEntryTable extends StatelessWidget {
  final List<FormEntry> entries;
  final void Function(Field) onSort;
  final List<SortState> sortOrder;

  const FormEntryTable({
    super.key,
    required this.entries,
    required this.onSort,
    required this.sortOrder,
  });

  /// Builds the scrollable DataTable containing the entries.
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: DataTable(columns: _buildColumns(), rows: _buildRows()),
      ),
    );
  }

  /// Generates a [DataRow] for each [FormEntry] in [entries].
  List<DataRow> _buildRows() {
    return entries
        .map(
          (data) => DataRow(
            key: ValueKey(
              '${data.mentorName}-${data.studentName}-${data.sessionDetails}',
            ),
            cells: FormEntry.fields
                .map((label) => DataCell(Text(data[label])))
                .toList(),
          ),
        )
        .toList();
  }

  /// Generates sortable [DataColumn]s for each field, showing sort icons
  /// based on [sortOrder] and handling taps via [onSort].
  List<DataColumn> _buildColumns() {
    return FormEntry.fields.map((field) {
      final sortState = sortOrder.firstWhere(
        (s) => s.column == field,
        orElse: () => const SortState(
          column: Field.mentorName,
          direction: SortDirection.none,
        ),
      );

      Icon? sortIcon;
      if (sortState.direction == SortDirection.asc) {
        sortIcon = const Icon(Icons.arrow_upward, size: 16);
      } else if (sortState.direction == SortDirection.desc) {
        sortIcon = const Icon(Icons.arrow_downward, size: 16);
      }

      return DataColumn(
        label: Row(
          children: [
            Text(field.toString()),
            const SizedBox(width: 4),
            sortIcon ?? const SizedBox(width: 16, height: 16),
          ],
        ),
        onSort: (_, _) => onSort(field),
      );
    }).toList();
  }
}
