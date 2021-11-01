import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:trivia/widgets/widgets.dart';

// Models
import 'package:trivia/entities/player.dart';

// Screens
import 'package:trivia/screen/initialScreen.dart';

class Rank extends StatefulWidget {
  const Rank({Key? key}) : super(key: key);

  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  final List<Player> topPlayers = <Player>[];
  final List<Player> otherPlayers = <Player>[];

  @override
  void initState() {
    super.initState();
    Player p1 = Player("p1p1p1p1p1p1p1p1p1p1p1p1", "300");
    Player p2 = Player("p2p1p1p1p1p1p1p1p1p1p1p1p1p1", "200");
    Player p3 = Player("p3p1p1p1p1p1p1p1p1p1p1p1p1p1", "100");

    topPlayers.add(p1);
    topPlayers.add(p2);
    topPlayers.add(p3);

    Player p4 = Player("teste", "50");
    Player p5 = Player("ada", "40");
    Player p6 = Player("ola", "10");
    Player p7 = Player("hehe", "10");

    otherPlayers.add(p4);
    otherPlayers.add(p5);
    otherPlayers.add(p6);
    otherPlayers.add(p7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#1F1D2B"),
        body: Column(children: [
          Column(
            children: [
              const WindowTitleBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(children: [
                    CircleAvatar(
                      backgroundColor: HexColor("#6B5FCD"),
                      child: Text(topPlayers[1].nickname[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                        width: 80,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                            child: Column(children: [
                              Text(
                                topPlayers[1].nickname,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                topPlayers[1].score,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            ]))),
                    SizedBox(
                        width: 80,
                        height: 100,
                        child: Container(
                            decoration: BoxDecoration(
                              color: HexColor("#6B5FCD"),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#877CE8'),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: const Offset(
                                      0, -7), // changes position of shadow
                                )
                              ],
                            ),
                            child: const Center(
                                child: Text(
                              '#2',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                              textAlign: TextAlign.center,
                            ))))
                  ]),
                  Column(children: [
                    CircleAvatar(
                      backgroundColor: HexColor("#6B5FCD"),
                      child: Text(topPlayers[0].nickname[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                        width: 120,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                            child: Column(children: [
                              Text(
                                topPlayers[0].nickname,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                topPlayers[0].score,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            ]))),
                    SizedBox(
                        width: 120,
                        height: 140,
                        child: Container(
                            decoration: BoxDecoration(
                              color: HexColor("#6B5FCD"),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#877CE8'),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: const Offset(
                                      0, -6), // changes position of shadow
                                )
                              ],
                            ),
                            child: const Center(
                                child: Text(
                              '#1',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                              textAlign: TextAlign.center,
                            ))))
                  ]),
                  Column(children: [
                    CircleAvatar(
                      backgroundColor: HexColor("#6B5FCD"),
                      child: Text(topPlayers[2].nickname[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                        width: 70,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                            child: Column(children: [
                              Text(
                                topPlayers[2].nickname,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                topPlayers[2].score,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            ]))),
                    SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                            decoration: BoxDecoration(
                              color: HexColor("#6B5FCD"),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#877CE8'),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: const Offset(
                                      0, -8), // changes position of shadow
                                )
                              ],
                            ),
                            child: const Center(
                                child: Text(
                              '#3',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                              textAlign: TextAlign.center,
                            ))))
                  ]),
                ],
              )
            ],
          ),
          Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: otherPlayers.length,
                  itemBuilder: (BuildContext contex, int index) {
                    return Column(children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Row(children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  "#" + (index + 4).toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.center,
                                )),
                            CircleAvatar(
                              backgroundColor: HexColor("#6B5FCD"),
                              child: Text(
                                  otherPlayers[index].nickname[0].toUpperCase(),
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
                                          Text(otherPlayers[index].nickname,
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
                                            Text(otherPlayers[index].score,
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
                  })),
          SizedBox(
            height: 80,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // showDialogRoundInformations(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InitialScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: HexColor("#393B4B"),
                ),
                child: const Text('JOGAR NOVAMENTE'),
              ),
            ),
          )
        ]));
  }
}
