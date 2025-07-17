/// Module: Export XLS Service
///
/// Provides a high-level service to generate and export mentor session data
/// to an Excel file (`.xlsx`). Uses Syncfusion XlsIO to build the workbook,
/// populates headers and rows from `MentorSession` data, and delegates the
/// file writing/ download to the platform-specific exporter.
///
/// **Setup:**
/// - Add `syncfusion_flutter_xlsio` and the necessary platform exporter
///   dependencies (`path_provider`, `open_file`, `universal_html`) in
///   `pubspec.yaml`.
/// - Ensure asset permissions and file system access are configured
///   for native platforms.
library;

import "dart:typed_data";

import "package:excel/excel.dart";

import "../../../domain/models/filter/filter.dart";
import "../../../domain/models/mentor_session/mentor_session.dart";

import "_internal/platform_export.dart";

/// A service class for creating and exporting an XLSX report of mentor sessions.
///
/// Contains a single static method `exec` which builds the workbook, populates
/// headers and data rows, then calls `exportXlsPlatformSpecific` to write or
/// download the file.
class ExportXlsService {
  /// Builds an Excel workbook from the provided mentor session data and exports it.
  ///
  /// **Parameters:**
  /// - `fileName` (`String`, required): Desired base name for the output file (without extension).
  /// - `data` (`List<MentorSession>`, required): The list of session records to include.
  ///
  /// **Returns:** `Future<bool>`
  /// - Completes with `true` if export succeeded, `false` on any error.
  ///
  /// **Example:**
  /// ```dart
  /// final sessions = await fetchSessions();
  /// final success = await ExportXlsService.exec(
  ///   fileName: "mentor_sessions_report",
  ///   data: sessions,
  /// );
  /// if (!success) {
  ///   // handle failure
  /// }
  /// ```
  static Future<bool> exec({
    required String fileName,
    required List<MentorSession> data,
  }) async {
    try {
      final excel = Excel.createExcel();
      final sheet = excel["Sheet1"];

      // H E A D E R S
      for (int i = 0; i < Field.values.length; i++) {
        sheet.cell(CellIndex.indexByString("${column(i)}1")).value =
            TextCellValue(Field.values[i].text);
      }

      // R O W S
      for (int row = 0; row < data.length; row++) {
        for (int col = 0; col < Field.values.length; col++) {
          sheet
              .cell(CellIndex.indexByString("${column(col)}${row + 2}"))
              .value = TextCellValue(switch (col) {
            0 => data[row].mentorName,
            1 => data[row].studentName,
            2 => data[row].sessionDetails,
            3 => data[row].notes,

            // To make Dart happy; This shouldn't ever happen though
            int() => throw UnimplementedError(
              "$col is out of range for entry fields",
            ),
          });
        }
      }

      fileName = fileName.endsWith(".xlsx") ? fileName : "$fileName.xlsx";
      final bytes = Uint8List.fromList(excel.save()!);
      final isSuccess = await exportXlsPlatformSpecific(bytes, fileName);
      return isSuccess;
    } catch (_) {
      return false;
    }
  }
}

/*
class ExportXlsService {
  static Future<bool> exec({
    required String fileName,
    required List<MentorSession> data,
  }) async {
    try {
      final workbook = Workbook();
      final sheet = workbook.worksheets[0];

      // Headers
      for (int i = 0; i < Field.values.length; i++) {
        sheet.getRangeByName("${column(i)}1").setText(Field.values[i].text);
      }

      // Entries
      for (int row = 0; row < data.length; row++) {
        for (int col = 0; col < Field.values.length; col++) {
          sheet.getRangeByName("${column(col)}${row + 2}").setText(
            switch (col) {
              0 => data[row].mentorName,
              1 => data[row].studentName,
              2 => data[row].sessionDetails,
              3 => data[row].notes,

              // To make Dart happy, this shouldn't ever happen though
              int() => throw UnimplementedError(
                "$col is out of range for entry fields",
              ),
            },
          );
        }
      }

      final bytes = Uint8List.fromList(workbook.saveAsStream());

      workbook.dispose();

      fileName = fileName.endsWith(".xlsx") ? fileName : "$fileName.xlsx";
      final isSuccess = await exportXlsPlatformSpecific(bytes, fileName);
      return isSuccess;
    } catch (_) {
      return false;
    }
  }
}
*/

/// Converts a zero-based column index to its Excel column letter.
///
/// Maps 0→"A", 1→"B", …, 25→"Z"; wraps around for indices ≥26.
///
/// **Parameters:**
/// - `index` (`int`): Zero-based column number.
///
/// **Returns:** `String` Excel column letter.
///
/// **Example:**
/// ```dart
/// column(0); // "A"
/// column(27); // "B" (wrap-around)
/// ```
String column(int index) {
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
