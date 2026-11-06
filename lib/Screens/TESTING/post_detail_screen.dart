// import 'package:flutter/material.dart';
// import 'package:insta_clone2/Screens/f_account/Posts/Widgets/post_detail_item.dart';
// import 'package:insta_clone2/models/media_item.dart'; // Add this import

// class PostDetailScreen extends StatefulWidget {
//   final List<MediaItem> mediaItems; //media data from account screen.dart
//   final int initialIndex;

//   const PostDetailScreen({
//     super.key,
//     required this.mediaItems,
//     this.initialIndex = 0,
//   });

//   @override
//   State<PostDetailScreen> createState() => _PostDetailScreenState();
// }

// class _PostDetailScreenState extends State<PostDetailScreen> {
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.initialIndex);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Main content - Vertical PageView
//             PageView.builder(
//               controller: _pageController,
//               scrollDirection: Axis.vertical,
//               itemCount: widget.mediaItems.length,
//               itemBuilder: (context, index) {
//                 final media = widget.mediaItems[index];
//                 return PostDetailItem(
//                   media: media, // Pass the MediaItem instead of just imagePath
//                   postIndex: index,
//                   totalPosts: widget.mediaItems.length,
//                 );
//               },
//             ),

//             // Header with back button and title
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: 60,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Colors.black.withOpacity(0.7), Colors.transparent],
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     // Back button
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const SizedBox(width: 8),
//                     // Page indicator
//                     Text(
//                       '${widget.initialIndex + 1}/${widget.mediaItems.length}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Spacer(),
//                     // More options
//                     IconButton(
//                       icon: const Icon(Icons.more_vert, color: Colors.white),
//                       onPressed: _showMoreOptions,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showMoreOptions() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return SafeArea(
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _buildBottomSheetOption(Icons.report, 'Report', Colors.red),
//                 _buildBottomSheetOption(Icons.block, 'Block', Colors.red),
//                 _buildBottomSheetOption(Icons.share, 'Share', Colors.white),
//                 _buildBottomSheetOption(Icons.copy, 'Copy Link', Colors.white),
//                 const SizedBox(height: 8),
//                 Container(
//                   width: double.infinity,
//                   margin: const EdgeInsets.all(16),
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.grey[800],
//                       foregroundColor: Colors.white,
//                     ),
//                     child: const Text('Cancel'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildBottomSheetOption(IconData icon, String text, Color color) {
//     return ListTile(
//       leading: Icon(icon, color: color),
//       title: Text(text, style: TextStyle(color: color)),
//       onTap: () {
//         Navigator.pop(context);
//         // Handle option tap
//       },
//     );
//   }
// }
