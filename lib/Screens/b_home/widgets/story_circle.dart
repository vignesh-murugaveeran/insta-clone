import 'package:flutter/material.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:insta_clone2/consts/styles.dart';
import 'package:insta_clone2/domain/utils.dart';
import 'package:velocity_x/velocity_x.dart';

Widget storyCircle() {
  return SizedBox(
    height: 155,
    child: Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.widthBox,
              // Stack(
              //   children: [
              //     Container(
              //       height: 85,
              //       width: 85,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(100),
              //         image: DecorationImage(
              //           image: AssetImage(img2),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     Positioned(
              //       right: 0,
              //       bottom: 0,
              //       child: Container(
              //         decoration: BoxDecoration(
              //           border: Border.all(width: 2, color: Colors.white),
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: ClipOval(
              //           child: Container(
              //             decoration: BoxDecoration(color: Colors.black),
              //             child: const Icon(Icons.add, color: Colors.white),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(img2),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ClipOval(
                          child: Icon(Icons.add, color: Colors.white).box.black
                              .border(width: 2, color: Colors.white)
                              .roundedFull
                              .make(),
                        ),
                      ),
                    ],
                  ),
                  'Your story'.text.size(13).make(),
                ],
              ),
              ...List.generate(7, (index) {
                return Container(
                  width: 82,
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: CircleAvatar(
                          radius: 37,
                          backgroundColor: Colors.white70,
                          backgroundImage: AssetImage(img2),
                        ),
                      ),
                      'Jayson Roy'.text.size(13).make(),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        13.heightBox,
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                'Suggest for you',
                style: vTextStyle15(
                  fontColor: Colors.black87,
                  fontFamily: secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                'Older posts',
                style: vTextStyle15(
                  fontColor: Colors.blue,
                  fontFamily: secondary,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
