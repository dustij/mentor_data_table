import "dart:async";

import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../shared/theme/shadcn_theme.dart";
import "../application/providers/search_notifier.dart";

class TableSearchBar extends HookConsumerWidget {
  const TableSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    useListenable(controller);

    final searchNotifier = ref.read(searchNotifierProvider.notifier);
    void onSearch(String text) => searchNotifier.set(text);

    useDebouncedSearch(controller, onSearch);

    return SearchBarTheme(
      data: ShadcnTheme.tableSearchBarTheme,
      child: Container(
        padding: const EdgeInsets.all(8.0),
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
