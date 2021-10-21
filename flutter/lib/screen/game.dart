import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
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

class _GameScreenState extends State<GameScreen> {
  final List<Player> _players = <Player>[];
  final List<Message> _messages = <Message>[];
  late final IO.Socket socket;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  void initSocket(){
    print("iniciando socket");
    socket = IO.io('http://127.0.0.1:8000',
      IO.OptionBuilder()
      .setTransports(['websocket']) //for Flutter or Dart VM
      .disableAutoConnect() 
      .build()
    );
    

    socket.connect();
    socket.onConnect((_) {
      joinRoom(widget.nickname);
    });


    socket.onError((_) {
      print("erro");
    });

    socket.on('messageJoin', (msg) {
      print(msg);
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      setState((){
        _messages.add(objMessage);
      });
    });

    socket.on('newPlayer', (player){
      print(player);
      var score = json.decode(player.toString())['score'];
      var nickname = json.decode(player.toString())['nickname'];
      Player newPlayer = Player(nickname, score);

      setState((){
        _players.add(newPlayer);
      });
    });


    socket.on('messageChat', (msg) {
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

    
  void joinRoom(nickname){
    Player player = Player(nickname, "0");
    socket.emit('join', player.toJson());
  }

  void sendMessage(message){
    socket.emit('sendChatMessage', message);
  }


  @override
  @protected
  @mustCallSuper
  void dispose(){
    print("fechando");
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
            BottomBart(sendMessage: sendMessage)
          ]
          ),
          width: double.infinity,
      )
    );
  }
}