import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class InformationOfRound extends StatefulWidget {
  final Function sendInformationsOfRound;

  const InformationOfRound({
    Key? key,
    required this.sendInformationsOfRound,
  }) : super(key: key);

  @override
  _InformationOfRoundState createState() => _InformationOfRoundState();
}

class _InformationOfRoundState extends State<InformationOfRound> {
  final _formKey2 = GlobalKey<FormState>();
  String theme = '';
  String hint = '';
  String answer = '';

  @override
  void dispose() {
    super.dispose();
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
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Form(
                    key: _formKey2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: TextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty) return 'Informe o tema';
                                  return null;
                                },
                                onSaved: (val) {
                                  theme =
                                      val!; // o ! checa para ser se nao e nulo
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: HexColor('#2E303F'),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: HexColor("#6B5FCD"),
                                          width: 2)),
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
                                  hint =
                                      val!; // o ! checa para ser se nao e nulo
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: HexColor('#2E303F'),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: HexColor("#6B5FCD"),
                                          width: 2)),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: HexColor("#6B5FCD"), width: 2)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor('#2E303F'), width: 1.0),
                            ),
                            labelText: 'Resposta',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 80,
                              width: 200,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey2.currentState!.validate()) {
                                      _formKey2.currentState!.save();

                                      widget.sendInformationsOfRound(
                                          hint, theme, answer);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: HexColor("#6B5FCD"),
                                  ),
                                  child: const Text('PRONTO'),
                                ),
                              ),
                            ))
                      ],
                    )))));
  }
}
