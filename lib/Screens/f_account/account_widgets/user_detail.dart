import 'package:flutter/material.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:velocity_x/velocity_x.dart';

Widget userDetail() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(radius: 40, backgroundImage: AssetImage(img2)),
            Positioned(
              right: 0,
              top: 0,
              child:
                  Row(
                        children: [
                          Text('note', style: TextStyle(fontSize: 12)),
                          Icon(Icons.edit_outlined, size: 10),
                        ],
                      ).box
                      .size(45, 30)
                      .rounded
                      .padding(EdgeInsets.only(left: 5, right: 5))
                      .color(Colors.white)
                      .shadowLg
                      .make(),
            ),
          ],
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      22.widthBox,
                      Flexible(
                        child: Text(
                          'Vicky....................................................................................................',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15, // ← This should work
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: ['200'.text.make(), 'posts'.text.make()],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: ['20k'.text.make(), 'followers'.text.make()],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: ['122'.text.make(), 'following'.text.make()],
                    ),
                  ),
                ],
              ),
              22.heightBox,
            ],
          ),
        ),
      ],
    ),
  );
}
