import 'package:expense_tracker/widgets/form_widgets/amount_input_field.dart';
import 'package:expense_tracker/widgets/form_widgets/category_dropdown.dart';
import 'package:expense_tracker/widgets/form_widgets/date_picker.dart';
import 'package:expense_tracker/widgets/form_widgets/title_input_field.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  // async + await OR .then to handle future objects
  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _updateCategory(Category? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _selectedCategory = value;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        category: _selectedCategory,
        date: _selectedDate!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose(); // Dispose of this controller to free memory
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, keyboardSpace + 16.0),
          child: Column(
            children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleInputField(
                      inputController: _titleController,
                      isExpanded: true,
                    ),
                    const SizedBox(width: 24),
                    AmountInputField(
                      inputController: _amountController,
                    ),
                  ],
                )
              else
                TitleInputField(
                  inputController: _titleController,
                  isExpanded: false,
                ),
              if (width >= 600)
                Row(
                  children: [
                    CategoryDropdown(value: _selectedCategory, onChanged: _updateCategory),
                    DatePicker(
                        date: _selectedDate, onShowDatePicker: _showDatePicker),
                  ],
                )
              else
                Row(
                  children: [
                    AmountInputField(
                      inputController: _amountController,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    DatePicker(
                        date: _selectedDate, onShowDatePicker: _showDatePicker),
                  ],
                ),
              const SizedBox(
                height: 16,
              ),
              if (width >= 600)
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    CategoryDropdown(value: _selectedCategory, onChanged: _updateCategory),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
            ],
          ),
        ),
      );
    });
  }
}
