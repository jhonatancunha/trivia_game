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
        color: Colors.orange,
        child: Column(
          children:  const <Widget> [
            WindowTitleBar(),
            GameBoard(),
            Chat(),
          ],
        )
      )
    );
  }
}