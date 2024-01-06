import 'package:flutter/material.dart';

class HoverAwareContainer extends StatefulWidget {
  const HoverAwareContainer({super.key});

  @override
  State<HoverAwareContainer> createState() => _HoverAwareContainerState();
}

class _HoverAwareContainerState extends State<HoverAwareContainer>
    with TickerProviderStateMixin {
  final containerWidthNotifier = ValueNotifier<double>(0);
  double containerHeight = 400;
  late Curve curve;

  late Animation<Offset> topTextAnimation;
  late Animation<Offset> bottomWidgetAnimation;
  late Animation<double> opacityAnimation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    curve = Curves.fastEaseInToSlowEaseOut;

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    topTextAnimation = Tween<Offset>(
      begin: const Offset(3.5, -1),
      end: const Offset(3.5, 0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: curve),
    );
    bottomWidgetAnimation = Tween<Offset>(
      begin: const Offset(0.1, 1),
      end: const Offset(0.1, 0.7),
    ).animate(
      CurvedAnimation(parent: animationController, curve: curve),
    );
    opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    containerWidthNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        containerWidthNotifier.value = 600;
        animationController.forward();
      },
      onExit: (_) {
        containerWidthNotifier.value = 0;
        animationController.reverse();
      },
      child: SizedBox(
        height: 400,
        width: 600,
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Container(
              color: Colors.purple,
            ),
            ValueListenableBuilder(
              valueListenable: containerWidthNotifier,
              builder: (_, value, __) {
                return AnimatedContainer(
                  color: Colors.grey.withOpacity(.8),
                  duration: const Duration(milliseconds: 200),
                  height: containerHeight,
                  width: value,
                );
              },
            ),
            AnimatedBuilder(
              animation: topTextAnimation,
              child: const Text(
                '02',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                ),
              ),
              builder: (context, child) {
                return FadeTransition(
                  opacity: opacityAnimation,
                  child: SlideTransition(
                    position: topTextAnimation,
                    child: child,
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: bottomWidgetAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Website Development',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text(
                    'WordPress . Blog',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('View Work'),
                  ),
                ],
              ),
              builder: (context, child) {
                return FadeTransition(
                  opacity: opacityAnimation,
                  child: SlideTransition(
                    position: bottomWidgetAnimation,
                    child: child,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
