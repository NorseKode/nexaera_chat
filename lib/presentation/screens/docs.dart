import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/components/paragraph_text.dart';
import 'package:nexaera_chat/presentation/components/section.dart';
import 'package:nexaera_chat/presentation/section/doc.dart';
import 'package:unicons/unicons.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';
import '../constants/documents.dart';

class DocsScreen extends StatelessWidget {
  const DocsScreen({super.key, required this.document});

  final Document document;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    //Should be added to database

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Wrap(
                                runSpacing: 12,
                                children: List.generate(Document.values.length,
                                    (index) {
                                  var menuDoc = Document.values[index];
                                  return GestureDetector(
                                    onTap: () => context.goNamed('docs',
                                        params: {'doc': menuDoc.name}),
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(menuDoc.displayName,
                                          style: theme.textTheme.bodyMedium!
                                              .apply(
                                                  color: menuDoc == document
                                                      ? theme
                                                          .colorScheme.onSurface
                                                      : theme.colorScheme
                                                          .onSurfaceVariant)),
                                    ),
                                  );
                                })),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomTextField(
                                    hint: "Search",
                                    prefixIcon: UniconsLine.search,
                                  ),
                                  const SizedBox(height: 32),
                                  Doc(
                                      title: document.displayName,
                                      content: document.content),
                                ]),
                          ),
                        ],
                      ))))),
    );
  }
}
