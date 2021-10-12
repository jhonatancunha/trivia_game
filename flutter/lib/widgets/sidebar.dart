import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final players;
  const SideBar ({ Key? key, this.players }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Container(
      height: double.infinity,
      width: 280,
      color: Colors.white,
      child: ListView.builder(
        itemCount: players.length,
        itemBuilder: (BuildContext contex, int index){
          return Text(players[index].nickname,style: TextStyle(color: Colors.black.withOpacity(0.6)));
        }
      )
    );
  }
}