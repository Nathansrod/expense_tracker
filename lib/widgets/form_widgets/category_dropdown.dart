import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown(
      {super.key, required this.value, required this.onChanged});

  final Category value;
  final void Function(Category? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
