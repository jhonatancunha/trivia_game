import 'package:flutter/material.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:trivia/entities/message.dart';

class Middle extends StatelessWidget {

  final List<Message> messages;
  const Middle ({ Key? key, required this.messages }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Expanded(
      child: Container(
        height: double.infinity,
        width: 280,
        color: Colors.orange,
        child: Column(
          children:   <Widget> [
            const WindowTitleBar(),
            const GameBoard(),
            Chat(messages: messages),
          ],
        )
      )
    );
  }
}