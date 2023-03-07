import 'package:flutter/material.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:unicons/unicons.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                              const Headline(title: 'Welcome to NEXÆRA'),
                              const SizedBox(height: 32),
                              Text(
                                'Choose your domain',
                                style: theme.textTheme.headlineSmall!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                  "In order to get started, please input a domain that you own",
                                  style: theme.textTheme.bodyMedium!.apply(
                                      color:
                                          theme.colorScheme.onSurfaceVariant)),
                              const SizedBox(height: 8),
                              Text(
                                  "Nexæra scans this domain for all information available and you will be able to interact with it through our chat or edit it in the workshop",
                                  style: theme.textTheme.bodyMedium!.apply(
                                      color:
                                          theme.colorScheme.onSurfaceVariant)),
                              const SizedBox(height: 32),
                              CustomTextField(
                                hint: 'yourdomain.com',
                                onSubmitted: (value) => print(value),
                              ),
                              const SizedBox(height: 32),
                            ]))))));
  }
}
