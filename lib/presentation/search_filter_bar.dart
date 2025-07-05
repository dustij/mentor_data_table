import "dart:async";

import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../providers/filter_menu_open_notifier.dart";
import "../providers/search_notifier.dart";
import "../theme/shadcn_theme.dart";

class SearchFilterBar extends HookConsumerWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Toggle filter menu
    final filterMenuOpenNotifier = ref.read(
      filterMenuOpenNotifierProvider.notifier,
    );

    final controller = useTextEditingController();
    useListenable(controller);

    final searchNotifier = ref.read(searchNotifierProvider.notifier);
    void onSearch(String text) => searchNotifier.set(text);

    useDebouncedSearch(controller, onSearch);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                left: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            height: 48,
            width: 400,
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
              // Override theme
              shape: const WidgetStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              backgroundColor: const WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
              elevation: const WidgetStatePropertyAll<double>(0),
              overlayColor: const WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
              surfaceTintColor: const WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
            ),
          ),
          // ---------------------------------
          // Filter Button
          // ---------------------------------
          FilledButtonTheme(
            data: ShadcnTheme.filterButtonTheme,
            child: FilledButton.icon(
              onPressed: () => filterMenuOpenNotifier.toggle(),
              label: const Text("Filter"),
              icon: const Icon(Icons.filter_alt),
            ),
          ),
        ],
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
