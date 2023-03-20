import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:unicons/unicons.dart';
import 'package:intl/intl.dart';

class ContextManagement extends StatelessWidget {
  const ContextManagement({super.key});

  @override
  Widget build(BuildContext context) {
    List<_Resource> resources = [
      _Resource('title', DateTime.now(), _ResourceStatus.inChatContext),
      _Resource('title', DateTime.now(), _ResourceStatus.notInChatContext),
      _Resource('title', DateTime.now(), _ResourceStatus.notInChatContext),
      _Resource('title', DateTime.now(), _ResourceStatus.notInChatContext),
      _Resource('title', DateTime.now(), _ResourceStatus.loading),
      _Resource('title', DateTime.now(), _ResourceStatus.inChatContext),
      _Resource('title', DateTime.now(), _ResourceStatus.inChatContext),
    ];

    var theme = Theme.of(context);
    var headerStyle = theme.textTheme.labelLarge!
        .apply(color: theme.colorScheme.onSurfaceVariant);

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
                CustomTableCell(resources[index].title),
                CustomTableCell(resources[index].dateTime.toString()),
                CustomTableCell(resources[index].status.name)
              ]))
    ]);
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

class _Resource {
  final String title;
  final DateTime _dateTime;
  final _ResourceStatus status;

  _Resource(
    this.title,
    this._dateTime,
    this.status,
  );

  String get dateTime => DateFormat('d MMM, H:m').format(_dateTime);
}

enum _ResourceStatus { loading, inChatContext, notInChatContext }
