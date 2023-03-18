import 'package:flutter/material.dart';
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
        body: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              constraints: const BoxConstraints(maxWidth: 800),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text("hello")]))))),
            ),
          ],
        ));
  }
}
