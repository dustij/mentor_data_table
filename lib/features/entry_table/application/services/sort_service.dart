import "../../domain/entry.dart";
import "../../domain/sort.dart";

class SortService {
  List<Entry> applySort(List<Entry> entries, List<Sort> sortList) {
    final newEntries = List<Entry>.from(entries);

    newEntries.sort((a, b) {
      for (final sort in sortList) {
        final aVal = a[sort.field];
        final bVal = b[sort.field];
        final result = aVal.compareTo(bVal);
        if (result != 0) {
          return sort.direction == SortDirection.asc ? result : -result;
        }
      }
      return 0;
    });

    return newEntries;
  }
}
