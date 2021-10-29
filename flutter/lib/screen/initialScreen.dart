import 'package:flutter/material.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:trivia/screen/game.dart';
import 'package:hexcolor/hexcolor.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _nickname = '';
  final _formKey2 = GlobalKey<FormState>();
  String theme = '';
  String hint = '';
  String answer = '';

  @override
  void initState() {
    super.initState();
  }

  void showDialogRoundInformations(BuildContext ctx) {
    var alert = AlertDialog(
        backgroundColor: HexColor("#1F1D2B"),
        title: const Text("PALAVRA DA RODADA", textAlign: TextAlign.center),
        content: Form(
            key: _formKey2,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Informe o tema';
                        return null;
                      },
                      onSaved: (val) {
                        theme = val!; // o ! checa para ser se nao e nulo
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: HexColor('#2E303F'),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: HexColor("#6B5FCD"), width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#2E303F'), width: 1.0),
                        ),
                        labelText: 'Tema',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                        border: const OutlineInputBorder(),
                      ))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Informe a dica';
                        return null;
                      },
                      onSaved: (val) {
                        hint = val!; // o ! checa para ser se nao e nulo
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: HexColor('#2E303F'),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: HexColor("#6B5FCD"), width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#2E303F'), width: 1.0),
                        ),
                        labelText: 'Dica',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                        border: const OutlineInputBorder(),
                      ))),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) return 'Informe a resposta';
                  return null;
                },
                onSaved: (val) {
                  answer = val!; // o ! checa para ser se nao e nulo
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: HexColor('#2E303F'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(color: HexColor("#6B5FCD"), width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor('#2E303F'), width: 1.0),
                  ),
                  labelText: 'Resposta',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
            ])),
        actions: [
          Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 80,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey2.currentState!.validate()) {
                        _formKey2.currentState!.save();
                        print("Hint $hint");
                        print("Theme $theme");
                        print("Answer $answer");
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#6B5FCD"),
                    ),
                    child: const Text('PRONTO'),
                  ),
                ),
              ))
        ]);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#1F1D2B"),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                const WindowTitleBar(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(40),
                              child: Image(
                                image: AssetImage('assets/logo.png'),
                              ))),
                      SizedBox(
                        height: 50,
                        width: 500,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Digite seu nickname',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor, digite alguma coisa";
                            }
                            _nickname = value;
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // showDialogRoundInformations(context);
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GameScreen(nickname: _nickname)),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: HexColor("#6B5FCD"),
                            ),
                            child: const Text('Entrar'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
