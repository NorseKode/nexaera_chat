import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexaera_chat/app/auth.dart';

import '../../data/models/chat_model.dart';
import '../constants/chat_roles.dart';
import 'page_header.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({super.key, required this.messages});

  final List<ChatModel> messages;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Expanded(
      child: Stack(fit: StackFit.expand, children: [
        ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 24),
            scrollDirection: Axis.vertical,
            // reverse: true,
            itemBuilder: (context, index) =>
                _ChatMessageBox(message: messages[index]),
            separatorBuilder: (context, index) => Divider(
                  indent: 60,
                  height: 40,
                  color: theme.colorScheme.surface,
                ),
            itemCount: messages.length),
        // SingleChildScrollView(
        //   reverse: true,
        //   child: Wrap(
        //       runSpacing: 24,
        //       children: messages
        //           .map((message) => _ChatMessageBox(message: message))
        //           .toList()),
        // ),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 50,
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
            )),
      ]),
    );
  }
}

class _ChatMessageBox extends StatelessWidget {
  const _ChatMessageBox({super.key, required this.message});

  final ChatModel message;

  Widget _logo() {
    String assetName = 'assets/chatbot_logo_dark.svg';
    return SvgPicture.asset(
      assetName,
    );
  }

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
              child: FittedBox(
                  child: message.role == ChatRole.chatbot
                      ? Headline(title: "NÆ", color: theme.colorScheme.surface)
                      : Headline(title: "ML")),
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
