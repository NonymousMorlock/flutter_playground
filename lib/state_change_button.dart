import 'package:discord_test/foo_state.dart';
import 'package:discord_test/main.dart';
import 'package:flutter/material.dart';

class StateChangeButton extends StatelessWidget {
  StateChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {

        fooState.changeColour(Colors.black);

      },
      child: Text('Change State'),
    );
  }
}
