import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../models/entry.dart";
import "../models/filter.dart";
import "../providers/filter_list_notifier.dart";
import "../theme/shadcn_theme.dart";

class FilterMenu extends HookConsumerWidget {
  final void Function() onClose;

  const FilterMenu({super.key, required this.onClose});

  void _setFilters(
    FilterListNotifier filterListNotifier,
    ValueNotifier<List<_FilterDraft>> localFilterListState,
  ) {
    filterListNotifier.set(
      localFilterListState.value
          .where((draft) => draft.isValid())
          .map(
            (draft) => Filter(
              field: draft.field!,
              operator: draft.operator!,
              value: draft.textController.text,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterList = ref.watch(filterListNotifierProvider);
    final filterListNotifier = ref.read(filterListNotifierProvider.notifier);

    final localFilterListState = useState<List<_FilterDraft>>([
      if (filterList.isEmpty) _FilterDraft.blank(),
      ...filterList.map(
        (f) =>
            _FilterDraft(field: f.field, operator: f.operator, text: f.value),
      ),
    ]);

    return SizedBox(
      width: 900,
      child: IntrinsicHeight(
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Advanced Filters"),
                ),
                SizedBox(height: 8),
                //------------------------------
                // Filter list
                //------------------------------
                for (final filterDraft in localFilterListState.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: _FilterForm(
                      filterDraft: filterDraft,
                      onDelete: () {
                        if (localFilterListState.value.length > 1) {
                          localFilterListState.value = localFilterListState
                              .value
                              .where((f) => f != filterDraft)
                              .toList();
                        } else {
                          localFilterListState.value = [_FilterDraft.blank()];
                        }
                      },
                    ),
                  ),
                SizedBox(height: 8),
                //------------------------------
                // Buttons (bottom)
                //------------------------------
                Row(
                  children: [
                    TextButton.icon(
                      label: Text("Add New Filter"),
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Validate filter before adding to local state
                        // if (localFilterListState.value.last.isValid()) {
                        localFilterListState.value = [
                          ...localFilterListState.value,
                          _FilterDraft.blank(),
                        ];
                        // }
                      },
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        child: Text("Apply Filter"),
                        onPressed: () {
                          _setFilters(filterListNotifier, localFilterListState);
                          onClose();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterForm extends StatelessWidget {
  final _FilterDraft filterDraft;
  final VoidCallback onDelete;

  const _FilterForm({required this.filterDraft, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              value: filterDraft.field,
              hint: Text("Choose a field"),
              items: EntryField.values
                  .map((f) => DropdownMenuItem(value: f, child: Text(f.text)))
                  .toList(),
              onChanged: (field) => filterDraft.field = field,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              value: filterDraft.operator ?? FilterOperator.includes,
              items: FilterOperator.values
                  .map((f) => DropdownMenuItem(value: f, child: Text(f.name)))
                  .toList(),
              onChanged: (operator) => filterDraft.operator = operator,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              key: ValueKey(filterDraft),
              controller: filterDraft.textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            height: 48,
            child: OutlinedButtonTheme(
              data: ShadcnTheme.deleteOutlinedButtonTheme,
              child: OutlinedButton(
                onPressed: onDelete,
                child: Icon(Icons.delete, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterDraft {
  EntryField? field;
  FilterOperator? operator;
  late TextEditingController textController;

  _FilterDraft({this.field, FilterOperator? operator, String? text})
    : operator = operator ?? FilterOperator.includes,
      textController = TextEditingController(text: text);

  _FilterDraft.blank() {
    field = null;
    operator = FilterOperator.includes;
    textController = TextEditingController(text: null);
  }

  bool isValid() {
    try {
      return field != null &&
          operator != null &&
          textController.text.isNotEmpty;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  String toString() => "[$field] [$operator] [${textController.text}]";
}
