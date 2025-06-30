import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:mentor_data_table/providers/table_state.dart";

class TableSearchBar extends ConsumerWidget {
  const TableSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableStateNotifier = ref.read(tableStateProvider.notifier);
    ;
    // TODO: implement build
    throw UnimplementedError();
  }
}
