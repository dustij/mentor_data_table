import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../domain/entry.dart";
import "../services/filter_query_builder.dart";
import "../services/filter_service.dart";
import "../services/search_service.dart";
import "../services/sort_service.dart";

import "filter_list_notifier.dart";
import "original_data.dart";
import "search_notifier.dart";
import "sort_list_notifier.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "gen/processed_data.g.dart";

@riverpod
class ProcessedData extends _$ProcessedData {
  late final FilterService _filterService;
  late final SearchService _searchService;
  late final SortService _sortService;

  @override
  AsyncValue<List<Entry>> build() {
    _filterService = FilterService(FilterQueryBuilder());
    _searchService = SearchService();
    _sortService = SortService();

    final rawAsync = ref.watch(originalDataProvider);
    final filterList = ref.watch(filterListNotifierProvider);
    final searchText = ref.watch(searchNotifierProvider);
    final sortList = ref.watch(sortListNotifierProvider);

    var processedData = [] as List<Entry>;

    return rawAsync.when(
      loading: () => const AsyncValue.loading(),
      error: (e, s) => AsyncValue.error(e, s),
      data: (originalData) {
        processedData = _filterService.applyFilters(processedData, filterList);
        processedData = _searchService.applySearch(processedData, searchText);
        processedData = _sortService.applySort(processedData, sortList);
        return AsyncValue.data(processedData);
      },
    );
  }
}
