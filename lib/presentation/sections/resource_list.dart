import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:unicons/unicons.dart';
import 'package:intl/intl.dart';

class ResourceList extends StatelessWidget {
  const ResourceList({super.key, required this.resources});

  final List<Resource> resources;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var headerStyle = theme.textTheme.labelLarge!
        .apply(color: theme.colorScheme.onSurfaceVariant);
    var contentStyle = theme.textTheme.bodyMedium!;

    return Table(children: [
      TableRow(
          decoration: BoxDecoration(color: theme.colorScheme.surface),
          children: [
            CustomTableCell(
              'Title',
              style: headerStyle,
            ),
            CustomTableCell('Date', style: headerStyle),
            CustomTableCell('Status', style: headerStyle),
          ]),
      ...List.generate(
          resources.length,
          (index) => TableRow(children: [
                CustomTableCell(
                  resources[index].title,
                  style: contentStyle,
                ),
                CustomTableCell(
                  resources[index].dateTime.toString(),
                  style: contentStyle,
                ),
                CustomTableCell(
                  status(resources[index].status),
                  style: contentStyle,
                )
              ]))
    ]);
  }

  String status(ResourceStatus status) {
    switch (status) {
      case ResourceStatus.inChatContext:
        return 'Ready';
      case ResourceStatus.notInChatContext:
        return 'Not in context';
      case ResourceStatus.loading:
        return 'Loading...';
      default:
        return 'Unknown';
    }
  }
}

class CustomTableCell extends StatelessWidget {
  const CustomTableCell(this.content, {super.key, this.style});

  final String content;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        content,
        style: style,
      ),
    );
  }
}

class Resource {
  final String title;
  final DateTime _dateTime;
  final ResourceStatus status;

  Resource(
    this.title,
    this._dateTime,
    this.status,
  );

  String get dateTime => DateFormat('d MMM, H:m').format(_dateTime);
}

enum ResourceStatus { loading, inChatContext, notInChatContext }
