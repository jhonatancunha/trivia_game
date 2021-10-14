import 'package:flutter/material.dart';
import 'package:trivia/entities/player.dart';

class SideBar extends StatelessWidget {
  final List<Player> players;
  const SideBar ({ Key? key, required this.players }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Container(
      height: double.infinity,
      width: 280,
      color: Colors.red,
      child: ListView.builder(
        itemCount: players.length,
        itemBuilder: (BuildContext contex, int index){
          return Text(players[index].nickname,style: TextStyle(color: Colors.black.withOpacity(0.6)));
        }
      )
    );
  }
}