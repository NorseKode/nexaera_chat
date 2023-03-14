import 'package:flutter/material.dart';
import 'package:nexaera_chat/presentation/components/custom_text_button.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/components/paragraph_text.dart';
import 'package:nexaera_chat/presentation/components/quickaction_box.dart';
import 'package:unicons/unicons.dart';

import '../components/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Headline(title: "Let's get started"),
                              const SizedBox(height: 16),
                              const Paragraph(
                                  "Welcome to Nexæra - A powerful AI chatbot that allows you to easily interact with your data. Upload your own data or provide a domain, and our AI will provide insightful answers to your queries.\n\nQuickly search for specific topics or keywords, access featured data sets, and easily view chat history. Let's get started!"),
                              const SizedBox(height: 32),
                              Row(
                                children: [
                                  CustomTextButton(
                                      onPressed: () {}, text: 'Add data'),
                                  const SizedBox(width: 32),
                                  CustomTextButton(
                                    onPressed: () {},
                                    text: 'Start Chatting',
                                    color: theme.colorScheme.primary,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Text('Chat history',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 16),
                              Container(
                                  width: double.infinity,
                                  color: theme.colorScheme.surface,
                                  height: 200),
                              const SizedBox(height: 32),
                              Text('Learn about',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 16),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    QuickActionBox(
                                        title: 'Token Usage',
                                        category: 'INTRODUCTION'),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    QuickActionBox(
                                        title: 'Domain Scraping',
                                        category: 'INTRODUCTION'),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    QuickActionBox(
                                        title: 'Domain Scraping',
                                        category: 'INTRODUCTION'),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    QuickActionBox(
                                        title: 'Domain Scraping',
                                        category: 'INTRODUCTION'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              Text('Featured data sets',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 16),
                              Container(
                                  width: double.infinity,
                                  color: theme.colorScheme.surface,
                                  height: 200),
                              const SizedBox(height: 32),
                              Text('AI capabilities',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 16),
                              Container(
                                  width: double.infinity,
                                  color: theme.colorScheme.surface,
                                  height: 200),
                              const SizedBox(height: 32),
                              Text('Social proof',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 16),
                              Container(
                                  width: double.infinity,
                                  color: theme.colorScheme.surface,
                                  height: 200),
                              const SizedBox(height: 32),
                              Text('Privacy and Support',
                                  style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 16),
                              Container(
                                  width: double.infinity,
                                  color: theme.colorScheme.surface,
                                  height: 200),
                            ]))))));
  }

  test() {
    return Column(
      children: [
        Text('Name'),
        const SizedBox(height: 32),
        Text('Brief description'),
        const SizedBox(height: 32),
        Text(
            'Get started and a start chatting buttons: Quick actions: Provide shortcuts or buttons to commonly used actions such as uploading data or starting a new conversation with the AI.'),
        Text(
            'Chat history: Display a list of recent conversations or queries to help users easily pick up where they left off.'),
        const SizedBox(height: 32),
        Text(
            'Featured data sets: Showcase some of the most popular or interesting data sets that companies can use to train the AI, which can help inspire users to start uploading their own data.'),
        const SizedBox(height: 32),
        Text(
            'AI capabilities: Explain the capabilities of the AI, including what types of questions it can answer and what kind of data it can work with.'),
        const SizedBox(height: 32),
        const SizedBox(height: 32),
        Text(
            "Social proof: Add some social proof, such as testimonials or user reviews, to establish credibility and build trust with your users.\nPrivacy policy and terms of service: Display links to your privacy policy and terms of service to ensure transparency and compliance with legal requirements.\nSupport options: Include links to support options, such as a help center or a contact form, to assist users if they encounter any issues with your app.")
      ],
    );
  }
}
