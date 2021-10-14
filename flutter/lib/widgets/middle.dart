import 'package:flutter/material.dart';
import 'package:trivia/widgets/widgets.dart';

class Middle extends StatelessWidget {
  const Middle ({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Expanded(
      child: Container(
        height: double.infinity,
        width: 280,
        child: Column(
          children:  const <Widget> [
            GameBoard(),
            Chat(),
          ],
        ),
        decoration:  const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, 
              end: Alignment.bottomCenter, 
              colors: [
                Colors.black,
                Colors.grey,
              ],
            )
          )
      )
    );
  }
}