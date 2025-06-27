import "package:riverpod_annotation/riverpod_annotation.dart";

import "../models/filter_query.dart";
import "../models/filter_rule.dart";
import "../models/form_entry.dart";

// Generated code lives in part
// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "filter_controller.g.dart";

/// Manages the set of active filter rules and produces a composite [FilterQuery].
///
/// - `build` initializes to no filtering (match all).
/// - `addFilter` adds a new rule to the builder.
/// - `applySearch` search across all fields.
@riverpod
class FilterController extends _$FilterController {
  /// Initializes filter state to a [MatchAllFilter], representing no filters.
  @override
  FilterQuery build() {
    // start from an empty builder
    return MatchAllFilter();
  }

  /// Adds the given [filter] rule to the builder and updates state
  /// with the new composite [FilterQuery].
  void addFilter(FilterRule filter) {
    final builder = ref.read(_filterBuilderProvider.notifier);
    switch (filter.operator) {
      case FilterOperator.includes:
        builder.whereContains(column: filter.field, text: filter.text);
      case FilterOperator.equals:
        builder.whereEquals(column: filter.field, text: filter.text);
    }
    state = builder.buildQuery();
  }

  /// Applies an OR filter for [text] across all fields, then updates state with the resulting query.
  void applySearch(String text) {
    final builder = ref.read(_filterBuilderProvider);
    builder.orGroup([
      for (final field in Field.values) FieldContains(field, text),
    ]);
    state = builder.buildQuery();
  }
}

/// Fluent builder for constructing a composite [FilterQuery] via method chaining.
@riverpod
class _FilterBuilder extends _$FilterBuilder {
  final List<FilterQuery> _clauses = [];

  @override
  _FilterBuilder build() {
    return this;
  }

  /// Adds a [FieldContains] clause to match entries whose [column] contains [text], case-insensitive.
  _FilterBuilder whereContains({required Field column, required String text}) {
    _clauses.add(FieldContains(column, text));
    return this;
  }

  /// Adds a [FieldEquals] clause to match entries whose [column] equals [text], case-insensitive.
  _FilterBuilder whereEquals({required Field column, required String text}) {
    _clauses.add(FieldEquals(column, text));
    return this;
  }

  /// Adds an [OrFilter] grouping the provided clauses, matching entries satisfying any one of them.
  _FilterBuilder orGroup(List<FilterQuery> clauses) {
    _clauses.add(OrFilter(clauses));
    return this;
  }

  /// Clears all accumulated filter clauses.
  void reset() {
    _clauses.clear();
  }

  /// Builds and returns a composite [FilterQuery]:
  /// - if no clauses, returns a [MatchAllFilter],
  /// - if one clause, returns that clause,
  /// - otherwise wraps all clauses in an [AndFilter].
  FilterQuery buildQuery() {
    if (_clauses.isEmpty) {
      return MatchAllFilter();
    }
    if (_clauses.length == 1) {
      return _clauses.first;
    }
    return AndFilter(_clauses);
  }

  /// Returns the current list of filter clauses in insertion order.
  List<FilterQuery> getRules() {
    return List.from(_clauses);
  }
}
