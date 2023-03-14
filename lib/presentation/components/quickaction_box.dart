import 'package:flutter/material.dart';

class QuickActionBox extends StatelessWidget {
  const QuickActionBox(
      {super.key, required this.title, required this.category});

  final String title;
  final String category;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
        constraints: BoxConstraints(minWidth: 200),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category, style: theme.textTheme.labelSmall),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium,
            )
          ],
        ));
  }
}
