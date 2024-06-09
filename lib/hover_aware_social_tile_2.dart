import 'package:flutter/material.dart';

class HoverAwareSocialTile2 extends StatefulWidget {
  const HoverAwareSocialTile2({
    required this.themeColour,
    required this.image,
    super.key,
  });

  final Color themeColour;
  final String image;

  @override
  State<HoverAwareSocialTile2> createState() => _HoverAwareSocialTile2State();
}

class _HoverAwareSocialTile2State extends State<HoverAwareSocialTile2>
    with TickerProviderStateMixin {
  final shimmerHeightNotifier = ValueNotifier<double>(0);
  final shimmerPusherNotifier = ValueNotifier<double>(0);

  late AnimationController _shimmerController;
  late AnimationController _shimmerPusherController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        final shimmerHeight = _shimmerController.value * 50;
        shimmerHeightNotifier.value = shimmerHeight;
        if (shimmerHeight >= 30 && !_shimmerPusherController.isAnimating) {
          _shimmerPusherController.forward();
        } else if (_shimmerController.status == AnimationStatus.reverse &&
            shimmerHeight <= 30) {
          _shimmerPusherController.reverse();
        }
        setState(() {});
      });
    _shimmerPusherController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        final shimmerPusherHeight = _shimmerPusherController.value * 50;
        shimmerPusherNotifier.value = shimmerPusherHeight;
        if (_shimmerPusherController.status == AnimationStatus.reverse &&
            shimmerPusherHeight <= 30) {
          _shimmerController.reverse();
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _shimmerPusherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        _shimmerController.forward();
      },
      onExit: (_) {
        _shimmerPusherController.reverse();
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
                      return SizedBox(
                        height: value,
                      );
                    },
                  ),
                  Flexible(
                    child: ValueListenableBuilder(
                      valueListenable: shimmerHeightNotifier,
                      builder: (_, value, __) {
                        return Container(
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
