import 'package:flutter/material.dart';
import 'package:trivia/entities/message.dart';


import 'package:hexcolor/hexcolor.dart';
import 'package:trivia/service/controller_chat.dart';


class Chat extends StatelessWidget {
  final List<Message> messages;
  Chat ({ Key? key, required this.messages }) : super(key: key);
  final ChatController chatController = ChatController();

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
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              controller: chatController.getController(),
              shrinkWrap: true,
              
              itemCount: messages.length,
              itemBuilder: (BuildContext contex, int index){
                if(messages[index].type == 'join'){
                  return Text(messages[index].nickname + messages[index].message,style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold
                  ));
                } if(messages[index].type == 'leave'){
                  return Text(messages[index].nickname + messages[index].message,style:  TextStyle(
                    color: HexColor("#EB5D5E"),
                    fontWeight: FontWeight.bold
                  ));
                }else{
                  return Row(
                    children: [
                    Text(messages[index].nickname+": ", style: TextStyle(
                      color: HexColor("#6B5FCD"),
                      fontWeight: FontWeight.bold
                    )),
                    Text(messages[index].message, style: const TextStyle(
                      color: Colors.white
                    ))
                    ],
                  );
                }
                
              }
            )
        )
      )
    );
  }
}