import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.teal : Colors.grey[300],
        foregroundColor: isPrimary ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
