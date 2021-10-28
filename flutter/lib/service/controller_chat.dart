import 'package:flutter/material.dart';

class ChatController{
  static final ChatController _singleton = ChatController._internal();
  static final ScrollController _controllerChat = ScrollController();

  ScrollController getController(){
    return _controllerChat;
  }

  static void scrollDown(){
    _controllerChat.animateTo(
      _controllerChat.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  factory ChatController() {
    return _singleton;
  }

  

  ChatController._internal();
}