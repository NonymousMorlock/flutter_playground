import 'package:discord_test/hover_aware_social_tile.dart';
import 'package:flutter/material.dart';

class HoverAwareSocials extends StatelessWidget {
  const HoverAwareSocials({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: 300,
      child: ColoredBox(
        color: Color(0xFF050950),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HoverAwareSocialTile(
              themeColour: Color(0xFF8BC34A),
              image: 'envato.png',
            ),
            HoverAwareSocialTile(
              themeColour: Color(0xFFFA9801),
              image: 'stack-overflow.png',
            ),
            HoverAwareSocialTile(
              themeColour: Color(0xFF7c3670),
              image: 'instagram.png',
            ),
          ],
        ),
      ),
    );
  }
}
