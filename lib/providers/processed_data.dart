import "package:riverpod_annotation/riverpod_annotation.dart";

import "../models/entry.dart";
import "../providers/filter_list_notifier.dart";
import "../providers/original_data.dart";
import "../providers/search_notifier.dart";
import "../providers/sort_list_notifier.dart";
import "../services/filter_query_builder.dart";
import "../services/filter_service.dart";
import "../services/search_service.dart";
import "../services/sort_service.dart";

// to generate run: `dart run build_runner build --delete-conflicting-outputs`
part "processed_data.g.dart";

@riverpod
class ProcessedData extends _$ProcessedData {
  @override
  AsyncValue<List<Entry>> build() {
    final rawAsync = ref.watch(originalDataProvider);
    final filterList = ref.watch(filterListNotifierProvider);
    final searchText = ref.watch(searchNotifierProvider);
    final sortList = ref.watch(sortListNotifierProvider);

    final filterService = FilterService(FilterQueryBuilder());
    final searchService = SearchService(FilterQueryBuilder());
    final sortService = SortService();

    return rawAsync.when(
      loading: () => const AsyncValue.loading(),
      error: (e, s) => AsyncValue.error(e, s),
      data: (originalData) {
        var processedData = List<Entry>.from(originalData);
        processedData = filterService.applyFilters(processedData, filterList);
        processedData = searchService.applySearch(processedData, searchText);
        processedData = sortService.applySort(processedData, sortList);
        return AsyncValue.data(processedData);
      },
    );
  }
}
