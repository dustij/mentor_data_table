import "package:mentor_data_table/models/entry.dart";

enum SortDirection { asc, desc, none }

class SortOrder {
  final EntryField field;
  final SortDirection direction;

  SortOrder({required this.field, required this.direction});

  @override
  String toString() => "${field.text} - ${direction.name}";
}
