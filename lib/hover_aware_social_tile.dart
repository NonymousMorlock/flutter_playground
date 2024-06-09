import 'package:flutter/material.dart';

class HoverAwareSocialTile extends StatefulWidget {
  const HoverAwareSocialTile({
    required this.themeColour,
    required this.image,
    super.key,
  });

  final Color themeColour;
  final String image;

  @override
  State<HoverAwareSocialTile> createState() => _HoverAwareSocialTileState();
}

class _HoverAwareSocialTileState extends State<HoverAwareSocialTile> {
  final shimmerHeightNotifier = ValueNotifier<double>(0);
  final shimmerPusherNotifier = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        shimmerHeightNotifier.value = 50;
        shimmerPusherNotifier.value = 50;
      },
      onExit: (_) {
        shimmerHeightNotifier.value = 0;
        shimmerPusherNotifier.value = 0;
      },
      child: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: Stack(
            children: [
              Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: shimmerPusherNotifier,
                    builder: (_, value, __) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: value,
                      );
                    },
                  ),
                  Flexible(
                    child: ValueListenableBuilder(
                      valueListenable: shimmerHeightNotifier,
                      builder: (_, value, __) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          color: Colors.grey.withOpacity(.4),
                          width: 50,
                          height: value,
                        );
                      },
                    ),
                  ),
                ],
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: widget.themeColour, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/${widget.image}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
