import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

//  teste.split('').map((element) => Text(element)).toList(),
class GameBoard extends StatelessWidget {
  GameBoard({Key? key}) : super(key: key);
  String teste = "Sá*ado *e So*";

  renderLetter(letter) {
    var caracter = letter;

    if (letter == '*') {
      caracter = ' ';
    } else if (letter == ' ') {
      caracter = '';
    }

    return Text(
      caracter,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  decideLetterBackground(letter) {
    if (letter == '*') {
      return HexColor('#393B4B');
    } else if (letter == ' ') {
      return null;
    }

    return HexColor('#6B5FCD');
  }

  decideShadow(letter) {
    if (letter == ' ') {
      return const BoxShadow(color: Colors.transparent);
    }

    var color = HexColor('#877CE8');
    if (letter == '*') {
      color = HexColor('#4F5164');
    }

    // return HexColor('#877CE8');

    return BoxShadow(
      color: color,
      spreadRadius: 1,
      blurRadius: 0,
      offset: const Offset(1, 1.5), // changes position of shadow
    );
  }

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
                  Text("TEXTO DE ${teste.length} LETRAS"),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 0, // gap between adjacent chips
                          runSpacing: 4, // gap between lines
                          children: teste
                              .split('')
                              .map((element) => Container(
                                  margin: const EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: decideLetterBackground(element),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2)),
                                    boxShadow: [decideShadow(element)],
                                  ),
                                  child: renderLetter(element)))
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
