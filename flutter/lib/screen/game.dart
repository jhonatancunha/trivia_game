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
  bool _waitingPlayers = true;

  int timer = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    initSocket();
  }

  void initSocket() {
    websocket.init(widget.nickname);

    websocket.socket.on('messageJoin', (msg) {
      print("entro $msg");
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
      print("recebeu timer $data");
      setState(() {
        timer = data;
        _waitingPlayers = false;
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
      print("saiu $msg");
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
      print(msg);
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      setState(() {
        _messages.add(objMessage);
      });
      ChatController.scrollDown();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
    print("fechando");
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
                waitingPlayers: _waitingPlayers),
          ],
        )),
        // BOTTOM SIDE
        BottomBart(sendMessage: websocket.sendMessage)
      ]),
      width: double.infinity,
    ));
  }
}
