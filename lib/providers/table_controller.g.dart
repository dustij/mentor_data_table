// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tableControllerHash() => r'd934387092a1405f1458cdfea1fa21a426198382';

/// Manages the state of the data table, including:
/// - asynchronous loading of entries,
/// - multi-column sorting,
/// - searching and composable filters,
/// - updating the result set in [TableState].
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
