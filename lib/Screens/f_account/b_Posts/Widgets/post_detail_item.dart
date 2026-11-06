// import 'package:flutter/material.dart';
// import 'package:insta_clone2/models/media_item.dart';

// class PostDetailItem extends StatefulWidget {
//   final MediaItem media; //data from account screen.dart
//   final int postIndex;
//   final int totalPosts;

//   const PostDetailItem({
//     super.key,
//     required this.media,
//     required this.postIndex,
//     required this.totalPosts,
//   });

//   @override
//   State<PostDetailItem> createState() => _PostDetailItemState();
// }

// class _PostDetailItemState extends State<PostDetailItem> {
//   double _scale = 1.0;
//   double _previousScale = 1.0;
//   bool _isLiked = false;
//   int _likeCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     _likeCount = widget.media.likes ?? 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onDoubleTap: _toggleLike,
//       onScaleStart: (details) {
//         _previousScale = _scale;
//       },
//       onScaleUpdate: (details) {
//         setState(() {
//           _scale = (_previousScale * details.scale).clamp(1.0, 3.0);
//         });
//       },
//       onScaleEnd: (details) {
//         _previousScale = _scale;
//         // Auto reset scale after some time
//         Future.delayed(const Duration(seconds: 2), () {
//           if (mounted && _scale != 1.0) {
//             setState(() {
//               _scale = 1.0;
//             });
//           }
//         });
//       },
//       child: Stack(
//         children: [
//           // Zoomable image
//           Transform.scale(
//             scale: _scale,
//             child: Center(
//               child: Image.asset(
//                 widget.media.thumbnailPath, // Use media.thumbnailPath
//                 fit: BoxFit.contain,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     color: Colors.grey[900],
//                     child: const Center(
//                       child: Icon(Icons.error, color: Colors.white, size: 50),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),

//           // Bottom overlay with post info
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [Colors.black.withOpacity(0.8), Colors.transparent],
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // User info
//                   Row(
//                     children: [
//                       const CircleAvatar(
//                         radius: 20,
//                         backgroundColor: Colors.grey,
//                         child: Icon(Icons.person, color: Colors.white),
//                       ),
//                       const SizedBox(width: 12),
//                       const Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'username',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               'Location • Time ago',
//                               style: TextStyle(color: Colors.white54),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // IconButton(
//                       //   icon: const Icon(Icons.more_vert, color: Colors.white),
//                       //   onPressed: _showPostOptions,
//                       // ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Caption - Use actual caption from media
//                   Text(
//                     widget.media.caption ?? 'No caption',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   const SizedBox(height: 8),

//                   // Music/audio for reels-like posts
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.music_note,
//                         color: Colors.white,
//                         size: 16,
//                       ),
//                       const SizedBox(width: 8),
//                       const Text(
//                         'Original Audio • username',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),

//                   // Action buttons (Don't delete it)
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   //   children: [
//                   //     _buildActionButton(
//                   //       _isLiked ? Icons.favorite : Icons.favorite_border,
//                   //       _likeCount.toString(),
//                   //     ),
//                   //     _buildActionButton(Icons.chat_bubble_outline, '245'),
//                   //     _buildActionButton(Icons.send, 'Share'),
//                   //     _buildActionButton(Icons.bookmark_border, 'Save'),
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ),
//           ),

//           // Right side action buttons (Instagram style)
//           Positioned(
//             right: 16,
//             bottom: 150,
//             child: Column(
//               children: [
//                 _buildVerticalActionButton(
//                   _isLiked ? Icons.favorite : Icons.favorite_border,
//                   _likeCount.toString(),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildVerticalActionButton(Icons.chat_bubble_outline, '245'),
//                 const SizedBox(height: 16),
//                 _buildVerticalActionButton(Icons.send, 'Share'),
//                 const SizedBox(height: 16),
//                 _buildVerticalActionButton(Icons.bookmark_border, 'Save'),
//                 const SizedBox(height: 16),
//                 _buildVerticalActionButton(Icons.music_note, ''),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   //Don't delete it
//   Widget _buildActionButton(IconData icon, String text) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white, size: 28),
//         const SizedBox(height: 4),
//         Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
//       ],
//     );
//   }

//   Widget _buildVerticalActionButton(IconData icon, String text) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white, size: 28),
//         if (text.isNotEmpty) ...[
//           const SizedBox(height: 4),
//           Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
//         ],
//       ],
//     );
//   }

//   void _toggleLike() {
//     setState(() {
//       _isLiked = !_isLiked;
//       if (_isLiked) {
//         _likeCount++;
//       } else {
//         _likeCount--;
//       }
//     });
//     // You can add heart animation here
//   }

//   void _showPostOptions() {
//     // Show post-specific options
//   }
// }
