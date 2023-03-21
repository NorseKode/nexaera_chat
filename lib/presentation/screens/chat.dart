import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexaera_chat/blocs/chat/chat_bloc.dart';
import 'package:nexaera_chat/data/models/chat_model.dart';
import 'package:nexaera_chat/data/repositories/server_repository.dart';
import 'package:nexaera_chat/presentation/components/chat_box.dart';
import 'package:nexaera_chat/presentation/components/page_header.dart';
import 'package:nexaera_chat/presentation/constants/chat_roles.dart';
import 'package:nexaera_chat/utils/get_initials.dart';
import 'package:unicons/unicons.dart';

import '../../blocs/user/user_bloc.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_text_field.dart';
import '../components/error_box.dart';
import 'package:http/http.dart' as http;

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
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
            child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Headline(title: 'Chat'),
                          const SizedBox(height: 32),
                          BlocBuilder<ChatBloc, ChatState>(
                              builder: (context, state) {
                            if (state is ChatInitial) {
                              context
                                  .read<ChatBloc>()
                                  .add(CreateChatSession(domain));
                            }
                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  BlocBuilder<UserBloc, UserState>(
                                    builder: (context, user) {
                                      if (user is UserLoaded) {
                                        return ChatBox(
                                            userLogo: Headline(
                                                title: getInitials(
                                                    user.firstName,
                                                    user.lastName)),
                                            messages: state is ChatWriting
                                                ? [
                                                    ChatModel(ChatRole.chatbot,
                                                        state.message)
                                                  ]
                                                : []);
                                      }
                                      return Container();
                                    },
                                  ),
                                  state is ChatLoading
                                      ? const LinearProgressIndicator()
                                      : Container(),
                                  CustomTextField(
                                    readOnly: state is! ChatIdle,
                                    hint: state is ChatError
                                        ? state.errorMessage
                                        : 'Ask me anything...',
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
                          })
                        ])))));
  }
}
