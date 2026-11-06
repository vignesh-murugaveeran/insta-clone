import 'package:flutter/material.dart';
import 'package:insta_clone2/Screens/f_account/b_Reels/widgets/reel_grid_item.dart';
import 'package:insta_clone2/models/reel_model.dart';

class ReelsGrid extends StatelessWidget {
  final List<ReelModel> reels;
  final Function(int index) onReelTap; // Change to accept index

  const ReelsGrid({super.key, required this.reels, required this.onReelTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(1),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 9 / 16,
      ),
      itemCount: reels.length,
      itemBuilder: (context, index) {
        final reel = reels[index];
        return ReelGridItem(
          reel: reel,
          onTap: () => onReelTap(index), // Pass index instead of reel
        );
      },
    );
  }
}
