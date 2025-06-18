import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../provider/form_entries_provider.dart";
import "../provider/form_entry.dart";

class MentorTable extends HookConsumerWidget {
  const MentorTable({super.key});

  List<DataColumn> _createColumns(WidgetRef ref) {
    final notifier = ref.read(formEntriesProvider.notifier);
    return FormEntry.fields.map((field) {
      return DataColumn(
        label: Text(field),
        onSort: (_, _) {
          // Get the function for the selected column to compare its values between two rows.
          // final getter = FormEntry.fieldGetters[field]!;
          // notifier.sortBy(field, (a, b) => getter(a).compareTo(getter(b)));
          notifier.sortBy(field, (a, b) => a[field].compareTo(b[field]));
        },
      );
    }).toList();
  }

  List<DataRow> _createRows(List<FormEntry> entries) {
    return entries.map((entry) {
      return DataRow(
        cells: [
          DataCell(Text(entry.mentorName)),
          DataCell(Text(entry.studentName)),
          DataCell(Text(entry.sessionDetails)),
          DataCell(Text(entry.notes)),
        ],
      );
    }).toList();
  }

  void _search(String value, WidgetRef ref) {
    final notifier = ref.read(formEntriesProvider.notifier);
    notifier.filterBy(
      (entry) =>
          entry.mentorName.contains(value) ||
          entry.studentName.contains(value) ||
          entry.sessionDetails.contains(value) ||
          entry.notes.contains(value),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final hasText = useState(false);

    useEffect(() {
      controller.addListener(() {
        hasText.value = controller.text.isNotEmpty;
      });
      return null;
    }, []);

    // async because likely fetching from database via http request
    final asyncData = ref.watch(formEntriesProvider);

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              // Search Field
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    border: OutlineInputBorder(),
                    suffixIcon: hasText.value
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              controller.clear();
                              _search("", ref);
                            },
                          )
                        : null,
                  ),
                  onSubmitted: (value) => _search(value, ref),
                ),
              ),
              SizedBox(width: 8),
              // Filter Button
              ElevatedButton.icon(
                onPressed: () => {} /* TODO */,
                icon: Icon(Icons.filter_list),
                label: Text("Filter"),
              ),
              Spacer(),
              // Download Button
              ElevatedButton.icon(
                onPressed: () => {} /* TODO */,
                icon: Icon(Icons.download),
                label: Text("Download"),
              ),
            ],
          ),
          Expanded(
            child: asyncData.when(
              data: (entries) => Center(
                child: SizedBox.expand(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: _createColumns(ref),
                      rows: _createRows(entries),
                    ),
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Error: $error",
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
