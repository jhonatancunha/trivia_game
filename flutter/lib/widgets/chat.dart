import 'package:flutter/material.dart';
import 'package:trivia/entities/message.dart';

class Chat extends StatelessWidget {
  final List<Message> messages;
  const Chat ({ Key? key, required this.messages }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // debugPrint(players.length);
    return Expanded(
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFBBC9D0),
                Color(0xFFF0F2F2),
              ],
            )
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