import 'package:flutter/material.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar ({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(
            child: MoveWindow()
          ),
          const WindowButtons(),
        ]
      )
    );
  }
}