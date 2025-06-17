import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.keyboardType,
    required this.onChanged,
    super.key,
    this.labelText,
    this.hintText,
    this.errorText,
    this.isPasswordField = false,
    this.textInputAction = TextInputAction.done,
  });

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
    ),
    textInputAction: textInputAction,
    obscureText: isPasswordField,
    onChanged: onChanged,
  );
}
