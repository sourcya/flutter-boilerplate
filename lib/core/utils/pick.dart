import 'package:flutter/material.dart';

/// Handle picking process (date,time,image,location...etc)
abstract class Pick {
  Future<DateTime?> date(
    BuildContext context, {
    /// if null will use `DateTime.now()`
    DateTime? initialDate,

    /// if null will use `DateTime(1950)`
    DateTime? fDate,

    /// if null will use `DateTime.now()`
    DateTime? lDate,
  }) =>
      showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: fDate ?? DateTime(1950),
        lastDate: lDate ?? DateTime.now(),
      );
}
