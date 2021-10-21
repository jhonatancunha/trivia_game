import 'package:flutter/material.dart';
import 'package:trivia/entities/player.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

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
        color: Colors.red,
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
                Text(players[index].nickname, style: TextStyle(color: Colors.black.withOpacity(0.6))),
                Text(players[index].score, style: TextStyle(color: Colors.black.withOpacity(0.6)))
              ],);
            }
          )
        ],)

      )
    );
  }
}