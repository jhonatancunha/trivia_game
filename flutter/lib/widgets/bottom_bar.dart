import 'package:flutter/material.dart';
import 'package:trivia/service/web_socket.dart';

import 'package:hexcolor/hexcolor.dart';

class BottomBart extends StatefulWidget {
  final Function sendMessage;
  final WebSocket websocket;
  const BottomBart(
      {Key? key, required this.sendMessage, required this.websocket})
      : super(key: key);

  @override
  _BottomBartState createState() => _BottomBartState();
}

class _BottomBartState extends State<BottomBart> {
  String stateMessage = '';
  final chatMessage = TextEditingController();
  bool enableInput = true;

  @override
  void initState() {
    super.initState();

    widget.websocket.socket.on('currentRoundPlayer', (_) {
      setState(() {
        enableInput = false;
      });
    });

    widget.websocket.socket.on('roundPlayer', (_) {
      setState(() {
        enableInput = true;
      });
    });

    widget.websocket.socket.on('stopCountDown', (_) {
      setState(() {
        enableInput = true;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    chatMessage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: HexColor("#1F1D2B"),
          border: Border(
            top: BorderSide(width: 2, color: HexColor('#393B4B')),
          ),
        ),
        child: Row(
          children: <Widget>[
            Flexible(
                child: TextField(
              enabled: enableInput,
              controller: chatMessage,
              onChanged: enableInput
                  ? (text) {
                      setState(() {
                        stateMessage = text;
                      });
                    }
                  : null,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: HexColor('#2E303F'),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide:
                        BorderSide(color: HexColor("#6B5FCD"), width: 2)),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: HexColor('#2E303F'), width: 1.0),
                ),
                labelText:
                    enableInput ? 'Digite aqui...' : 'Você é jogador da vez...',
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                ),
                border: const OutlineInputBorder(),
              ),
            )),
            Padding(
                padding:
                    const EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 0),
                child: SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        widget.sendMessage(stateMessage);
                        chatMessage.clear();
                        setState(() {
                          stateMessage = '';
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(HexColor("#6B5FCD")),
                      ),
                      child: const Text("ENVIAR",
                          style: TextStyle(color: Colors.white)),
                    ))),
          ],
        ));
  }
}
