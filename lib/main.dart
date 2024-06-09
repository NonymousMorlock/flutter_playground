import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      XylophoneApp()
  );
}

class XylophoneApp extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  void playSound(int noteNumber) async {
    print('Playing sound for note $noteNumber');

    await  player.play(AssetSource('note$noteNumber.wav'));
  }
  Expanded buildKey({Color? color, int? noteNumber}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          print('Button $noteNumber pressed');

          playSound(noteNumber!);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(''),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildKey(color: Colors.red, noteNumber: 1),
              buildKey(color: Colors.orange, noteNumber: 2),
              buildKey(color: Colors.yellow, noteNumber: 3),
              buildKey(color: Colors.green, noteNumber: 4),
              buildKey(color: Colors.blue, noteNumber: 5),
              buildKey(color: Colors.indigo, noteNumber: 6),
              buildKey(color: Colors.purple, noteNumber: 7),

            ],
          ),

        ),
      ),
    );
  }
}