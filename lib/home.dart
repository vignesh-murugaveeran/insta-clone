import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone2/Controller/dash_controller.dart';
import 'package:insta_clone2/Screens/f_account/b_Reels/widgets/user_reel_data.dart';
import 'package:insta_clone2/Screens/b_home/home_screen.dart';
import 'package:insta_clone2/Screens/c_search/insta_style/search_content.dart';
import 'package:insta_clone2/Screens/d_userPost/widgets/add_post_anim.dart';
import 'package:insta_clone2/Screens/d_userPost/add_post_screen.dart';
import 'package:insta_clone2/Screens/e_Reels/reel_screen1.dart';
import 'package:insta_clone2/Screens/f_account/account_screen.dart';
import 'package:insta_clone2/consts/images.dart';

/// Dashboard
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(DashController());
  DateTime? currentBackPressTime;

  var navBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      activeIcon: Icon(Icons.search),
      label: 'Search',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add_box_outlined),
      activeIcon: Icon(Icons.add_box),
      label: 'Add Post',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.video_collection_outlined),
      activeIcon: Icon(Icons.video_collection_rounded),
      label: 'Reels',
    ),
    BottomNavigationBarItem(
      icon: CircleAvatar(radius: 15, backgroundImage: AssetImage(img2)),
      label: 'Profile',
    ),
  ];

  // Use a simple list of widgets without IndexedStack
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SearchContent();
      case 2:
        return const SizedBox(); // Placeholder for Add Post
      case 3:
        return ReelScreen1(
          reels: getAllReels(),
        ); // Create new instance each time
      case 4:
        return const AccountScreen();
      default:
        return const HomeScreen();
    }
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // Add Post button index
      Navigator.push(context, createRoute(const AddPostScreen()));
    } else {
      controller.currentNavIndex.value = index;
    }
  }

  Future<bool> _onWillPop() {
    //If not on home screen, switch to home screen
    if (controller.currentNavIndex.value != 0) {
      controller.currentNavIndex.value = 0;
      return Future.value(false);
    }

    //If on home screen, check for double tap to exit
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.snackbar(
        'Exit App',
        'Press back again to exit',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Obx(() => _getScreen(controller.currentNavIndex.value)),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentNavIndex.value,
            iconSize: 28,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedLabelStyle: const TextStyle(color: Colors.black),
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            items: navBarItem,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
