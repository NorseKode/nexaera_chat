import 'package:flutter/material.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/components/paragraph_text.dart';
import 'package:unicons/unicons.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';

class DocsScreen extends StatelessWidget {
  const DocsScreen({super.key});

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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Introduction"),
                                SizedBox(height: 12),
                                Paragraph("Quickstart"),
                                SizedBox(height: 12),
                                Paragraph("Library"),
                                SizedBox(height: 12),
                                Paragraph("Models"),
                                SizedBox(height: 12),
                                Paragraph("API"),
                                SizedBox(height: 12),
                                Paragraph("Tutorials"),
                                SizedBox(height: 12),
                                Paragraph("Authentication"),
                                SizedBox(height: 12),
                                Paragraph("Data usage policies"),
                              ],
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
                                  const Headline(title: 'Introduction'),
                                  const SizedBox(height: 32),
                                  Text('Overview',
                                      style: theme.textTheme.headlineSmall),
                                  const SizedBox(height: 16),
                                  Paragraph(
                                    "Nexæra is a SaaS solution that provides a customizable chatbot interface for companies to use based on their own data. With Nexæra, companies can create a chatbot that can answer customer questions, provide product recommendations, and offer personalized solutions. The chatbot interface can be easily integrated into the company's website or app, providing customers with a seamless experience.",
                                  ),
                                  const SizedBox(height: 32),
                                  Text('Tokens',
                                      style: theme.textTheme.headlineSmall),
                                  const SizedBox(height: 16),
                                  Paragraph("test"),
                                  const SizedBox(height: 32),
                                  Text('Tokens',
                                      style: theme.textTheme.headlineSmall),
                                  const SizedBox(height: 16),
                                  Paragraph("test"),
                                  const SizedBox(height: 32),
                                  Text('Tokens',
                                      style: theme.textTheme.headlineSmall),
                                  const SizedBox(height: 16),
                                  Paragraph("test"),
                                ]),
                          ),
                        ],
                      ))))),
    );
  }
}
