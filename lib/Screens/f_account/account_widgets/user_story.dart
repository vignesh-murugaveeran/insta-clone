import 'package:flutter/material.dart';
import 'package:insta_clone2/commonWidgets/user_story_card.dart';
import 'package:velocity_x/velocity_x.dart';

Widget userCard() {
  return SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      itemCount: userStoryCard.length,
      itemBuilder: (context, index) {
        return Container(
          width: 80,
          margin: const EdgeInsets.only(right: 13),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 37,
                child: Icon(userStoryCard[index]['icon']),
              ).onTap(() {}),
              Text(
                userStoryCard[index]['title'],
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    ),
  );
}
