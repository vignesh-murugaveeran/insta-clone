import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:insta_clone2/home.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Get.off(() => Home());
      // (OR)
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Home()),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = context.screenHeight - 600;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height),
              Image.asset(ic1, width: 100),
              const Spacer(),
              'from'.text.size(15).make(),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ic3, width: 46, color: Colors.red),
                  7.widthBox,
                  'Meta'.text.size(17).color(Colors.red).make(),
                ],
              ),
              18.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
