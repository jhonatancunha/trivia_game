import 'package:flutter/material.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:trivia/entities/message.dart';

import 'package:hexcolor/hexcolor.dart';

class Middle extends StatelessWidget {
  final List<Message> messages;
  final int timer;
  final bool waitingPlayers;
  const Middle(
      {Key? key,
      required this.messages,
      required this.timer,
      required this.waitingPlayers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Expanded(
        child: Container(
            height: double.infinity,
            width: 280,
            color: HexColor('#1F1D2B'),
            child: Column(
              children: <Widget>[
                const WindowTitleBar(),
                if (waitingPlayers)
                  const WaitMainPlayer()
                else
                  TimerToStart(seconds: timer.toString()),
                // const TimerToStart(),
                // GameBoard(),
                Chat(messages: messages),
              ],
            )));
  }
}
