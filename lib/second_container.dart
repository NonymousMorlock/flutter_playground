import 'package:discord_test/main.dart';
import 'package:flutter/material.dart';

import 'foo_state.dart';

class SecondContainer extends StatelessWidget {
  const SecondContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      width: 200,
      duration: Duration(milliseconds: 300),
      color: fooState.colour,
    );
  }
}
