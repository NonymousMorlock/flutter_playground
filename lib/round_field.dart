import 'package:discord_test/tab_label.dart';
import 'package:flutter/material.dart';

class TabExample extends StatefulWidget {
  const TabExample({super.key});

  @override
  State<TabExample> createState() => _TabExampleState();
}

class _TabExampleState extends State<TabExample>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFA0D34D);
    final currentTheme = Theme.of(context);
    final all = [
      ('Swimming', Icons.water),
      ('Yoga', Icons.sports_gymnastics),
      ('Strength Training', Icons.sports_kabaddi),
      ('Dance', Icons.woman_outlined),
    ];

    final myBookings = [
      ('Dance', Icons.woman_outlined),
      ('Swimming', Icons.water),
    ];
    return Column(
      children: [
        Theme(
          data: currentTheme.copyWith(
            // As suggested by https://stackoverflow.com/a/75573719/17971158
            colorScheme: currentTheme.colorScheme.copyWith(
              surfaceVariant: color,
            ),
          ),
          child: ListenableBuilder(
            listenable: tabController,
            builder: (_, __) {
              return TabBar(
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: color,
                labelPadding: EdgeInsets.zero,
                labelColor: color,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: TabLabel(
                      isSelected: tabController.index == 0,
                      text: 'All',
                    ),
                  ),
                  Tab(
                    child: TabLabel(
                      isSelected: tabController.index == 1,
                      text: 'My Bookings',
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: List.generate(2, (outerMostIndex) => outerMostIndex)
                .map((middleLayerIndex) {
              final activeList = switch (middleLayerIndex) {
                0 => all,
                _ => myBookings,
              };
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: activeList.map((activity) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: color, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          activity.$2,
                          size: 50,
                          color: color,
                        ),
                        Text(
                          activity.$1,
                          style: const TextStyle(
                            color: color,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
