import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WaitingMainPlayer extends StatelessWidget {
  final String seconds;
  final String waitingMainPlayerMessage;
  const WaitingMainPlayer(
      {Key? key, required this.seconds, required this.waitingMainPlayerMessage})
      : super(key: key);

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
                    child: Text(waitingMainPlayerMessage,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16))),
                SizedBox(
                    width: 200,
                    height: 200,
                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                          minimum: 0,
                          maximum: 60,
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
                                value: double.parse(seconds),
                                cornerStyle: CornerStyle.bothCurve,
                                width: 0.2,
                                sizeUnit: GaugeSizeUnit.factor,
                                color: HexColor("#6B5FCD"))
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                positionFactor: 0.1,
                                angle: 90,
                                widget: Text(seconds + ' / 60',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))
                          ])
                    ])),
              ],
            )));
  }
}
