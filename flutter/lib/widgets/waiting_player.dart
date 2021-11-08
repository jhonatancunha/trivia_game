import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WaitMainPlayer extends StatelessWidget {
  const WaitMainPlayer({Key? key}) : super(key: key);

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
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Aguardando jogadores...",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      strokeWidth: 15,
                      color: HexColor('#6B5FCD'),
                      backgroundColor: HexColor('#2E303F'),
                      semanticsLabel: 'Aguardando mais jogadores...',
                    )),
              ],
            )));
  }
}
