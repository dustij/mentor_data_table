import "entry.dart";

enum FilterOperator { includes, equals }

class Filter {
  final EntryField field;
  final String value;
  final FilterOperator operator;

  Filter({required this.field, required this.value, required this.operator});

  Filter clone() {
    return Filter(field: field, value: value, operator: operator);
  }

  @override
  String toString() => "${field.text} ${operator.name} $value";
}
