import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone2/Screens/a_splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Insta_clone2',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      // ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

//***********************AFTER ADDING BACKEND */
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:insta_clone2/controllers/auth_controller.dart';
// import 'package:insta_clone2/controllers/post_controller.dart';
// import 'package:insta_clone2/Screens/a_auth/login_screen.dart';
// import 'package:insta_clone2/home.dart';

// void main() {
//   // Initialize GetX controllers
//   Get.put(AuthController());
//   Get.put(PostController());

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Instagram Clone',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: Colors.black,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.black,
//           elevation: 0,
//         ),
//       ),
//       home: const AuthWrapper(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.find<AuthController>();

//     return Obx(() {
//       if (authController.isLoggedIn.value) {
//         return const Home();
//       } else {
//         return LoginScreen();
//       }
//     });
//   }
// }
