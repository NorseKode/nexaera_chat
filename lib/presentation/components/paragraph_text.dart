import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Paragraph extends StatelessWidget {
  const Paragraph(this.text, {super.key, this.align});

  final String text;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.bodyMedium!
          .apply(color: theme.colorScheme.onSurfaceVariant),
      textAlign: align,
    );
  }
}
