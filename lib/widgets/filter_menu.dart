import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:mentor_data_table/providers/table_state.dart";

class FilterMenu extends ConsumerWidget {
  final void Function() onClose;

  const FilterMenu({super.key, required this.onClose});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = ref.watch(tableStateProvider);
    final tableStateNotifier = ref.read(tableStateProvider.notifier);

    // TODO: implement build
    throw UnimplementedError();
  }
}
