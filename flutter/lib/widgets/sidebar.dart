import 'package:flutter/material.dart';
import 'package:trivia/entities/player.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:hexcolor/hexcolor.dart';

class SideBar extends StatelessWidget {
  final List<Player> players;
  const SideBar({Key? key, required this.players}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return SizedBox(
        // height: double.infinity,
        width: 280,
        child: Container(
            decoration: BoxDecoration(
              color: HexColor("#1F1D2B"),
              border: Border(
                right: BorderSide(width: 2, color: HexColor('#393B4B')),
              ),
            ),
            // color: HexColor("#1F1D2B"),
            child: Column(children: [
              WindowTitleBarBox(
                  child: MoveWindow(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Text('JOGADORES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor("#6B5FCD")))),
              )),
              Divider(
                color: HexColor('#393B4B'),
                height: 30,
                thickness: 2,
                indent: 0,
                endIndent: 0,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: players.length,
                  itemBuilder: (BuildContext contex, int index) {
                    return Column(children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Row(children: [
                            CircleAvatar(
                              backgroundColor: HexColor("#6B5FCD"),
                              child: Text(
                                  players[index].nickname[0].toUpperCase(),
                                  style: const TextStyle(color: Colors.white)),
                            ),
                            Expanded(
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(players[index].nickname,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          Row(children: [
                                            const Text("Pontos: ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(players[index].score,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white))
                                          ])
                                        ])))
                          ])),
                      Divider(
                        color: HexColor('#393B4B'),
                        height: 30,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ]);
                  })
            ])));
  }
}
