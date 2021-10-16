// Flutter
import 'package:flutter/material.dart';
import 'package:trivia/screen/game.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // if(!kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
  //   await DesktopWindow.setMinWindowSize(const Size(1200, 800));
  // }
  runApp(const MyApp());

  doWhenWindowReady(() {
  const initialSize = Size(1200, 800);
  appWindow.minSize = initialSize;
  appWindow.size = initialSize;
  appWindow.alignment = Alignment.center;
  appWindow.show();
});
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
      home:  Scaffold(
        extendBodyBehindAppBar: true,
        body: WindowBorder(
          width: 1,
          color: const Color(0XFF805306),
          child: const GameScreen(),
        )
      )
    );
  }
}

