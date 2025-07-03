import "dart:typed_data";

import "package:flutter/material.dart";

import "package:syncfusion_flutter_xlsio/xlsio.dart";

import "../../models/entry.dart";

import "_internal/platform_export.dart";

class XlsExportService {
  void export({
    required String fileName,
    required BuildContext context,
    required List<Entry> data,
  }) async {
    final workbook = Workbook();
    final sheet = workbook.worksheets[0];

    for (int row = 0; row < data.length; row++) {
      for (int col = 0; col < EntryField.values.length; col++) {
        sheet.getRangeByName("${colChar(col)}${row + 1}").setText(switch (col) {
          0 => data[row].mentorName,
          1 => data[row].studentName,
          2 => data[row].sessionDetails,
          3 => data[row].notes,

          int() => throw UnimplementedError(
            "$col is out of range for entry fields",
          ),
        });
      }
    }

    final bytes = Uint8List.fromList(workbook.saveAsStream());

    workbook.dispose();

    fileName = fileName.endsWith(".xlsx") ? fileName : "$fileName.xlsx";
    final isSuccess = await exportXlsPlatformSpecific(bytes, fileName);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: isSuccess
              ? Text("All done! Your Excel file is good to go.")
              : Text("Oops! Something went wrong..."),
        ),
      );
    }
  }

  String colChar(int index) {
    final letters = [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z",
    ];
    final i = index % letters.length;
    return letters[i];
  }
}
