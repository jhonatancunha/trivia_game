import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:trivia/entities/player.dart';

class WebSocket{
  static final WebSocket _singleton = WebSocket._internal();
  late final IO.Socket socket;

  void joinRoom(nickname){
    Player player = Player(nickname, "0");
    socket.emit('join', player.toJson());
  }


  void init(nickname){
    socket = IO.io('http://127.0.0.1:8000',
        IO.OptionBuilder()
        .setTransports(['websocket']) //for Flutter or Dart VM
        .disableAutoConnect() 
        .build()
      );
      

      socket.connect();
      socket.onConnect((_) {
        joinRoom(nickname);
      });
  }


  void sendMessage(message){
    socket.emit('sendChatMessage', message);
  }

  void disconnect(){
    socket.emit('left');
  }

  factory WebSocket() {
    return _singleton;
  }

  

  WebSocket._internal();
}