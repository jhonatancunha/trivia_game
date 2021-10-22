import 'package:flutter/material.dart';
import 'package:trivia/service/web_socket.dart';
import 'package:trivia/widgets/widgets.dart';

// Models
import 'dart:convert';
import 'package:trivia/entities/player.dart';
import 'package:trivia/entities/message.dart';


class GameScreen extends StatefulWidget {
  final String nickname;
  const GameScreen( { Key? key, required this.nickname}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>  with WidgetsBindingObserver{
  final List<Player> _players = <Player>[];
  final List<Message> _messages = <Message>[];
  final WebSocket websocket = WebSocket();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    initSocket();
  }

  void initSocket(){
    websocket.init(widget.nickname);

    websocket.socket.on('messageJoin', (msg) {
      print("entro $msg");
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);


      setState((){
        _messages.add(objMessage);
      });
    });

    websocket.socket.on('newPlayer', (player){
      print(player);
      var score = json.decode(player.toString())['score'];
      var nickname = json.decode(player.toString())['nickname'];
      Player newPlayer = Player(nickname, score);

      setState((){
        _players.add(newPlayer);
      });
    });


    websocket.socket.on('messageChat', (msg) {
      print(msg);
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      setState((){
        _messages.add(objMessage);
      });
    });
  }

    
  


  @override
  void dispose(){
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
          child: Column(
          children: [
            // LEFT SIDE
            Expanded(child: Row(
              children:  [
                SideBar(players: _players),
                Middle(messages: _messages),
              ],
            )),
            // BOTTOM SIDE
            BottomBart(sendMessage: websocket.sendMessage)
          ]
          ),
          width: double.infinity,
      )
    );
  }
}