import 'package:flutter/material.dart';

Widget tabs({tabController}) {
  return TabBar(
    controller: tabController,
    dividerHeight: 0.5,
    indicator: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.black, width: 1.5)),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    unselectedLabelColor: Colors.grey,
    labelColor: Colors.black,
    indicatorColor: Colors.black87,
    tabs: [
      //(1)We can use AnimatedBuilder or _tabcontroller.addListener(_handleTabChanges)
      // for Swaping from 1 tab to another tab.
      //(2)But here i use both AnimatedBuilder and _tabcontroller.addListener(_handleTabChanges)
      Tab(
        icon: AnimatedBuilder(
          animation: tabController.animation!,
          builder: (context, child) {
            final value = tabController.animation!.value;
            return Icon(
              value >= 0 && value < 0.5
                  ? Icons.grid_view_sharp
                  : Icons.grid_view_outlined,
            );
          },
        ),
      ),
      Tab(
        icon: AnimatedBuilder(
          animation: tabController.animation!,
          builder: (context, child) {
            final value = tabController.animation!.value;
            return Icon(
              value >= 0.5 && value < 1.5
                  ? Icons.video_collection_rounded
                  : Icons.video_collection_outlined,
            );
          },
        ),
      ),
      // Tab(
      //   icon: AnimatedBuilder(
      //     animation: tabController.animation!,
      //     builder: (context, child) {
      //       final value = tabController.animation!.value;
      //       return Icon(
      //         value >= 1.5
      //             ? Icons.person_pin_rounded
      //             : Icons.person_pin_outlined,
      //       );
      //     },
      //   ),
      // ),
    ],
  );
}
