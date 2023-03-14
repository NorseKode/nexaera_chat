import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({super.key, required this.title, required this.content});

  final String title;
  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 16),
        ...content,
        const SizedBox(height: 32),
      ],
    );
  }
}
