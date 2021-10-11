// Flutter
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:trivia/screen/game.dart';
import 'package:trivia/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
    await DesktopWindow.setMinWindowSize(const Size(1200, 800));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.black,


      ),
      home:  const LeftMenu()
    );
  }
}


class LeftMenu extends StatelessWidget {
  const LeftMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // LEFT SIDE
          Expanded(child: Row(
            children: const [
              SideBar(),
              Expanded(
                child: GameScreen()
              )
            ],
          )),
          // BOTTOM SIDE
          Container(
            height: 84,
            width: double.infinity,
            color: Colors.blue
          )
        ]
      )
    );
  }
}