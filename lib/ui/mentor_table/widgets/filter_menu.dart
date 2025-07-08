import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../domain/models/filter/filter.dart";
import "../../core/themes/shadcn_theme.dart";
import "../view_models/table_viewmodel.dart";

class FilterMenu extends HookConsumerWidget {
  const FilterMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tableViewModelProvider);
    final viewModel = ref.read(tableViewModelProvider.notifier);

    // Extract current filters or fallback to empty list
    final filters = state.when(
      loading: () => <Filter>[],
      error: (_, __) => <Filter>[],
      data: (s) => s.filters,
    );

    // Initialize local drafts from the filters snapshot
    final localFilterListState = useState<List<_FilterDraft>>([
      if (filters.isEmpty) _FilterDraft.blank(),
      ...filters.map(
        (f) => _FilterDraft(
          field: f.field,
          operator: f.filterOperator,
          text: f.filterText,
        ),
      ),
    ]);

    return SizedBox(
      width: 900,
      child: IntrinsicHeight(
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(16, 16, 16, 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Advanced Filters",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                //------------------------------
                // Filter list
                //------------------------------
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 400),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final filterDraft in localFilterListState.value)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            child: _FilterForm(
                              filterDraft: filterDraft,
                              onDelete: () {
                                if (localFilterListState.value.length > 1) {
                                  localFilterListState.value =
                                      localFilterListState.value
                                          .where((f) => f != filterDraft)
                                          .toList();
                                } else {
                                  localFilterListState.value = [
                                    _FilterDraft.blank(),
                                  ];
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                //------------------------------
                // Buttons (bottom)
                //------------------------------
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    border: BoxBorder.fromLTRB(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
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
                            _setFilters(
                              viewModel.setFilters,
                              localFilterListState,
                            );
                            viewModel.toggleFilterMenu();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setFilters(
    Function(List<Filter>) setFilters,
    ValueNotifier<List<_FilterDraft>> localFilterListState,
  ) {
    setFilters(
      localFilterListState.value
          .where((draft) => draft.isValid())
          .map(
            (draft) => Filter(
              field: draft.field!,
              filterOperator: draft.operator!,
              filterText: draft.textController.text,
            ),
          )
          .toList(),
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
              items: Field.values
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
  Field? field;
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
