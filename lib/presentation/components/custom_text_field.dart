import 'package:flutter/material.dart';

class TextFieldDefault extends StatelessWidget {
  const TextFieldDefault({super.key, this.icon, required this.hint});

  final IconData? icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextField(
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
