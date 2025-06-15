import 'submission_entry.dart';

abstract interface class DataSourcePolicy {
  Future<List<SubmissionEntry>> fetchEntries();
}

class ExampleSourcePolicy implements DataSourcePolicy {
  const ExampleSourcePolicy();
  @override
  Future<List<SubmissionEntry>> fetchEntries() {
    // TODO: implement fetchEntries
    throw UnimplementedError();
  }
}
