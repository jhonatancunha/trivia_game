import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TimerToStart extends StatelessWidget {
  final String seconds;

  const TimerToStart({Key? key, required this.seconds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2, color: HexColor('#393B4B')),
              ),
            ),
            height: 300,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(seconds,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
              ],
            )));
  }
}
