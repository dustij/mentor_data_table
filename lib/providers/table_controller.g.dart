// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tableControllerHash() => r'9870c333a5f099b36a5a34684940e9fda1ef32b0';

/// [TableController] manages the state of the data table including
/// asynchronous data fetching, multi-column sorting, and search/filter functionality.
///
/// - Sorting: Supports tri-state sorting (ascending, descending, none) on each column.
///   The sort order reflects the sequence in which columns were clicked. Columns retain
///   their position in the list unless removed by toggling back to "none."
///
/// - Filtering: Allows both simple search queries across all fields and complex logical
///   filters using composable [FilterQuery] instances like [AndFilter], [OrFilter], and [FieldContains].
///
/// - Data Source: Data is loaded using a policy pattern abstraction via [FetchPolicy],
///   enabling modular fetching strategies (e.g., from a local JSON file or remote API).
///
/// The resulting filtered and sorted data is stored in [TableState.resultSet],
/// and updates are triggered through [toggleSort] or [setSearchQuery]. TODO: after adding complex filtering, update this documentation
///
/// Copied from [TableController].
@ProviderFor(TableController)
final tableControllerProvider =
    AutoDisposeAsyncNotifierProvider<TableController, TableState>.internal(
      TableController.new,
      name: r'tableControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tableControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TableController = AutoDisposeAsyncNotifier<TableState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
