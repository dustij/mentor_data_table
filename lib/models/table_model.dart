import "package:mentor_data_table/models/entry.dart";
import "package:mentor_data_table/models/filter.dart";
import "package:mentor_data_table/models/sort_order.dart";

class TableModel {
  final List<Entry> originalData;
  final List<Entry> processedData;
  final List<SortOrder> sortOrders;
  final List<Filter> filters;

  TableModel({
    required this.originalData,
    required this.processedData,
    required this.sortOrders,
    required this.filters,
  });

  TableModel.blank()
    : originalData = [],
      processedData = [],
      sortOrders = [],
      filters = [];

  TableModel copyWith({
    List<Entry>? originalData,
    List<Entry>? processedData,
    List<SortOrder>? sortOrders,
    List<Filter>? filters,
  }) {
    return TableModel(
      originalData: originalData ?? this.originalData,
      processedData: processedData ?? this.processedData,
      sortOrders: sortOrders ?? this.sortOrders,
      filters: filters ?? this.filters,
    );
  }
}
