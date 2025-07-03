import "package:flutter/material.dart";
import "package:mentor_data_table/models/entry.dart";

Future<void> download({
  required BuildContext context,
  required List<Entry> processedData,
}) async {
  try {
    _download(processedData);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Download completed successfully")),
      );
    }
  } catch (error, _) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Download failed: $error")));
    }
  }
}

Future<void> _download(List<Entry> processedData) async {}
