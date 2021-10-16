import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat ({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Expanded(
      child: Container(
        height: 200,
        color: Colors.green,
        width: double.infinity,
        child: const Text("chat")
      )
    );
  }
}