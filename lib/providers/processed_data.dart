import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "package:mentor_data_table/models/entry.dart";
import "package:mentor_data_table/providers/filter_list_notifier.dart";
import "package:mentor_data_table/providers/original_data.dart";
import "package:mentor_data_table/providers/search_notifier.dart";
import "package:mentor_data_table/providers/sort_list_notifier.dart";
import "package:mentor_data_table/util/table_processor.dart";

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
    return rawAsync.when(
      loading: () => const AsyncValue.loading(),
      error: (e, s) => AsyncValue.error(e, s),
      data: (originalData) {
        final processed = TableProcessor.process(
          originalData: originalData,
          filterList: filterList,
          searchText: searchText,
          sortList: sortList,
        );
        return AsyncValue.data(processed);
      },
    );
  }
}
