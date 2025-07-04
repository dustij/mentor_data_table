import "dart:async";

import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../providers/search_notifier.dart";
import "../theme/shadcn_theme.dart";

class TableSearchBar extends HookConsumerWidget {
  const TableSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    useListenable(controller);

    final searchNotifier = ref.read(searchNotifierProvider.notifier);
    void onSearch(String text) => searchNotifier.set(text);

    useDebouncedSearch(controller, onSearch);

    // Local state for showing filters menu
    final isFilterMenuOpen = useState(false);

    return SearchBarTheme(
      data: ShadcnTheme.tableSearchBarTheme,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
                child: SearchBar(
                  hintText: "Search",
                  controller: controller,
                  onSubmitted: onSearch,
                  trailing: controller.text.isNotEmpty
                      ? [
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controller.clear();
                              onSearch("");
                            },
                          ),
                        ]
                      : null,
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  leading: const Icon(Icons.search),
                ),
              ),
              // ---------------------------------
              // Filter Button
              // ---------------------------------
              FilledButtonTheme(
                data: ShadcnTheme.filterButtonTheme,
                child: FilledButton.icon(
                  onPressed: () {
                    isFilterMenuOpen.value = !isFilterMenuOpen.value;
                  },
                  label: const Text("Filter"),
                  icon: const Icon(Icons.filter_list),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void useDebouncedSearch(
  TextEditingController controller,
  void Function(String) onSearch, {
  Duration delay = const Duration(milliseconds: 300),
}) {
  final debounce = useRef<Timer?>(null);

  useEffect(() {
    void listener() {
      debounce.value?.cancel();
      debounce.value = Timer(delay, () {
        onSearch(controller.text);
      });
    }

    controller.addListener(listener);
    return () {
      controller.removeListener(listener);
      debounce.value?.cancel();
    };
  }, [controller]);
}
