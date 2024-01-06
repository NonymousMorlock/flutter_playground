import 'package:discord_test/hover_aware_social_tile_2.dart';
import 'package:flutter/material.dart';

class HoverAwareSocials2 extends StatelessWidget {
  const HoverAwareSocials2({super.key});

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
            HoverAwareSocialTile2(
              themeColour: Color(0xFF8BC34A),
              image: 'envato.png',
            ),
            HoverAwareSocialTile2(
              themeColour: Color(0xFFFA9801),
              image: 'stack-overflow.png',
            ),
            HoverAwareSocialTile2(
              themeColour: Color(0xFF7c3670),
              image: 'instagram.png',
            ),
          ],
        ),
      ),
    );
  }
}
