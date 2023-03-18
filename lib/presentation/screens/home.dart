import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexaera_chat/presentation/components/custom_text_button.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/components/paragraph_text.dart';
import 'package:nexaera_chat/presentation/components/quickaction_box.dart';
import 'package:nexaera_chat/presentation/components/section.dart';
import 'package:unicons/unicons.dart';

import '../components/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
            child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                width: double.infinity,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Headline(title: "Welcome to Nexæra"),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextButton(
                          onPressed: () => context.goNamed('workshop'),
                          text: 'Add data'),
                      const SizedBox(width: 32),
                      CustomTextButton(
                        onPressed: () => context.goNamed('chat'),
                        text: 'Start Chatting',
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ])),
          ),
        ));
  }
}
