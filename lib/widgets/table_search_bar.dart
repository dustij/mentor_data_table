import "dart:async";

import "package:flutter/material.dart";

import "package:flutter_hooks/flutter_hooks.dart";

class TableSearchBar extends HookWidget {
  final void Function(String query) onSearch;

  const TableSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    useDebouncedSearch(controller, onSearch);

    return Container(
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
                    onSearch('');
                  },
                ),
              ]
            : null,
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16.0),
        ),
        leading: const Icon(Icons.search),
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
