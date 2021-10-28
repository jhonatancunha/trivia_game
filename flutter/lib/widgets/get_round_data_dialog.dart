 import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


showAlertDialog(BuildContext context) {
   Widget cancelaButton = TextButton(
    child: const Text("Cancelar"),
    onPressed:  () {
       Navigator.of(context).pop();
    },
  );
  Widget continuaButton = TextButton(
    child: const Text("Continar"),
    onPressed:  () {
       Navigator.of(context).pop();
    },
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(

    title: const Text("PALAVRA DA RODADA"),
    content: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child:TextField(
            style: const TextStyle(color: Colors.white),
            decoration:  InputDecoration(
              filled: true,
              fillColor: HexColor('#2E303F'),
              focusedBorder:  OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: HexColor("#6B5FCD"),  width: 2)
              ),
              enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor('#2E303F'), 
                  width: 1.0
                ),
              ),
              labelText: 'Tema',
              labelStyle: const TextStyle(
                color: Colors.white,
                  fontStyle: FontStyle.normal,
              ),
              border: const OutlineInputBorder(),
            ))
        ),
         Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration:  InputDecoration(
              filled: true,
              fillColor: HexColor('#2E303F'),
              focusedBorder:  OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: HexColor("#6B5FCD"),  width: 2)
              ),
              enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor('#2E303F'), 
                  width: 1.0
                ),
              ),
              labelText: 'Dica',
              labelStyle: const TextStyle(
                color: Colors.white,
                  fontStyle: FontStyle.normal,
              ),
              border: const OutlineInputBorder(),
            ))
          ),
         TextField(
          style: const TextStyle(color: Colors.white),
          decoration:  InputDecoration(
            filled: true,
            fillColor: HexColor('#2E303F'),
            focusedBorder:  OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: HexColor("#6B5FCD"),  width: 2)
            ),
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(
                color: HexColor('#2E303F'), 
                width: 1.0
              ),
            ),
            labelText: 'Resposta',
            labelStyle: const TextStyle(
              color: Colors.white,
                fontStyle: FontStyle.normal,
            ),
            border: const OutlineInputBorder(),
          ),
        )
      ]
    ),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );
  //exibe o diálogo
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}