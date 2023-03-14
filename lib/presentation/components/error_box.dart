import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:unicons/unicons.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox(this.errorMessage, {super.key});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          const Icon(UniconsLine.exclamation_circle),
          const SizedBox(width: 16),
          Text(errorMessage),
        ],
      ),
    );
  }
}
