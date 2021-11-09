import 'package:flutter/material.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:trivia/entities/message.dart';

import 'package:hexcolor/hexcolor.dart';

class Middle extends StatelessWidget {
  final List<Message> messages;
  final int totalTimer;
  final int timer;
  final int timerWaitWord;
  final int totalTimerWaitWord;
  final bool waitingPlayers;
  final bool isMainPlayer;
  final Function sendInformationsOfRound;
  final bool isWaitingMainPlayer;
  final String waitingMainPlayerMessage;

  const Middle({
    Key? key,
    required this.messages,
    required this.timer,
    required this.waitingPlayers,
    required this.isMainPlayer,
    required this.sendInformationsOfRound,
    required this.isWaitingMainPlayer,
    required this.waitingMainPlayerMessage,
    required this.timerWaitWord,
    required this.totalTimer,
    required this.totalTimerWaitWord,
  }) : super(key: key);

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
                // const WaitingMainPlayer(seconds: '60'),
                if (waitingPlayers)
                  const WaitingPlayers()
                else if (isMainPlayer)
                  InformationOfRound(
                      timerWaitWord: timerWaitWord,
                      totalTimerWaitWord: totalTimerWaitWord,
                      sendInformationsOfRound: sendInformationsOfRound)
                else if (isWaitingMainPlayer)
                  WaitingMainPlayer(
                      timerWaitWord: timerWaitWord,
                      totalTimerWaitWord: totalTimerWaitWord,
                      waitingMainPlayerMessage: waitingMainPlayerMessage)
                else
                  TimerToStart(
                      seconds: timer.toString(), totalTimer: totalTimer),
                // const TimerToStart(),
                // GameBoard(),
                Chat(messages: messages),
              ],
            )));
  }
}
