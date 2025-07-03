import "../models/entry.dart";

enum SortDirection { asc, desc, none }

class Sort {
  final EntryField field;
  final SortDirection direction;

  Sort({required this.field, required this.direction});

  @override
  String toString() => "${field.text} - ${direction.name}";
}
