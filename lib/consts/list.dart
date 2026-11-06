import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insta_clone2/consts/images.dart';

var publicPosts = [img1, img2, img1, img1, img2, img1, img2];

var publicNames = [
  'Vijay Kumar',
  'Baalu Bhai',
  'Teena',
  'Hentry',
  'King',
  'Julie',
  'Tom & Jerry',
];

// main.dart
Map<String, dynamic> public = {
  //7
  'publicPosts': [img1, img2, img1, img1, img2, img1, img2],
  'publicNames': [
    'Vijay Kumar',
    'Baalu Bhai',
    'Teena',
    'Hentry',
    'King',
    'Julie',
    'Tom & Jerry',
  ],
  'publicSubtitle': [
    '"Just a human trying to figure it out. Coffee helps."',
    '"Creating one [art/project/meal] at a time."',
    '"Slowing down. Looking up."',
    '"Collecting moments, not things."',
    '"Professional overthinker. Amateur adult."',
    '"Where my chaos finds its color."',
    '"Helping you [achieve a goal]. Daily tips & inspiration."',
  ],
  'publicImages': [img1, img2, img1, img2, img1, img2, img1],
};

final publicReels = [video1, video2, video2, video1, video2];

//SETTING SCREEN
Map<String, dynamic> howUseInsta = {
  //5
  'icon': [
    Icon(Icons.bookmark_border_sharp),
    Icon(Icons.archive_outlined),
    Icon(Icons.local_activity_outlined),
    Icon(Icons.notifications_none_sharp),
    Icon(Icons.access_time_sharp),
  ],
  'iconText': [
    'Saved',
    'Archieve',
    'Your activity',
    'Notification',
    'Time management',
  ],
};
Map<String, dynamic> whoSeeContent = {
  //5
  'icon': [
    Icon(Icons.bookmark_border_sharp),
    Icon(Icons.archive_outlined),
    Icon(Icons.local_activity_outlined),
    Icon(Icons.notifications_none_sharp),
    Icon(Icons.access_time_sharp),
  ],
  'iconText': [
    'Saved',
    'Archieve',
    'Your activity',
    'Notification',
    'Time management',
  ],
};
