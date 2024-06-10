import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();

  Future<void> playSound(int noteNumber) async {
    await player.stop();
    print('Playing sound for note $noteNumber');

    await player.play(AssetSource('note$noteNumber.wav'));
  }

  Expanded buildKey({Color? color, int? noteNumber}) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () async {
          print('Button $noteNumber pressed');

          await playSound(noteNumber!);
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
        bottomNavigationBar: IBottomNavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            NavBarNotifier.instance.toggle();
          },
          child: Icon(Icons.add),
        )
      ),
    );
  }
}

class NavBarNotifier {
  NavBarNotifier._internal();

  static final NavBarNotifier instance = NavBarNotifier._internal();

  final ValueNotifier<bool> _showNavBar = ValueNotifier<bool>(true);

  ValueNotifier<bool> get showNavBar => _showNavBar;

  void hide() {
    if (_showNavBar.value) {
      _showNavBar.value = false;
    }
  }

  void show() {
    if (!_showNavBar.value) {
      _showNavBar.value = true;
    }
  }

  void toggle() {
    _showNavBar.value = !_showNavBar.value;
  }
}

class IBottomNavBar extends StatelessWidget {
  const IBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: NavBarNotifier.instance.showNavBar,
      builder: (_, showNav, __) {
        if (showNav) {
          return BottomAppBar(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                  },
                  icon: Icon(Icons.stop),
                ),
                IconButton(
                  onPressed: () async {
                  },
                  icon: Icon(Icons.pause),
                ),
                IconButton(
                  onPressed: () async {
                  },
                  icon: Icon(Icons.play_arrow),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
