import 'package:flutter/material.dart';
import 'package:trivia/service/web_socket.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:trivia/service/controller_chat.dart';

// Models
import 'dart:convert';
import 'package:trivia/entities/player.dart';
import 'package:trivia/entities/message.dart';

class GameScreen extends StatefulWidget {
  final String nickname;
  const GameScreen({Key? key, required this.nickname}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with WidgetsBindingObserver {
  final List<Player> _players = <Player>[];
  final List<Message> _messages = <Message>[];
  final WebSocket websocket = WebSocket();

  int totalTimer = 0;
  int timer = 0;
  int _totalTimerWaitWord = 0;
  int _timerWaitWord = 0;

  bool _waitingPlayers = true;
  bool _isMainPlayer = false;
  bool _isWaitingMainPlayer = false;
  late String _waitingMainPlayerMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setState(() {
      _waitingMainPlayerMessage = '';
    });
    initSocket();
  }

  void initSocket() {
    websocket.init(widget.nickname);

    websocket.socket.on('messageJoin', (msg) {
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      setState(() {
        _messages.add(objMessage);
      });
      ChatController.scrollDown();
    });

    websocket.socket.on('timer', (data) {
      var totalTimeAux = json.decode(data.toString())['total_time'];
      var timerAux = json.decode(data.toString())['time'];

      setState(() {
        timer = timerAux;
        totalTimer = totalTimeAux;
        _waitingPlayers = false;
      });
    });

    websocket.socket.on('waitWord', (data) {
      var totalTimeAux = json.decode(data.toString())['total_time'];
      var timerAux = json.decode(data.toString())['time'];

      setState(() {
        _timerWaitWord = timerAux;
        _totalTimerWaitWord = totalTimeAux;
      });
    });

    websocket.socket.on('stopCountDown', (_) {
      setState(() {
        _waitingPlayers = true;
      });
    });

    websocket.socket.on('listOfPlayers', (players) {
      Map<String, dynamic> playersList =
          Map<String, dynamic>.from(json.decode(players)['players']);

      _players.clear();
      for (var player in playersList.values) {
        var nickname = player['nickname'];
        var score = player['score'];
        Player newPlayer = Player(nickname, score);
        setState(() {
          _players.add(newPlayer);
        });
      }

      ChatController.scrollDown();
    });

    websocket.socket.on('playerLeaveTheGame', (msg) {
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      setState(() {
        _messages.add(objMessage);
      });
      ChatController.scrollDown();
    });

    websocket.socket.on('messageChat', (msg) {
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      setState(() {
        _messages.add(objMessage);
      });
      ChatController.scrollDown();
    });

    websocket.socket.on('currentRoundPlayer', (_) {
      setState(() {
        _isMainPlayer = true;
        _isWaitingMainPlayer = false;
      });
    });

    websocket.socket.on('roundPlayer', (msg) {
      var message = json.decode(msg.toString())['message'];

      setState(() {
        _isMainPlayer = false;
        _isWaitingMainPlayer = true;
        _waitingMainPlayerMessage = message;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: Column(children: [
        // LEFT SIDE
        Expanded(
            child: Row(
          children: [
            SideBar(players: _players),
            Middle(
              messages: _messages,
              timer: timer,
              totalTimer: totalTimer,
              waitingPlayers: _waitingPlayers,
              isMainPlayer: _isMainPlayer,
              sendInformationsOfRound: websocket.sendInformationsOfRound,
              isWaitingMainPlayer: _isWaitingMainPlayer,
              waitingMainPlayerMessage: _waitingMainPlayerMessage,
              timerWaitWord: _timerWaitWord,
              totalTimerWaitWord: _totalTimerWaitWord,
            ),
          ],
        )),
        // BOTTOM SIDE
        BottomBart(sendMessage: websocket.sendMessage)
      ]),
      width: double.infinity,
    ));
  }
}
