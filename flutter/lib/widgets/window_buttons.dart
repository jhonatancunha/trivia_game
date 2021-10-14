import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

var buttonColors = WindowButtonColors(
  iconNormal: const Color(0xFF805306),
  mouseOver: const Color(0XFFF6A00C),
  mouseDown: const Color(0XFF805306),
  iconMouseDown: const Color(0XFF805306),
  iconMouseOver: const Color(0XFFFFD500),
);

class WindowButtons extends StatelessWidget {
  const WindowButtons ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton()
      ],
    );
  }
}