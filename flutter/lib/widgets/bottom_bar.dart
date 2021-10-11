import 'package:flutter/material.dart';

class BottomBart extends StatefulWidget {
  const BottomBart({ Key? key }) : super(key: key);

  @override
  _BottomBartState createState() => _BottomBartState();
}

class _BottomBartState extends State<BottomBart> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(5),
      color: Colors.white,
      child: Row(
      children:  <Widget>[
       const Flexible(
        child: TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey, 
                width: 1.0
              ),
            ),
            labelText: 'Digite aqui...',
            labelStyle: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600
            ),
            border: OutlineInputBorder(),
          ),
        )
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: 5,
          top: 0,
          right: 5,
          bottom: 0
        ),
        child: SizedBox(
          height: 50,
          child: TextButton(
            onPressed: () {
              print("pressionou");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Text(
              "ENVIAR",
              style: TextStyle(
                color: Colors.white
              )
            ),
        ))
        ),
      ],
      
      
)
    );
  }
}