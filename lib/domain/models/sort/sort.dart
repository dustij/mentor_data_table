import "package:flutter/foundation.dart";

// See: https://pub.dev/documentation/freezed/latest/#run-the-generator
import "package:freezed_annotation/freezed_annotation.dart";

import "../filter/filter.dart";

part "sort.freezed.dart";

enum SortDirection { asc, desc, none }

@freezed
abstract class Sort with _$Sort {
  const factory Sort({
    required Field field,
    required SortDirection sortDirection,
  }) = _Sort;
}
