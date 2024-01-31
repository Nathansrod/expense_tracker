import 'package:flutter/material.dart';

class AmountInputField extends StatelessWidget {
  const AmountInputField({super.key, required this.inputController});

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: inputController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          label: Text('Amount'),
          prefixText: '\$ ',
        ),
      ),
    );
  }
}
