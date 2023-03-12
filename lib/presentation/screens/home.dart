import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/blocs/upload_domain/upload_domain_bloc.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/components/paragraph_text.dart';
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
                              BlocBuilder<UploadDomainBloc, UploadDomainState>(
                                  builder: (context, state) {
                                if (state is UploadDone) {
                                  return const Text("Upload completed");
                                }
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text('Choose your domain',
                                        style: theme.textTheme.headlineSmall),
                                    const SizedBox(height: 16),
                                    const Paragraph(
                                        "In order to get started, please input a domain that you own"),
                                    const SizedBox(height: 8),
                                    const Paragraph(
                                      "Nexæra scans this domain for all information available and you will be able to interact with it through our chat or edit it in the workshop",
                                    ),
                                    const SizedBox(height: 24),
                                    CustomTextField(
                                      readOnly: state is ScrapeInProgress,
                                      hint: 'yourdomain.com',
                                      onSubmitted: (value) => context
                                          .read<UploadDomainBloc>()
                                          .add(UploadDomain(value)),
                                      prefixIcon: UniconsLine.at,
                                      suffixIcon: UniconsLine.arrow_right,
                                    ),
                                    state is! ScrapeInProgress
                                        ? Container()
                                        : Column(
                                            children: [
                                              const SizedBox(
                                                  height: 4,
                                                  child:
                                                      LinearProgressIndicator()),
                                              const SizedBox(height: 12),
                                              Text(
                                                  'Status: ${state.status}, ${state.message}')
                                            ],
                                          ),
                                    state is! UploadError
                                        ? Container()
                                        : Column(
                                            children: [
                                              const SizedBox(height: 16),
                                              Text(state.e.toString()),
                                            ],
                                          )
                                  ],
                                );
                              }),
                            ]))))));
  }
}
