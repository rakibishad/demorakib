import 'package:flutter/material.dart';


import '../extra/colors.dart';
import '../extra/common_style.dart';

import 'package:flutter/material.dart';

class TextInputFields extends StatelessWidget {
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const TextInputFields({
    super.key,
    required this.textInputType,
    required this.textInputAction,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email, color: Colors.brown),
        border: OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}


class TextInputFieldPassword extends StatelessWidget {
  final TextEditingController controller; // ✅ REQUIRED
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String labelText;
  final Icon prefixIcon;

  const TextInputFieldPassword({
    super.key,
    required this.controller, // ✅ Add this to constructor
    required this.textInputAction,
    this.validator,
    this.onChanged,
    required this.labelText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // ✅ Actually used
      obscureText: true,
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

