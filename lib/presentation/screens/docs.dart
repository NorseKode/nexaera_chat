import 'package:flutter/material.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:unicons/unicons.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';

class DocsScreen extends StatelessWidget {
  const DocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        width: double.infinity,
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
                              Text(
                                  "Nexæra is a SaaS solution that provides a customizable chatbot interface for companies to use based on their own data. With Nexæra, companies can create a chatbot that can answer customer questions, provide product recommendations, and offer personalized solutions. The chatbot interface can be easily integrated into the company's website or app, providing customers with a seamless experience.",
                                  style: theme.textTheme.bodyMedium!.apply(
                                      color:
                                          theme.colorScheme.onSurfaceVariant)),
                              const SizedBox(height: 32),
                              Text('Tokens',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 16),
                              Text("Test",
                                  style: theme.textTheme.bodyMedium!.apply(
                                      color:
                                          theme.colorScheme.onSurfaceVariant))
                            ]))))));
  }
}
