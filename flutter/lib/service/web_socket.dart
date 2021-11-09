import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:trivia/entities/player.dart';
import 'package:trivia/entities/round_info.dart';

class WebSocket {
  static final WebSocket _singleton = WebSocket._internal();
  late final IO.Socket socket;
  bool isSocketOn = false;

  void joinRoom(nickname) {
    Player player = Player(nickname, "0");
    socket.emit('join', player.toJson());
  }

  void init(nickname) {
    socket = IO.io(
        'http://127.0.0.1:8000',
        IO.OptionBuilder()
            .setTransports(['websocket']) //for Flutter or Dart VM
            .disableAutoConnect()
            .build());

    socket.connect();
    socket.onConnect((_) {
      isSocketOn = true;
      joinRoom(nickname);
    });
  }

  void sendMessage(message) {
    if (message.length > 0) {
      socket.emit('sendChatMessage', message);
    }
  }

  void sendInformationsOfRound(hint, theme, answer) {
    RoundInfo info = RoundInfo(theme, hint, answer);
    socket.emit('getWord', info.toJson());
  }

  IO.Socket getSocket() {
    return socket;
  }

  void disconnect() {
    if (isSocketOn) {
      socket.emit('left');
    }
  }

  factory WebSocket() {
    return _singleton;
  }

  WebSocket._internal();
}
