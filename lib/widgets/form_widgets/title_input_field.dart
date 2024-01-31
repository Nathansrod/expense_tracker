import 'package:flutter/material.dart';

class TitleInputField extends StatelessWidget {
  const TitleInputField(
      {super.key, required this.inputController, required this.isExpanded});

  final TextEditingController inputController;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return Expanded(
        child: TextField(
          controller: inputController,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('Title'),
          ),
        ),
      );
    }
    return TextField(
      controller: inputController,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );
  }
}
