import 'package:flutter/material.dart';

class BottomBart extends StatefulWidget {
  const BottomBart({ Key? key  }) : super(key: key);


  @override
  _BottomBartState createState() => _BottomBartState();
}

class _BottomBartState extends State<BottomBart> {
  String stateMessage = '';
  final chatMessage = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    chatMessage.dispose();
    super.dispose();
  }
  
    
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(5),
      color: Colors.white,
      child: Row(
      children:  <Widget>[
      Flexible(
        child: TextField(
          controller: chatMessage,
          onChanged: (text){
            setState(() {
              stateMessage = text;
            });
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
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
              print(stateMessage);
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