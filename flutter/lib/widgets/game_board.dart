import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  const GameBoard ({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return const Expanded(
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Text("game board")
      )
    );
  }
}