import 'package:flutter/material.dart';
import 'package:trivia/entities/message.dart';

import 'package:hexcolor/hexcolor.dart';


class Chat extends StatelessWidget {
  final List<Message> messages;
  const Chat ({ Key? key, required this.messages }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Expanded(
      child: Container(
        height: 200,
        decoration:  BoxDecoration(
            color: HexColor("#1F1D2B"),
        ),
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: messages.length,
            itemBuilder: (BuildContext contex, int index){
              if(messages[index].type == 'join'){
                return Text(messages[index].nickname + messages[index].message,style: TextStyle(color: Colors.green.withOpacity(0.6)));
              }else{
                return Text(messages[index].nickname + messages[index].message,style: TextStyle(color: Colors.black.withOpacity(0.6)));
              }
              
            }
          )
      )
    );
  }
}