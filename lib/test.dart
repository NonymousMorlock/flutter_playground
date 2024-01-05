import 'package:discord_test/hover_aware_container.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: NavigationRail(
                backgroundColor: Colors.grey,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.candlestick_chart),
                    label: Text('Activity'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('UI'),
                  ),
                ],
                selectedIndex: 0,
              ),
            ),
            Expanded(
              flex: 7,
              child: ListView(
                children: [
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      controller: ScrollController(),
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, __) => const SizedBox(
                        width: 10,
                      ),
                      itemBuilder: (_, __) {
                        return const Placeholder(
                          fallbackWidth: 200,
                          fallbackHeight: 200,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Center(child: HoverAwareContainer())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
