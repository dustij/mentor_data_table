import "../models/filter_query.dart";
import "../models/form_entry.dart";

/// Provides filtering logic to apply a [FilterQuery] to a list of [FormEntry] items.
class FilterService {
  /// Filters [items] using [filter], returning a new list of entries where `filter.matches` is true.
  List<FormEntry> applyFilter({
    required List<FormEntry> items,
    required FilterQuery filter,
  }) {
    return items.where((e) => filter.matches(e)).toList();
  }
}

/// Fluent builder for constructing a composite [FilterQuery] via method chaining.
class FilterBuilder {
  final List<FilterQuery> _clauses = [];

  /// Adds a [FieldContains] clause to match entries whose [column] contains [text], case-insensitive.
  FilterBuilder whereContains({required Field column, required String text}) {
    _clauses.add(FieldContains(column, text));
    return this;
  }

  /// Adds a [FieldEquals] clause to match entries whose [column] equals [text], case-insensitive.
  FilterBuilder whereEquals({required Field column, required String text}) {
    _clauses.add(FieldEquals(column, text));
    return this;
  }

  /// Adds an [OrFilter] grouping the provided clauses, matching entries satisfying any one of them.
  FilterBuilder orGroup(List<FilterQuery> clauses) {
    _clauses.add(OrFilter(clauses));
    return this;
  }

  /// Builds and returns a composite [FilterQuery]:
  /// - if no clauses, returns a [MatchAllFilter],
  /// - if one clause, returns that clause,
  /// - otherwise wraps all clauses in an [AndFilter].
  FilterQuery build() {
    if (_clauses.isEmpty) {
      return MatchAllFilter();
    }
    if (_clauses.length == 1) {
      return _clauses.first;
    }
    return AndFilter(_clauses);
  }
}
