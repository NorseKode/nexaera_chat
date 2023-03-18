import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Headline extends StatelessWidget {
  const Headline({super.key, required this.title, this.color});

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.headlineMedium!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 32, color: color),
    );
  }
}
