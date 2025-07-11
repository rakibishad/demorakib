import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TextInputFields extends StatelessWidget {
  final TextEditingController controller; // ✅ Add this line
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String labelText;
  final Icon prefixIcon;

  const TextInputFields({
    super.key,
    required this.controller, // ✅ Include in constructor
    required this.textInputType,
    required this.textInputAction,
    this.validator,
    this.onChanged,
    required this.labelText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // ✅ Use it here
      keyboardType: textInputType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
