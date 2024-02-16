
import 'package:flutter/material.dart';

class TabLabel extends StatelessWidget {
  const TabLabel({super.key, required this.isSelected, required this.text});

  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFA0D34D);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: isSelected ? color : null,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}

