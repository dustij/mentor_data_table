import "package:flutter/material.dart";

import "package:hooks_riverpod/hooks_riverpod.dart";

import "../models/entry.dart";
import "../services/export/xls_export_service.dart";

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key, required this.exportData});

  final AsyncValue<List<Entry>> exportData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        exportData.when(
          data: (data) {
            final exportService = XlsExportService();
            exportService.export(
              fileName: "CSC_Mentor_Table",
              context: context,
              data: data,
            );
          },
          error: (_, _) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Oops! Something went wrong.")),
          ),
          loading: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Cool! Your download is started.")),
          ),
        );
      },
      icon: Icon(Icons.download),
      label: Text("Download"),
    );
  }
}
