import 'package:flutter/material.dart';
import 'package:trivia/widgets/widgets.dart';
import 'package:trivia/screen/game.dart';



class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _nickname = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Form(
      key: _formKey,
      child: Column(children: [
        const WindowTitleBar(),
        Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            SizedBox(
              height: 50,
              width: 500,
              
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite seu nickname',
                ),

                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, digite alguma coisa";
                  }
                  _nickname = value;
                  return null;
                },
              ),
            ),
            
            SizedBox(
              height: 80,
              width: 200,

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  GameScreen(nickname: _nickname)),
                      );
                    }
                  },
                  
                  child: const Text('Entrar'),
                ),
              ),
            )
          ],
        ),
      ),
      ],)
    ));
  }
}
