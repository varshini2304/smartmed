import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType inputType;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
