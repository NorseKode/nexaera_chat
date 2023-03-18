import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:unicons/unicons.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox(this.errorMessage, {super.key});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: double.infinity,
      child: Text(
        errorMessage,
        style: TextStyle().apply(color: theme.colorScheme.error),
      ),
    );
  }
}
