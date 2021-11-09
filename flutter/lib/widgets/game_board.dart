import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:hexcolor/hexcolor.dart';

//  teste.split('').map((element) => Text(element)).toList(),
class GameBoard extends StatelessWidget {
  final String theme;
  final String answer;
  final String hint;

  final int currentRound;
  final int nAmount;
  final int roundTimer;
  final int totalRoundTimer;

  const GameBoard({
    Key? key,
    required this.theme,
    required this.answer,
    required this.hint,
    required this.currentRound,
    required this.nAmount,
    required this.roundTimer,
    required this.totalRoundTimer,
  }) : super(key: key);

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

    return BoxShadow(
      color: color,
      spreadRadius: 1,
      blurRadius: 0,
      offset: const Offset(1, 2), // changes position of shadow
    );
  }

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                      message: 'TEMA DA RODADA',
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: HexColor('#393B4B'),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Row(children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text('TEMA',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: HexColor("#6B5FCD"),
                                        fontSize: 16))),
                            Expanded(
                                child: Text(theme,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)))
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
                          children: answer
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Tooltip(
                            message: 'DICA DA RODADA',
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  color: HexColor('#393B4B'),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                                child: Row(children: [
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: Text('DICA',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: HexColor("#6B5FCD"),
                                              fontSize: 16))),
                                  Expanded(
                                      child: Text(hint,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)))
                                ]))),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: SfRadialGauge(axes: <RadialAxis>[
                                  RadialAxis(
                                      minimum: 0,
                                      maximum: totalRoundTimer.toDouble(),
                                      showLabels: false,
                                      showTicks: false,
                                      axisLineStyle: AxisLineStyle(
                                        thickness: 0.2,
                                        cornerStyle: CornerStyle.bothCurve,
                                        color: HexColor('#2E303F'),
                                        thicknessUnit: GaugeSizeUnit.factor,
                                      ),
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                            value: roundTimer.toDouble(),
                                            cornerStyle: CornerStyle.bothCurve,
                                            width: 0.2,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            color: HexColor("#6B5FCD"))
                                      ],
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                            positionFactor: 0.1,
                                            angle: 90,
                                            widget: Text(
                                                roundTimer.toString() +
                                                    ' / $totalRoundTimer',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10)))
                                      ])
                                ]))),
                      ])
                ])));
  }
}
