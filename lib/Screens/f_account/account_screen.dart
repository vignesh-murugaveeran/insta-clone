// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:insta_clone2/Screens/f_account/post_detail_screen.dart';
// import 'package:insta_clone2/Screens/f_account/post_grid.dart';
// import 'package:insta_clone2/Screens/f_account/profile_buttons_head.dart';
// import 'package:insta_clone2/Screens/f_account/reel_detail_screen.dart';
// import 'package:insta_clone2/Screens/f_account/settings/settings_screen.dart';
// import 'package:insta_clone2/Screens/f_account/tabs.dart';
// import 'package:insta_clone2/Screens/f_account/user_detail.dart';
// import 'package:insta_clone2/Screens/f_account/user_story.dart';
// import 'package:insta_clone2/consts/images.dart';
// import 'package:insta_clone2/models/media_item.dart';
// import 'package:velocity_x/velocity_x.dart';

// class AccountScreen extends StatefulWidget {
//   const AccountScreen({super.key});

//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }

// class _AccountScreenState extends State<AccountScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(_handleTabChange);
//   }

//   void _handleTabChange() {
//     if (_tabController.indexIsChanging) {
//       setState(() {}); //Force rebuild when tab changes
//     }
//   }

//   @override
//   void dispose() {
//     _tabController.removeListener(_handleTabChange);
//     _tabController.dispose();
//     super.dispose();
//   }

//   // Sample data - add this inside _AccountScreenState class
//   final List<MediaItem> userPosts = [
//     MediaItem(
//       id: '1',
//       thumbnailPath: img2,
//       mediaPath: img2,
//       type: MediaType.image,
//       likes: 1250,
//       caption: 'Beautiful sunset!',
//       createdAt: DateTime.now().subtract(const Duration(days: 1)),
//     ),
//     MediaItem(
//       id: '2',
//       thumbnailPath: img1,
//       mediaPath: img1,
//       type: MediaType.image,
//       likes: 890,
//       caption: 'Coffee time ☕',
//       createdAt: DateTime.now().subtract(const Duration(days: 2)),
//     ),
//     MediaItem(
//       id: '3',
//       thumbnailPath: img2,
//       mediaPath: img2,
//       type: MediaType.image,
//       likes: 1520,
//       caption: 'Nature walk 🌿',
//       createdAt: DateTime.now().subtract(const Duration(days: 3)),
//     ),
//   ];

//   final List<MediaItem> userReels = [
//     MediaItem(
//       id: '4',
//       thumbnailPath: img2,
//       mediaPath: 'assets/videos/video1.mp4',
//       type: MediaType.video,
//       likes: 1000,
//       views: 15200,
//       caption: 'Check out this trick!',
//       createdAt: DateTime.now().subtract(const Duration(hours: 5)),
//     ),
//     MediaItem(
//       id: '5',
//       thumbnailPath: img2,
//       mediaPath: video2,
//       type: MediaType.video,
//       likes: 20067,
//       views: 8900,
//       caption: 'Fun moments!',
//       createdAt: DateTime.now().subtract(const Duration(hours: 10)),
//     ),
//   ];

//   // Handle media tap
//   // Simpler version - add this to your AccountScreen
//   void _handleMediaTap(MediaItem media) {
//     if (media.type == MediaType.image) {
//       // Navigate to PostDetailScreen for images
//       final imagePosts = userPosts
//           .where((item) => item.type == MediaType.image)
//           .toList();
//       final initialIndex = imagePosts.indexWhere((item) => item.id == media.id);

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PostDetailScreen(
//             mediaItems: imagePosts,
//             initialIndex: initialIndex >= 0 ? initialIndex : 0,
//           ),
//         ),
//       );
//     } else {
//       // Navigate to ReelDetailScreen for videos
//       final videoPosts = userReels
//           .where((item) => item.type == MediaType.video)
//           .toList();
//       final initialIndex = videoPosts.indexWhere((item) => item.id == media.id);

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ReelDetailScreen(
//             mediaItems: videoPosts,
//             initialIndex: initialIndex >= 0 ? initialIndex : 0,
//           ),
//           //ReelScreen(reelsPath: userReels),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: CustomScrollView(
//           physics: ClampingScrollPhysics(),
//           slivers: [
//             SliverAppBar(
//               backgroundColor: Colors.white,
//               surfaceTintColor: Colors.white,
//               pinned: true,
//               floating: true,
//               snap: false,
//               title: Row(
//                 children: [
//                   'vicky_345'.text.make(),
//                   Icon(Icons.keyboard_arrow_down_outlined),
//                 ],
//               ).onTap(() {}),
//               actions: [
//                 Icon(Icons.add_box_outlined, size: 28),
//                 15.widthBox,
//                 Icon(Icons.menu, size: 28).onTap(() {
//                   Get.to(SettingsScreen());
//                 }),
//                 15.widthBox,
//               ],
//             ),
//             SliverToBoxAdapter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   userDetail(),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child:
//                           'Add you bio.....................................................................................................................'
//                               .text
//                               .bold
//                               .color(Colors.blue)
//                               .size(14)
//                               .make(),
//                     ),
//                   ),
//                   10.heightBox,
//                   ProfileButtonsHead(),
//                   15.heightBox,
//                   userCard(),
//                 ],
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: AnimatedBuilder(
//                 animation: _tabController,
//                 builder: (context, _) {
//                   return tabs(tabController: _tabController);
//                 },
//               ),
//             ),
//             SliverFillRemaining(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   // postGrid(imgVid: userPosts),
//                   // postGrid(imgVid: userReels),
//                   //const Center(child: Text('All videos')),
//                   //MediaGrid(mediaItems: , onMediaTap: onMediaTap)
//                   // Posts Tab
//                   postGrid(mediaItems: userPosts, onMediaTap: _handleMediaTap),

//                   // Reels Tab
//                   postGrid(mediaItems: userReels, onMediaTap: _handleMediaTap),
//                   const Center(child: Text('Tagged')),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone2/Screens/f_account/b_Posts/Widgets/user_data.dart';
import 'package:insta_clone2/Screens/f_account/b_Reels/widgets/user_reel_data.dart';
import 'package:insta_clone2/post_home.dart';
import 'package:insta_clone2/Screens/e_Reels/reel_screen1.dart';
import 'package:insta_clone2/Screens/f_account/b_Posts/Widgets/post_grid.dart';
import 'package:insta_clone2/Screens/f_account/account_widgets/profile_buttons_head.dart';
import 'package:insta_clone2/Screens/f_account/c_settings_screen/settings_screen.dart';
import 'package:insta_clone2/Screens/f_account/account_widgets/tabs.dart';
import 'package:insta_clone2/Screens/f_account/account_widgets/user_detail.dart';
import 'package:insta_clone2/Screens/f_account/account_widgets/user_story.dart';
import 'package:insta_clone2/Screens/f_account/b_Reels/widgets/reel_grid.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:insta_clone2/models/media_item.dart';
import 'package:insta_clone2/models/post_model.dart';
import 'package:insta_clone2/models/reel_model.dart';
import 'package:insta_clone2/Screens/f_account/b_Reels/reel_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  // Convert userFeedPosts to MediaItems for the grid
  List<MediaItem> get userFeedMediaItems {
    return userFeedPosts.map((post) {
      return MediaItem(
        id: post.id.toString(),
        thumbnailPath: post.postImage,
        mediaPath: post.postImage,
        type: MediaType.image,
        likes: post.likes,
        caption: post.subtitle,
        createdAt: post.timeStamp,
        isVerifiled: true,
      );
    }).toList();
  }

  // When user taps any image, show all posts in HomeScreen layout
  void _handleMediaTap(MediaItem media) {
    // Navigate to a new screen that shows all posts in HomeScreen style
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserPostsFullScreen(
          posts: userFeedPosts,
          initialIndex: userFeedPosts.indexWhere((post) => post.id == media.id),
        ),
      ),
    );
  }

  void _handleReelTap(int index) {
    print('Reel tapped at index: $index');
    print('Reel ID: ${userReels[index].id}');
    print('Reel caption: ${userReels[index].caption}');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReelScreen(
          reels: userReels,
          //isUserReel: true,
          initialIndex: index, // Directly use the index
        ),
      ),
    );
  }
  // In your AccountScreen tap handler
  // void _handleReelTap(ReelModel reel) {
  //   final userReelsList = userReels; // Only user's reels
  //   final initialIndex = userReelsList.indexWhere((r) => r.id == reel.id);

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ReelScreen1(
  //         initialIndex: initialIndex >= 0 ? initialIndex : 0,
  //         customReels: userReelsList,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              pinned: true,
              floating: true,
              snap: false,
              title: Row(
                children: [
                  'vicky_345'.text.make(),
                  Icon(Icons.keyboard_arrow_down_outlined),
                ],
              ).onTap(() {}),
              actions: [
                Icon(Icons.add_box_outlined, size: 28).onTap(() {
                  _showShareBottomSheet(context);
                }),
                // IconButton(
                //   icon: Icon(Icons.add_box_outlined, size: 28),
                //   onPressed: () {
                //     _showShareBottomSheet;
                //   },
                // ),
                15.widthBox,
                Icon(Icons.menu, size: 28).onTap(() {
                  Get.to(SettingsScreen());
                }),
                15.widthBox,
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userDetail(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child:
                          'Add you bio.....................................................................................................................'
                              .text
                              .bold
                              .color(Colors.blue)
                              .size(14)
                              .make(),
                    ),
                  ),
                  10.heightBox,
                  ProfileButtonsHead(),
                  15.heightBox,
                  userCard(),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: AnimatedBuilder(
                animation: _tabController,
                builder: (context, _) {
                  return tabs(tabController: _tabController);
                },
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Posts Tab - Use your userFeedPosts data
                  postGrid(
                    mediaItems: userFeedMediaItems,
                    onMediaTap: _handleMediaTap,
                  ),

                  ReelsGrid(reels: userReels, onReelTap: _handleReelTap),

                  // Reels Tab - Empty for now
                  //Center(child: Text('No reels yet')),

                  // Tagged Tab - Empty for now
                  //const Center(child: Text('No tagged posts')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          //color: Colors.white70,
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Minus symbol indicator
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text(
                  'Create',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 240,
                  child: Expanded(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //_buildShareOption(Icons.message, 'Message'),
                        _buildShareOption(
                          Icons.video_collection_outlined,
                          'Reel',
                        ),
                        Divider(),
                        _buildShareOption(Icons.grid_view_outlined, 'Post'),
                        Divider(),
                        _buildShareOption(Icons.add_card_outlined, 'Story'),
                        Divider(),
                        _buildShareOption(
                          Icons.add_road_outlined,
                          'Story highlight',
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.grey[200],
                //       foregroundColor: Colors.black,
                //     ),
                //     child: const Text('Cancel'),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShareOption(IconData icon, String label) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.black),
          const SizedBox(width: 13),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

//This will show all posts in HomeScreen layout
class UserPostsFullScreen extends StatefulWidget {
  final List<PostModel> posts;
  final int initialIndex;

  const UserPostsFullScreen({
    super.key,
    required this.posts,
    this.initialIndex = 0,
  });

  @override
  State<UserPostsFullScreen> createState() => _UserPostsFullScreenState();
}

class _UserPostsFullScreenState extends State<UserPostsFullScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleLike(int index) {
    setState(() {
      // Update the like status for the post
      // You might want to create a copyWith method in PostModel for this
    });
  }

  void _handleBookmark(int index) {
    setState(() {
      // Update bookmark status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Posts', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        controller: _pageController,
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          final post = widget.posts[index];
          return SingleChildScrollView(
            child: PostHome(
              post: post,
              isUserPost: true, // Since it's user's own posts
              onLike: () => _handleLike(index),
              onComment: () {
                // Handle comment
                print('Comment on post');
              },
              onShare: () {
                // Handle share
                print('Share post');
              },
              onSave: () => _handleBookmark(index),
              onFollow: () {
                // Not needed for user's own posts
              },
            ),
          );
        },
      ),
    );
  }
}
