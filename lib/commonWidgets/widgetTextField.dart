import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetTextField extends StatelessWidget {
  final TextEditingController controller;
  // final FocusNode focusNode;
  final String labelText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback onEditingComplete;
  final Widget? suffixIcon;
  final void Function(dynamic value)? onChanged; // Updated this line

  // New parameter for suffix icon

  const WidgetTextField({
    Key? key,
    required this.controller,
    //required this.focusNode,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    required this.onEditingComplete,
    this.suffixIcon,
    this.onChanged, // Added this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
          ),
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
