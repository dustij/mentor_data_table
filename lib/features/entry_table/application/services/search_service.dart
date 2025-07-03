import "../../domain/entry.dart";

class SearchService {
  List<Entry> applySearch(List<Entry> entries, String searchText) {
    if (searchText.isEmpty) return entries;
    final lower = searchText.toLowerCase();
    return entries
        .where(
          (e) =>
              e.mentorName.toLowerCase().contains(lower) ||
              e.studentName.toLowerCase().contains(lower) ||
              e.sessionDetails.toLowerCase().contains(lower) ||
              e.notes.toLowerCase().contains(lower),
        )
        .toList();
  }
}
