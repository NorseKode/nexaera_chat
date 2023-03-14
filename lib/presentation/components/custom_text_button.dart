import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, required this.onPressed, required this.text, this.color});

  final VoidCallback onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextButton(
        style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.onSurface,
            textStyle: theme.textTheme.headlineSmall!.copyWith(fontSize: 16),
            backgroundColor: color ?? theme.colorScheme.surface,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32)),
        onPressed: onPressed,
        child: Text(text));
  }
}
