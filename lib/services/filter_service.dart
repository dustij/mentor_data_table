import "../models/filter_query.dart";
import "../models/form_entry.dart";

/// Provides filtering logic to apply a [FilterQuery] to a list of [FormEntry] items.
class FilterService {
  /// Filters [entries] using [filter], returning a new list of entries where `filter.matches` is true.
  List<FormEntry> applyFilter({
    required List<FormEntry> entries,
    required FilterQuery filter,
  }) {
    return entries.where((e) => filter.matches(e)).toList();
  }
}
