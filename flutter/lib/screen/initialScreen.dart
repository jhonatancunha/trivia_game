import 'package:flutter/material.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:trivia/screen/game.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _nickname = '';

  @override
  void initState() {
    super.initState();
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
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor('#2E303F'),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor('#2E303F'), width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: HexColor("#6B5FCD"), width: 2)),
                            labelText: 'Digite seu nickname',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                            border: const OutlineInputBorder(),
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
