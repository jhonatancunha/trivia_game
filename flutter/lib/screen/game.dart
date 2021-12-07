import 'package:flutter/material.dart';
import 'package:trivia/service/web_socket.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:trivia/service/controller_chat.dart';

// Models
import 'dart:convert';
import 'package:trivia/entities/player.dart';
import 'package:trivia/entities/message.dart';

// Screens
import 'package:trivia/screen/rank.dart';

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

  //Controllers
  bool _waitingPlayers = true;
  bool _isMainPlayer = false;
  bool _isWaitingMainPlayer = false;
  bool _isGameStarted = false;

  late String _waitingMainPlayerMessage;

  //ROUND
  int _roundTimer = 0;
  int _totalRoundTimer = 0;
  String _theme = '';
  String _answer = '';
  String _hint = '';
  int _currentRound = 0;
  int _nAmount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    if (mounted) {
      setState(() {
        _waitingMainPlayerMessage = '';
      });
    }

    initSocket();
  }

  void initSocket() {
    websocket.init(widget.nickname);

    websocket.socket.on('messageJoin', (msg) {
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      if (mounted) {
        setState(() {
          _messages.add(objMessage);
        });
      }
      ChatController.scrollDown();
    });

    websocket.socket.on('timer', (data) {
      var totalTimeAux = json.decode(data.toString())['total_time'];
      var timerAux = json.decode(data.toString())['time'];
      if (mounted) {
        setState(() {
          timer = timerAux;
          totalTimer = totalTimeAux;
          _waitingPlayers = false;
          _isGameStarted = false;
          _isWaitingMainPlayer = false;
          _isMainPlayer = false;
        });
      }
    });

    websocket.socket.on('waitWord', (data) {
      var totalTimeAux = json.decode(data.toString())['total_time'];
      var timerAux = json.decode(data.toString())['time'];
      if (mounted) {
        setState(() {
          _timerWaitWord = timerAux;
          _totalTimerWaitWord = totalTimeAux;
        });
      }
    });

    websocket.socket.on('stopCountDown', (_) {
      if (mounted) {
        setState(() {
          _isGameStarted = false;
          _isWaitingMainPlayer = false;
          _isMainPlayer = false;
          _waitingPlayers = true;
        });
      }
    });

    websocket.socket.on('listOfPlayers', (players) {
      Map<String, dynamic> playersList =
          Map<String, dynamic>.from(json.decode(players)['players']);

      _players.clear();
      for (var player in playersList.values) {
        var nickname = player['nickname'];
        var score = player['score'];
        var correctAsnwer = player['correct_asnwer'];

        Player newPlayer = Player(nickname, score, correctAsnwer);

        if (mounted) {
          setState(() {
            _players.add(newPlayer);
          });
        }
      }

      ChatController.scrollDown();
    });

    websocket.socket.on('playerLeaveTheGame', (msg) {
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      if (mounted) {
        setState(() {
          _messages.add(objMessage);
        });
      }
      ChatController.scrollDown();
    });

    websocket.socket.on('messageChat', (msg) {
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      if (mounted) {
        setState(() {
          _messages.add(objMessage);
        });
      }
      ChatController.scrollDown();
    });

    websocket.socket.on('almostCorrect', (msg) {
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      if (mounted) {
        setState(() {
          _messages.add(objMessage);
        });
      }
      ChatController.scrollDown();
    });

    websocket.socket.on('youAreRight', (msg) {
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      if (mounted) {
        setState(() {
          _messages.add(objMessage);
        });
      }
      ChatController.scrollDown();
    });

    websocket.socket.on('someoneIsRight', (msg) {
      var message = json.decode(msg.toString())['message'];
      var nickname = json.decode(msg.toString())['nickname'];
      var type = json.decode(msg.toString())['type'];
      Message objMessage = Message(nickname, message, type);

      if (mounted) {
        setState(() {
          _messages.add(objMessage);
        });
      }
      ChatController.scrollDown();
    });

    websocket.socket.on('currentRoundPlayer', (_) {
      if (mounted) {
        setState(() {
          _waitingPlayers = false;
          _isGameStarted = false;
          _isMainPlayer = true;
          _isWaitingMainPlayer = false;
        });
      }
    });

    websocket.socket.on('roundPlayer', (msg) {
      var message = json.decode(msg.toString())['message'];
      if (mounted) {
        setState(() {
          _waitingPlayers = false;
          _isGameStarted = false;
          _isMainPlayer = false;
          _isWaitingMainPlayer = true;
          _waitingMainPlayerMessage = message;
        });
      }
    });

    websocket.socket.on('startRound', (data) {
      var theme = json.decode(data.toString())['theme'];
      var answer = json.decode(data.toString())['answer'];
      var hint = json.decode(data.toString())['hint'];
      var currentRound = json.decode(data.toString())['current_round'];
      var nAmount = json.decode(data.toString())['n_amount'];

      if (mounted) {
        setState(() {
          _isGameStarted = true;
          _isMainPlayer = false;
          _waitingPlayers = false;
          _isWaitingMainPlayer = false;
          _theme = theme;
          _answer = answer;
          _hint = hint;
          _currentRound = currentRound;
          _nAmount = nAmount;
        });
      }
    });

    websocket.socket.on('roundTimer', (data) {
      var totalTimeAux = json.decode(data.toString())['total_time'];
      var timerAux = json.decode(data.toString())['time'];

      if (mounted) {
        setState(() {
          _roundTimer = timerAux;
          _totalRoundTimer = totalTimeAux;
        });
      }
    });

    websocket.socket.on('revealLetter', (data) {
      var answerMask = json.decode(data.toString())['answer_mask'];

      if (mounted) {
        setState(() => {_answer = answerMask});
      }
    });

    websocket.socket.on('finishGame', (players) {
      Map<String, dynamic> topPlayersList =
          Map<String, dynamic>.from(json.decode(players)['topPlayers']);

      Map<String, dynamic> otherPlayersList =
          Map<String, dynamic>.from(json.decode(players)['otherPlayers']);

      final List<Player> topPlayers = <Player>[];
      final List<Player> otherPlayers = <Player>[];

      for (var player in topPlayersList.values) {
        var nickname = player['nickname'];
        var score = player['score'];
        var correctAsnwer = player['correct_asnwer'];

        Player newPlayer = Player(nickname, score, correctAsnwer);
        topPlayers.add(newPlayer);
      }

      for (var player in otherPlayersList.values) {
        var nickname = player['nickname'];
        var score = player['score'];
        var correctAsnwer = player['correct_asnwer'];

        Player newPlayer = Player(nickname, score, correctAsnwer);
        otherPlayers.add(newPlayer);
      }

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Rank(topPlayers: topPlayers, otherPlayers: otherPlayers)),
        );
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

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
              theme: _theme,
              answer: _answer,
              hint: _hint,
              currentRound: _currentRound,
              nAmount: _nAmount,
              isGameStarted: _isGameStarted,
              roundTimer: _roundTimer,
              totalRoundTimer: _totalRoundTimer,
            ),
          ],
        )),
        // BOTTOM SIDE
        BottomBart(sendMessage: websocket.sendMessage, websocket: websocket)
      ]),
      width: double.infinity,
    ));
  }
}
