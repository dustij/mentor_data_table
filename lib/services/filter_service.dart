import "../models/filter_query.dart";
import "../models/form_entry.dart";

abstract class FilterService {
  List<FormEntry> applyFilters({
    required List<FormEntry> data,
    required List<FilterQuery> filters,
  });
}

class FilterServiceImpl implements FilterService {
  @override
  List<FormEntry> applyFilters({
    required List<FormEntry> data,
    required List<FilterQuery> filters,
  }) {
    // TODO: implement applyFilters
    throw UnimplementedError();
  }
}
