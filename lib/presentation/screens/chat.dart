import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/blocs/chat/chat_bloc.dart';
import 'package:nexaera_chat/data/models/chat_model.dart';
import 'package:nexaera_chat/data/repositories/server_repository.dart';
import 'package:nexaera_chat/presentation/components/chat_box.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/constants/chat_roles.dart';
import 'package:unicons/unicons.dart';

import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final chatController = TextEditingController();
  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    var domain = 'http://www.test.com/';
    _theme = Theme.of(context);
    return Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Headline(title: 'Chat'),
                          BlocProvider(
                              create: (context) =>
                                  ChatBloc(context.read<ServerRepository>()),
                              child: BlocBuilder<ChatBloc, ChatState>(
                                  builder: (context, state) {
                                if (state is ChatInitial) {
                                  context
                                      .read<ChatBloc>()
                                      .add(CreateChatSession(domain));
                                }
                                return Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ChatBox(messages: state.chatMessages),
                                      const SizedBox(height: 32),
                                      CustomTextField(
                                        readOnly: state is! ChatIdle,
                                        hint: '',
                                        suffixIcon: UniconsLine.message,
                                        controller: chatController,
                                        onSubmitted: (message) {
                                          if (message.isNotEmpty) {
                                            context
                                                .read<ChatBloc>()
                                                .add(SendChatMessage(message));
                                          }
                                          chatController.clear();
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }))
                        ])))));
  }
}
