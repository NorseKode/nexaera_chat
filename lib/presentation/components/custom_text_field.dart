import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.icon,
      required this.hint,
      this.controller,
      this.keyboardType,
      this.obscureText,
      this.onSubmitted});

  final IconData? icon;
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Function(String value)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextField(
      onSubmitted: onSubmitted,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
          isDense: true,
          prefixIcon: icon != null
              ? Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant)
              : null,
          hintText: hint,
          hintStyle: theme.textTheme.bodyMedium!.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500),
          filled: true,
          fillColor: theme.colorScheme.surface,
          border: const OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}
