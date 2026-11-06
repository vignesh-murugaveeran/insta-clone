import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone2/Screens/f_account/b_Reels/widgets/user_reel_data.dart';
import 'package:insta_clone2/Screens/c_search/insta_style/search_detail_screen.dart';
import 'package:insta_clone2/Screens/f_account/b_Reels/reel_screen.dart';
import 'package:insta_clone2/models/reel_model.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  // Mix all reels together in one list
  List<ReelModel> get mixedReels {
    List<ReelModel> mixed = [];

    // Add some user reels
    mixed.addAll(userReels.take(3)); // Take first 3 user reels

    // Add some public/trending reels
    mixed.addAll(publicReels.take(4)); // Take first 4 public reels

    // Add more user reels
    mixed.addAll(userReels.skip(3).take(2)); // Take next 2 user reels

    // Add more public reels
    mixed.addAll(publicReels.skip(4).take(3)); // Take next 3 public reels

    // Shuffle to mix them up (optional)
    // mixed.shuffle();

    return mixed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(),

            // Single Mixed GridView
            Expanded(child: _buildMixedGridView()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.to(() => SearchDetailScreen()),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    12.widthBox,
                    Icon(Icons.search, color: Colors.grey.shade600),
                    8.widthBox,
                    Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMixedGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(1),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 9 / 16, // Instagram reel aspect ratio
      ),
      itemCount: mixedReels.length,
      itemBuilder: (context, index) {
        final reel = mixedReels[index];
        final isUserReel = userReels.contains(reel);

        return _buildReelGridItem(
          reel: reel,
          reels: isUserReel ? userReels : publicReels,
          index: isUserReel
              ? userReels.indexOf(reel)
              : publicReels.indexOf(reel),
          isUserReel: isUserReel,
        );
      },
    );
  }

  Widget _buildReelGridItem({
    required ReelModel reel,
    required List<ReelModel> reels,
    required int index,
    required bool isUserReel,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReelScreen(reels: reels, initialIndex: index),
          ),
        );
      },
      child: Stack(
        children: [
          // Thumbnail Image
          Image.asset(
            reel.thumbnail,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              ),
            ),
          ),

          // Play Icon
          Center(
            child: Icon(
              Icons.play_circle_fill_rounded,
              color: Colors.white.withOpacity(0.9),
              size: 40,
            ),
          ),

          // Views Count
          Positioned(
            bottom: 8,
            left: 8,
            child: Row(
              children: [
                Icon(Icons.play_arrow_rounded, color: Colors.white, size: 16),
                4.widthBox,
                Text(
                  _formatViews(reel.views),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // User Badge (for user reels)
          if (isUserReel)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Trending Badge (for high-view public reels)
          if (!isUserReel && reel.views > 50000)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Trending',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatViews(int views) {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    }
    return views.toString();
  }
}
