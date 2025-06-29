import "package:mentor_data_table/models/entry.dart";

enum FilterOperator { includes, equals }

class Filter {
  final EntryField field;
  final String value;
  final FilterOperator operator;

  Filter({required this.field, required this.value, required this.operator});

  @override
  String toString() => "${field.text} ${operator.name} $value";
}
