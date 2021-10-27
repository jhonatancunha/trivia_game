import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';


class GameBoard extends StatelessWidget {
  const GameBoard ({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return SizedBox(
      child: Container(
         decoration:  BoxDecoration(
           border: Border(
            bottom: BorderSide(width: 2, color: HexColor('#393B4B')),
        ),
        ),
        height: 250,
        width: double.infinity,
        child: const Text("game board")
      )
    );
  }
}