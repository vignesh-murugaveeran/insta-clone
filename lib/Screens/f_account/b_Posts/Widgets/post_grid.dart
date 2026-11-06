import 'package:flutter/material.dart';

// Widget postGrid({imgVid}) {
//   return GridView.builder(
//     physics: const NeverScrollableScrollPhysics(),
//     itemCount: imgVid.length,
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 3,
//       crossAxisSpacing: 2,
//       mainAxisSpacing: 2,
//     ),
//     itemBuilder: (context, index) {
//       return Image.asset(imgVid[index], fit: BoxFit.cover);
//     },
//   );
// }

// widgets/common_post_grid.dart
import 'package:insta_clone2/models/media_item.dart';

Widget postGrid({
  required List<MediaItem> mediaItems, //list model from account_screen.dart
  required Function(MediaItem) onMediaTap, //
}) {
  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemCount: mediaItems.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
    ),
    itemBuilder: (context, index) {
      final media = mediaItems[index];

      return GestureDetector(
        onTap: () => onMediaTap(media),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Main image/video - thumbnail
            Image.asset(
              media.thumbnailPath, //image
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, color: Colors.grey),
                );
              },
            ),

            // Video overlay
            if (media.type == MediaType.video)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 30),
                ),
              ),

            // Multiple images indicator (carousel)
            if (media.type ==
                MediaType.image) // You can add carousel logic here
              const Positioned(
                top: 5,
                right: 5,
                child: Icon(Icons.collections, color: Colors.white, size: 16),
              ),
          ],
        ),
      );
    },
  );
}
