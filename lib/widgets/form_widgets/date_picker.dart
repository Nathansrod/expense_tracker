import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.date, required this.onShowDatePicker});

  final DateTime? date;
  final void Function() onShowDatePicker;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(date == null
              ? 'Pick a date'
              : dateFormatter.format(date!)),
          IconButton(
            onPressed: onShowDatePicker,
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}
