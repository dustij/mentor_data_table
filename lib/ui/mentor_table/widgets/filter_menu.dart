import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mentor_data_table/ui/core/breakpoints.dart";

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
      width: context.responsive(base: 340, sm: 600, md: 720),
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
                        for (
                          int i = 0;
                          i < localFilterListState.value.length;
                          i++
                        )
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            child: _FilterForm(
                              index: i,
                              filterDraft: localFilterListState.value[i],
                              onDelete: () {
                                if (localFilterListState.value.length > 1) {
                                  localFilterListState
                                      .value = localFilterListState.value
                                      .where(
                                        (f) =>
                                            f != localFilterListState.value[i],
                                      )
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
                          localFilterListState.value = [
                            ...localFilterListState.value,
                            _FilterDraft.blank(),
                          ];
                        },
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          child: Text(
                            context.responsive(
                              base: "Apply",
                              sm: "Apply Filters",
                            ),
                          ),
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
  final int index;

  const _FilterForm({
    required this.filterDraft,
    required this.onDelete,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Raw form fields without flex
    final rawFields = [
      DropdownButtonFormField<Field>(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
        value: filterDraft.field,
        hint: const Text("Choose a field"),
        items: Field.values
            .map((f) => DropdownMenuItem(value: f, child: Text(f.text)))
            .toList(),
        onChanged: (field) => filterDraft.field = field,
      ),
      DropdownButtonFormField<FilterOperator>(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          contentPadding: const EdgeInsets.symmetric(
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
      TextFormField(
        key: ValueKey(filterDraft),
        controller: filterDraft.textController,
        decoration: InputDecoration(
          hintText: "Enter text",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: OutlinedButtonTheme(
          data: ShadcnTheme.deleteOutlinedButtonTheme,
          child: OutlinedButton(
            onPressed: onDelete,
            child: const Icon(Icons.delete, size: 20),
          ),
        ),
      ),
    ];
    return Form(
      child: Column(
        spacing: 16,
        children: [
          if (index > 0)
            Divider(height: 1, color: Theme.of(context).colorScheme.outline),
          context.responsive<Widget>(
            base: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8,
              children: rawFields,
            ),
            sm: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  // First three fields expand
                  for (var i = 0; i < rawFields.length - 1; i++)
                    Expanded(child: rawFields[i]),
                  // Delete button fixed size
                  SizedBox(width: 56.0, child: rawFields.last),
                ],
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
