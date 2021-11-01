import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

//  teste.split('').map((element) => Text(element)).toList(),
class GameBoard extends StatelessWidget {
  GameBoard({Key? key}) : super(key: key);
  String teste = "O *essé é um *tario";

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
      color = HexColor('#393B4B');
    }

    // return HexColor('#877CE8');

    return BoxShadow(
      color: color,
      spreadRadius: 1,
      blurRadius: 0,
      offset: const Offset(1, 2), // changes position of shadow
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
            height: 300,
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                      message: 'TEMA DA RODADA',
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: HexColor('#393B4B'),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Row(children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.assistant_photo_rounded,
                                  color: HexColor('#6B5FCD'),
                                  size: 24.0,
                                  semanticLabel: 'Tema da Rodada',
                                )),
                            const Expanded(
                                child: Text("Tema aqui",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)))
                          ]))),
                  // Text("TEXTO DE ${teste.length} LETRAS"),
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
                  Tooltip(
                      message: 'DICA DA RODADA',
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: HexColor('#393B4B'),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Row(children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.album_sharp,
                                  color: HexColor('#6B5FCD'),
                                  size: 24.0,
                                  semanticLabel: 'Dica da Rodada',
                                )),
                            const Expanded(
                                child: Text("Dica aqui",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)))
                          ]))),
                ])));
  }
}
