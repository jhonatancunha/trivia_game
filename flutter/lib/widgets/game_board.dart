import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  const GameBoard ({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Expanded(
      child: Container(
        height: 300,
        width: double.infinity,
        color: Colors.orange,
        child: const Text("game board")
      )
    );
  }
}