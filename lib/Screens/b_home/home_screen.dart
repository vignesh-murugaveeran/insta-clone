import 'package:flutter/material.dart';
import 'package:insta_clone2/Screens/TESTING/build_home_feed.dart';
import 'package:insta_clone2/post_home.dart';
import 'package:insta_clone2/Screens/b_home/widgets/home_posts.dart';
import 'package:insta_clone2/Screens/b_home/widgets/story_circle.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:insta_clone2/consts/list.dart';
import 'package:insta_clone2/consts/styles.dart';
import 'package:insta_clone2/domain/utils.dart';
import 'package:insta_clone2/models/post_model.dart';
import 'package:velocity_x/velocity_x.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             pinned: false,
//             floating: true,
//             snap: true,
//             title: Text(
//               'Instagram',
//               style: vTextStyle28(
//                 fontColor: Colors.black,
//                 fontFamily: 'Primary',
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.favorite_border_sharp, size: 30),
//                 onPressed: () {},
//               ),
//               5.widthBox,
//               IconButton(
//                 icon: Image.asset(icSend, width: 25),
//                 onPressed: () {},
//               ),
//               5.widthBox,
//             ],
//           ),
//           SliverToBoxAdapter(child: storyCircle()),
//           SliverList(
//             delegate: SliverChildBuilderDelegate((context, index) {
//               return homePosts();
//             }, childCount: 7),
//           ),
//         ],
//       ),
//     );
//   }
// }

// 'Instagram'.text
//             .textStyle(
//               vTextStyle28(
//                 fontColor: Colors.black,
//                 fontFamily: 'Primary',
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//             .make(),
// Text(
//           'Instagram',
//           style: vTextStyle28(
//             fontColor: Colors.black,
//             fontFamily: 'Primary',
//             fontWeight: FontWeight.bold,
//           ),
//         ),

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         physics: const ClampingScrollPhysics(), //Smoother physics
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.white,
//             pinned: false,
//             floating: true,
//             snap: true,
//             title: Text(
//               'Instagram',
//               style: vTextStyle28(
//                 fontColor: Colors.black,
//                 fontFamily: 'Primary',
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.favorite_border_sharp, size: 30),
//                 onPressed: () {},
//               ),
//               5.widthBox,
//               IconButton(
//                 icon: Image.asset(icSend, width: 25),
//                 onPressed: () {},
//               ),
//               5.widthBox,
//             ],
//           ),
//           SliverToBoxAdapter(child: storyCircle()),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 return
//                 //HomePost(index: index);
//                 buildHomeFeed();
//               },
//               childCount: public['publicImages'].length,
//               addAutomaticKeepAlives: true, //Performance optimization
//               addRepaintBoundaries: true, //Performance optimization
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
///****************************BEFORE ADDING THE COMMON for USED-FEED AND PUBLIC-HOME-FEED*********** */
import 'package:insta_clone2/Screens/b_home/widgets/post_data.dart'; // Import your data

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> posts = [];

  @override
  void initState() {
    super.initState();
    _loadLocalPosts();
  }

  void _loadLocalPosts() {
    setState(() {
      posts = homeFeedPosts; // Use your imported data
    });
  }

  void _handleLike(int index) {
    setState(() {
      posts[index] = posts[index].copyWith(
        isLiked: !posts[index].isLiked,
        likes: posts[index].isLiked
            ? posts[index].likes - 1
            : posts[index].likes + 1,
      );
    });
  }

  void _handleBookmark(int index) {
    setState(() {
      posts[index] = posts[index].copyWith(
        isBookMarked: !posts[index].isBookMarked,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            pinned: false,
            floating: true,
            snap: true,
            title: Text(
              'Instagram',
              style: vTextStyle28(
                fontColor: Colors.black,
                fontFamily: 'Primary',
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite_border_sharp, size: 30),
                onPressed: () {},
              ),
              5.widthBox,
              IconButton(
                icon: Image.asset(icSend, width: 25),
                onPressed: () {},
              ),
              5.widthBox,
            ],
          ),
          SliverToBoxAdapter(child: storyCircle()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PostHome(
                  post: posts[index],
                  isUserPost: false,
                  onLike: () => _handleLike(index),
                  onComment: () {
                    print('Comment on ${posts[index].userName}\'s post');
                  },
                  onShare: () {
                    print('Share ${posts[index].userName}\'s post');
                  },
                  onSave: () => _handleBookmark(index),
                  onFollow: () {
                    print('Followed ${posts[index].userName}');
                  },
                );
              },
              childCount: posts.length,
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
            ),
          ),
        ],
      ),
    );
  }
}
