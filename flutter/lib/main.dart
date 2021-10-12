// Flutter
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:trivia/screen/game.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Models
import 'dart:convert';
import 'package:trivia/entities/player.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
    await DesktopWindow.setMinWindowSize(const Size(1200, 800));
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.black,


      ),
      home:  const LeftMenu()
    );
  }
}

class LeftMenu extends StatefulWidget {
  const LeftMenu({ Key? key }) : super(key: key);


  @override
  _LeftMenuState createState() => _LeftMenuState();
}


class _LeftMenuState extends State<LeftMenu> {
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
    String arrayOfObjects = '{"players":[{"nickname": "Jhonatan", "score": 10},{"nickname": "Jhonatan2 ", "score": 100}]}';
    var players = <Player>[];

    var arrayOfPlayers = json.decode(arrayOfObjects)['players'];

     for(var item in arrayOfPlayers){
       players.add(Player.fromJson(item));
     }

    return players;
  }

  @override
  Widget build(BuildContext context) {

    List<Player> data = fetchNotes();
    setState((){
      _players.addAll(data);
    });
    

    return Scaffold(
      body: Column(
        children: [
          // LEFT SIDE
          Expanded(child: Row(
            children:  [
              SideBar(players: _players),
              const Expanded(
                child: GameScreen()
              )
            ],
          )),
          // BOTTOM SIDE
          const BottomBart()
        ]
      )
    );
  }
}
