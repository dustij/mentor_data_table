import "../models/form_entry.dart";
import "../models/sort_state.dart";

abstract class SortService {
  List<SortState> updateSortOrder({
    required List<SortState> currentOrder,
    required Field field,
  });

  List<FormEntry> applySort({
    required List<FormEntry> data,
    required List<SortState> sortOrder,
  });
}

class SortServiceImpl implements SortService {
  @override
  List<SortState> updateSortOrder({
    required List<SortState> currentOrder,
    required Field field,
  }) {
    // TODO: implement updateSortOrder
    throw UnimplementedError();
  }

  @override
  List<FormEntry> applySort({
    required List<FormEntry> data,
    required List<SortState> sortOrder,
  }) {
    // TODO: implement applySort
    throw UnimplementedError();
  }
}
