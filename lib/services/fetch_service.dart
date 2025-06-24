import "../data/fetch_policy.dart";
import "../models/form_entry.dart";

/// Service for loading `FormEntry` data using a specified [FetchPolicy].
class FetchService {
  final FetchPolicy policy;

  /// Creates a [FetchService] that delegates data loading to the given [policy].
  FetchService({required this.policy});

  /// Loads and returns all `FormEntry` items by invoking the configured [FetchPolicy].
  ///
  /// May throw exceptions from the underlying policy if fetching fails.
  Future<List<FormEntry>> fetch() {
    return policy.fetch();
  }
}
