import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../data/models/chat_model.dart';
import '../constants/chat_roles.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({super.key, required this.messages});

  final List<ChatModel> messages;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Expanded(
      child: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          reverse: true,
          child: Wrap(
              runSpacing: 24,
              children: messages
                  .map((message) => _ChatMessageBox(message: message))
                  .toList()),
        ),
        Positioned(
            top: 0,
            right: 0,
            left: 0,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            alignment: message.role == ChatRole.user
                ? Alignment.topRight
                : Alignment.topLeft,
            padding: message.role == ChatRole.user
                ? const EdgeInsets.only(left: 64)
                : const EdgeInsets.only(right: 64),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: message.role == ChatRole.user
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                //Name need to change to be dynamic?
                Text(message.role.name),
                Text(
                  message.message,
                  textAlign: message.role == ChatRole.user
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    ;
  }
}
