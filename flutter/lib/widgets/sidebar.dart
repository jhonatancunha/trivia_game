import 'package:flutter/material.dart';
import 'package:trivia/entities/player.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:hexcolor/hexcolor.dart';

class SideBar extends StatelessWidget {
  final List<Player> players;
  const SideBar ({ Key? key, required this.players }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return SizedBox(
      // height: double.infinity,
      width: 280,
      child: Container(
        decoration: BoxDecoration(
          color: HexColor("#1F1D2B"),
          border: Border(
            right: BorderSide(width: 2, color: HexColor('#393B4B')),
          ),
        ),
        // color: HexColor("#1F1D2B"),
        child: Column(
          children: [
          WindowTitleBarBox(
            child: MoveWindow()
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: players.length,
            itemBuilder: (BuildContext contex, int index){
              return Column(children: [
                Text(players[index].nickname, style: const TextStyle(color: Colors.white)),
                Text(players[index].score, style: const TextStyle(color: Colors.white))
              ],);
            }
          )
        ],)

      )
    );
  }
}