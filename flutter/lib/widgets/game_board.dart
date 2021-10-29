import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

//  teste.split('').map((element) => Text(element)).toList(),
class GameBoard extends StatelessWidget {
  GameBoard({Key? key}) : super(key: key);
  String teste = "lalaladawdwadwdwawd";
  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return SizedBox(
        child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2, color: HexColor('#393B4B')),
              ),
            ),
            height: 250,
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TEXTO DE ${teste.length} LETRAS."),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8.0, // gap between adjacent chips
                          runSpacing: 4.0, // gap between lines
                          children: teste
                              .split('')
                              .map((element) => Container(
                                  margin: const EdgeInsets.all(10.0),
                                  color: Colors.amber[600],
                                  width: 20,
                                  height: 20,
                                  child: Text(
                                    element,
                                  )))
                              .toList(),
                        ))
                      ]),
                  Column(children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("TEMA: "),
                              Text("tema aqui")
                            ])),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("DICA: "),
                              Text("dica aqui")
                            ]))
                  ])
                ])));
  }
}
