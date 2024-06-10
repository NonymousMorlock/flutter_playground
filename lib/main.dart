import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      home: InputPage(),
    );
  }
}

const bottomContainerHeight = 80.0;
const activeCardColour = Color(0xFF1D1E33);
const bottomContainerColour = Color(0xFFEB1555);
const inactiveCardColour = Color(0xFF111328);

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectedGender;

  // Color maleCardColour = inactiveCardColour;
  // Color femaleCardColour = inactiveCardColour;

  //1 = male, 2 = female
  // void updateColour(Gender selectedGender) {
  //   //male card pressed
  //   if (selectedGender == Gender.male) {
  //     if (maleCardColour == inactiveCardColour) {
  //       maleCardColour = activeCardColour;
  //       femaleCardColour = inactiveCardColour;
  //     } else {
  //       maleCardColour = inactiveCardColour;
  //     }
  //   }
  //   // female card pressed
  //   if (selectedGender == Gender.female) {
  //     if (femaleCardColour == inactiveCardColour) {
  //       femaleCardColour = activeCardColour;
  //       maleCardColour = inactiveCardColour;
  //     } else {
  //       femaleCardColour = inactiveCardColour;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'BMI CALCULATOR',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedGender = Gender.male;
              });
            },
            child: ReusableCard(
              colour: selectedGender == Gender.male
                  ? activeCardColour
                  : inactiveCardColour, //maleCardColour,
              cardChild: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.mars, color: Colors.white),
                    Text('MALE', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedGender = Gender.female;
              });
            },
            child: ReusableCard(
              colour: selectedGender == Gender.female
                  ? activeCardColour
                  : inactiveCardColour,
              cardChild: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.venus, color: Colors.white),
                    Text('FEMALE', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  const ReusableCard({required this.colour, super.key, this.cardChild});

  final Color colour;
  final Widget? cardChild;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colour,
      child: cardChild,
    );
  }
}
