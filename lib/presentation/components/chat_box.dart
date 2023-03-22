import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexaera_chat/app/auth.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../data/models/chat_model.dart';
import '../constants/chat_roles.dart';
import 'page_header.dart';

class ChatBox extends StatelessWidget {
  const ChatBox(
      {super.key,
      required this.messages,
      required this.userLogo,
      required this.controller});

  final List<ChatModel> messages;
  final Widget userLogo;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Expanded(
      child: Stack(fit: StackFit.expand, children: [
        BlocListener<ChatBloc, ChatState>(
            listener: (context, state) {
              if (true) {
                if (controller.position.pixels ==
                    controller.position.maxScrollExtent) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    controller.jumpTo(controller.position.maxScrollExtent);
                  });
                }
              }
            },
            child: Scrollbar(
              controller: controller,
              thumbVisibility: true,
              child: ListView.separated(
                  controller: controller,
                  padding: EdgeInsets.only(top: 40, bottom: 40, right: 16),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => _ChatMessageBox(
                        message: messages[index],
                        logo: messages[index].role == ChatRole.chatbot
                            ? Headline(
                                title: 'NÆ', color: theme.colorScheme.surface)
                            : userLogo,
                      ),
                  separatorBuilder: (context, index) => Divider(
                        indent: 60,
                        thickness: 2,
                        height: 40,
                        color: theme.colorScheme.surface,
                      ),
                  itemCount: messages.length),
            )),
        Positioned(
          bottom: -1,
          right: 0,
          left: 0,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [
                  theme.colorScheme.background.withOpacity(1.0),
                  theme.colorScheme.background.withOpacity(0.5),
                  theme.colorScheme.background.withOpacity(0.0),
                ])),
          ),
        ),
      ]),
    );
  }
}

class _ChatMessageBox extends StatelessWidget {
  const _ChatMessageBox({super.key, required this.message, required this.logo});

  final ChatModel message;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: message.role == ChatRole.chatbot
                    ? Colors.white
                    : theme.colorScheme.surface),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: FittedBox(child: logo),
            )),
        SizedBox(width: 24),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message.message),
        )),
      ],
    );
  }
}
