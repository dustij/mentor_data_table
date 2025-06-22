import "package:mentor_data_table/models/form_entry.dart";

enum SortDirection { asc, desc, none }

class SortState {
  final Field column;
  final SortDirection direction;

  const SortState({required this.column, required this.direction});

  @override
  String toString() => "${column.field} - ${direction.name}";
}
