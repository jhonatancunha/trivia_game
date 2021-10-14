import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:trivia/widgets/widgets.dart';

// Models
import 'dart:convert';
import 'package:trivia/entities/player.dart';

class GameScreen extends StatefulWidget {

  const GameScreen({ Key? key }) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Player> _players = <Player>[];
  late IO.Socket socket;
  
  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket(){
    socket = IO.io('http://127.0.0.1:5000',
      IO.OptionBuilder()
      .setTransports(['websocket'])// for Flutter or Dart VM
      .disableAutoConnect() 
      .build());
    
    socket.connect();

    socket.emit('sendChatMessage', 'olateste');
    socket.on('returnMessage', (data) => print(data));

  }

  List<Player> fetchNotes(){
    String arrayOfObjects = '{"players":[{"nickname": "Jhonatan", "score": 10},{"nickname": "Jhonatan", "score": 10},{"nickname": "Jhonatan2 ", "score": 100}]}';
    var players = <Player>[];

    var arrayOfPlayers = json.decode(arrayOfObjects)['players'];

     for(var item in arrayOfPlayers){
       players.add(Player.fromJson(item));
     }

    return players;
  }

    void _getNewPlayer(teste){
      print("Mensagem $teste");
      List<Player> data = fetchNotes();
      setState((){
        _players.addAll(data);
      });
    } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: SizedBox(
        child: Column(
        children: [
          // LEFT SIDE
          Expanded(child: Row(
            children:  [
              SideBar(players: _players),
              const Middle(),
            ],
          )),
          // BOTTOM SIDE
          BottomBart(getNewPlayer: _getNewPlayer)
        ]
        ),
        width: double.infinity,
        
    )
    );
  }
}