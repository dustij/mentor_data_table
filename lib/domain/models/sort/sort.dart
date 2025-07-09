/// Module: Sort Model
///
/// Defines sorting criteria for `MentorSession` records, specifying which field
/// to sort by and in which direction (ascending, descending, or none).
library;

import "package:flutter/foundation.dart";

// See: https://pub.dev/documentation/freezed/latest/#run-the-generator
import "package:freezed_annotation/freezed_annotation.dart";

import "../filter/filter.dart";

part "sort.freezed.dart";

/// The direction to apply for sorting operations.
///
/// - `asc`: Sort in ascending order.
/// - `desc`: Sort in descending order.
/// - `none`: No sorting applied.
enum SortDirection { asc, desc, none }

/// A value object representing a sort criterion.
///
/// Combines:
/// - `field`: the session property to sort by.
/// - `sortDirection`: the direction of the sort.
@freezed
abstract class Sort with _$Sort {
  const factory Sort({
    /// The session property to sort by.
    required Field field,

    /// The direction in which to sort the field.
    required SortDirection sortDirection,
  }) = _Sort;
}
