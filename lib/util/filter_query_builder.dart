import "package:mentor_data_table/models/entry.dart";

class FilterQueryBuilder {
  final List<FilterQuery> _queries = [];

  FilterQuery buildQuery() {
    if (_queries.isEmpty) {
      return _MatchAll();
    }
    if (_queries.length == 1) {
      return _queries.first;
    }
    return _And(_queries);
  }

  FilterQueryBuilder whereContains(EntryField field, String text) {
    _queries.add(_Contains(field: field, text: text));
    return this;
  }

  FilterQueryBuilder whereEquals(EntryField field, String text) {
    _queries.add(_Equals(field: field, text: text));
    return this;
  }

  FilterQueryBuilder orContains(EntryField field, String text) {
    final query = _Contains(field: field, text: text);
    if (_queries.isNotEmpty && _queries.last is _Or) {
      // Add to existing OR group
      (_queries.last as _Or).queries.add(query);
    } else {
      // Create new OR group
      _queries.add(_Or([query]));
    }
    return this;
  }

  void reset() {
    _queries.clear();
  }
}

abstract class FilterQuery {
  bool matches(Entry entry);
}

class _Contains extends FilterQuery {
  final EntryField field;
  final String text;

  _Contains({required this.field, required this.text});

  @override
  bool matches(Entry entry) {
    final content = entry[field];
    return content.toLowerCase().contains(text.toLowerCase());
  }
}

class _Equals extends FilterQuery {
  final EntryField field;
  final String text;

  _Equals({required this.field, required this.text});

  @override
  bool matches(Entry entry) {
    final content = entry[field];
    return content.toLowerCase() == text.toLowerCase();
  }
}

class _MatchAll extends FilterQuery {
  @override
  bool matches(Entry entry) => true;
}

class _And extends FilterQuery {
  final List<FilterQuery> queries;

  _And(this.queries);

  @override
  bool matches(Entry entry) {
    return queries.every((q) => q.matches(entry));
  }
}

class _Or extends FilterQuery {
  final List<FilterQuery> queries;

  _Or(this.queries);

  @override
  bool matches(Entry entry) {
    return queries.any((q) => q.matches(entry));
  }
}
