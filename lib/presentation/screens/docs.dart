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
                                    onTap: () =>
                                        context.goNamed('docs', extra: menuDoc),
                                    child: Text(menuDoc.displayName,
                                        style: theme.textTheme.bodyMedium!
                                            .apply(
                                                color: menuDoc == document
                                                    ? theme
                                                        .colorScheme.onSurface
                                                    : theme.colorScheme
                                                        .onSurfaceVariant)),
                                  );
                                })
                                // [
                                //   Text("Introduction"),
                                //   SizedBox(height: 12),
                                //   Paragraph("Quickstart"),
                                //   SizedBox(height: 12),
                                //   Paragraph("Library"),
                                //   SizedBox(height: 12),
                                //   Paragraph("Models"),
                                //   SizedBox(height: 12),
                                //   Paragraph("API"),
                                //   SizedBox(height: 12),
                                //   Paragraph("Tutorials"),
                                //   SizedBox(height: 12),
                                //   Paragraph("Authentication"),
                                //   SizedBox(height: 12),
                                //   Paragraph("Data usage policies"),
                                // ],
                                ),
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
                                      content: document.content
                                      // Section(title: 'Overview', content: [
                                      //   Paragraph(
                                      //     "Nexæra is a SaaS solution that provides a customizable chatbot interface for companies to use based on their own data. With Nexæra, companies can create a chatbot that can answer customer questions, provide product recommendations, and offer personalized solutions. The chatbot interface can be easily integrated into the company's website or app, providing customers with a seamless experience.",
                                      //   ),
                                      // ]),
                                      // Section(title: 'Token', content: [
                                      //   Paragraph("test"),
                                      // ]),
                                      // Section(title: 'AI capabilities', content: [
                                      //   Paragraph(
                                      //       "Our AI is a cutting-edge AI chatbot that can help your company gain valuable insights from your data. It can work with structured and unstructured data, including text, images, and numerical data, and is trained on a variety of industries and domains. Our AI can provide insights on topics such as customer behavior, market trends, and product performance using your own company data. With its powerful natural language processing capabilities, Our AI can understand and respond to your queries in a conversational manner, making it easy to get the insights you need. Whether you need to analyze customer feedback, monitor social media sentiment, or make data-driven decisions, Our AI is here to help you.")
                                      // ])
                                      ),
                                ]),
                          ),
                        ],
                      ))))),
    );
  }
}
