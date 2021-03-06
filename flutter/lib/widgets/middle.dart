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
  final int roundTimer;
  final int totalRoundTimer;

  final bool waitingPlayers;
  final bool isMainPlayer;
  final Function sendInformationsOfRound;
  final bool isWaitingMainPlayer;
  final String waitingMainPlayerMessage;

  //Round
  final String theme;
  final String answer;
  final String hint;
  final int currentRound;
  final int nAmount;
  final bool isGameStarted;

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
    required this.roundTimer,
    required this.totalRoundTimer,
    required this.theme,
    required this.answer,
    required this.hint,
    required this.currentRound,
    required this.nAmount,
    required this.isGameStarted,
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
                else if (isGameStarted)
                  GameBoard(
                      theme: theme,
                      answer: answer,
                      hint: hint,
                      currentRound: currentRound,
                      nAmount: nAmount,
                      roundTimer: roundTimer,
                      totalRoundTimer: totalRoundTimer)
                else
                  TimerToStart(
                      seconds: timer.toString(), totalTimer: totalTimer),
                Chat(messages: messages),
              ],
            )));
  }
}
