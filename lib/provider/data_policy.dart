import 'form_entry.dart';

abstract interface class DataPolicy {
  Future<List<FormEntry>> fetchEntries();
}

/// Example policy used for development and debugging.
/// It loads dummy data from a local JSON file located in the `example/` directory.
class ExamplePolicy implements DataPolicy {
  const ExamplePolicy();
  @override
  Future<List<FormEntry>> fetchEntries() {
    // TODO: implement fetchEntries
    throw UnimplementedError();
  }
}

// Choose policy here
const DataPolicy activePolicy = ExamplePolicy();
