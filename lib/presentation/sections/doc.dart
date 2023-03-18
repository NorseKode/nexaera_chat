import 'package:flutter/material.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/components/section.dart';

class Doc extends StatelessWidget {
  const Doc({super.key, required this.title, required this.content});

  final String title;
  final List<Section> content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Headline(title: title),
        const SizedBox(height: 32),
        ...content
      ],
    );
  }
}
