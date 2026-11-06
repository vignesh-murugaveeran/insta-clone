import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone2/Screens/d_userPost/userPostScreen/reel_creation_screen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  int _currentIndex = 0;
  final List<Widget> _postTypes = [
    _PostTypeScreen(type: 'Post', icon: Icons.grid_on),
    _PostTypeScreen(type: 'Story', icon: Icons.play_arrow),
    _PostTypeScreen(type: 'Reel', icon: Icons.video_collection),
    //_PostTypeScreen(type: 'Live', icon: Icons.live_tv),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'New Post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle next action
            },
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            height: 50,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.2),
              ),
            ),
            child: Row(
              children: [
                _buildPostTypeTab('Reel', 2, Icons.video_collection),
                _buildPostTypeTab('Post', 0, Icons.grid_on),
                _buildPostTypeTab('Story', 1, Icons.play_arrow),
                //_buildPostTypeTab('Live', 3, Icons.live_tv),
              ],
            ),
          ),
          // Content Area
          Expanded(child: _postTypes[_currentIndex]),
        ],
      ),
    );
  }

  Widget _buildPostTypeTab(String title, int index, IconData icon) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 1,
                  width: 30,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostTypeScreen extends StatelessWidget {
  final String type;
  final IconData icon;

  const _PostTypeScreen({required this.type, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 80),
          const SizedBox(height: 20),
          Text(
            'Share $type',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _getDescription(type),
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Container(
            width: 200,
            height: 45,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: () {
                _handlePostTypeAction(type, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                _getButtonText(type),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getDescription(String type) {
    switch (type) {
      case 'Reel':
        return 'Create and share short videos';
      case 'Post':
        return 'Share a photo or video to your feed';
      case 'Story':
        return 'Share a photo or video that disappears after 24 hours';
      // case 'Live':
      //   return 'Broadcast live video to your followers';
      default:
        return '';
    }
  }

  String _getButtonText(String type) {
    switch (type) {
      case 'Post':
        return 'Select from Gallery';
      case 'Story':
        return 'Create Story';
      case 'Reel':
        return 'Create Reel';
      // case 'Live':
      //   return 'Go Live';
      default:
        return 'Create';
    }
  }

  void _handlePostTypeAction(String type, BuildContext context) {
    switch (type) {
      case 'Post':
        // Navigate to gallery selection
        break;
      case 'Story':
        // Navigate to story creation
        break;
      case 'Reel':
        Get.to(() => const ReelCreationScreen());
        break;
      // case 'Live':
      //   // Navigate to live streaming
      //   break;
    }
  }
}

//**************************************New from backend */
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:io';
// import 'package:insta_clone2/controllers/post_controller.dart';
// import 'package:insta_clone2/services/gallery_service.dart';
// import 'package:insta_clone2/widgets/image_preview.dart';
// import 'package:insta_clone2/widgets/video_preview.dart';
// import 'package:insta_clone2/Screens/d_userPost/userPostScreen/reel_creation_screen.dart';

// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({super.key});

//   @override
//   State<AddPostScreen> createState() => _AddPostScreenState();
// }

// class _AddPostScreenState extends State<AddPostScreen> {
//   int _currentIndex = 0;
//   List<File> _selectedMedia = [];
//   bool _isLoading = false;
//   final TextEditingController _captionController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _tagsController = TextEditingController();

//   final PostController _postController = Get.find<PostController>();

//   final List<Widget> _postTypes = [
//     _PostTypeScreen(type: 'Post', icon: Icons.grid_on),
//     _PostTypeScreen(type: 'Story', icon: Icons.play_arrow),
//     _PostTypeScreen(type: 'Reel', icon: Icons.video_collection),
//     _PostTypeScreen(type: 'Live', icon: Icons.live_tv),
//   ];

//   void _pickImage() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final File? image = await GalleryService.pickImageFromGallery();
//       if (image != null) {
//         setState(() {
//           _selectedMedia.add(image);
//         });
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to pick image: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _pickMultipleImages() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final List<File> images =
//           await GalleryService.pickMultipleImagesFromGallery();
//       if (images.isNotEmpty) {
//         setState(() {
//           _selectedMedia.addAll(images);
//         });
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to pick images: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _pickVideo() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final File? video = await GalleryService.pickVideoFromGallery();
//       if (video != null) {
//         setState(() {
//           _selectedMedia.add(video);
//         });
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to pick video: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _removeMedia(int index) {
//     setState(() {
//       _selectedMedia.removeAt(index);
//     });
//   }

//   void _sharePost() async {
//     if (_selectedMedia.isEmpty) {
//       Get.snackbar(
//         'Error',
//         'Please select at least one media file',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//       return;
//     }

//     final tags = _tagsController.text
//         .split(',')
//         .map((tag) => tag.trim())
//         .where((tag) => tag.isNotEmpty)
//         .toList();

//     await _postController.createPost(
//       mediaFiles: _selectedMedia,
//       caption: _captionController.text,
//       location: _locationController.text,
//       tags: tags,
//     );
//   }

//   bool _isImageFile(File file) {
//     final path = file.path.toLowerCase();
//     return path.endsWith('.jpg') ||
//         path.endsWith('.jpeg') ||
//         path.endsWith('.png') ||
//         path.endsWith('.gif');
//   }

//   bool _isVideoFile(File file) {
//     final path = file.path.toLowerCase();
//     return path.endsWith('.mp4') ||
//         path.endsWith('.mov') ||
//         path.endsWith('.avi') ||
//         path.endsWith('.mkv');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white, size: 30),
//           onPressed: () => Get.back(),
//         ),
//         title: const Text(
//           'New Post',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           if (_selectedMedia.isNotEmpty)
//             TextButton(
//               onPressed: _sharePost,
//               child: Obx(() {
//                 return _postController.isLoading.value
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Colors.blue,
//                         ),
//                       )
//                     : const Text(
//                         'Share',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       );
//               }),
//             ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Tab Bar
//           Container(
//             height: 50,
//             decoration: const BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(color: Colors.grey, width: 0.2),
//               ),
//             ),
//             child: Row(
//               children: [
//                 _buildPostTypeTab('Post', 0, Icons.grid_on),
//                 _buildPostTypeTab('Story', 1, Icons.play_arrow),
//                 _buildPostTypeTab('Reel', 2, Icons.video_collection),
//                 _buildPostTypeTab('Live', 3, Icons.live_tv),
//               ],
//             ),
//           ),

//           // Selected Media Preview
//           if (_selectedMedia.isNotEmpty)
//             Container(
//               height: 120,
//               padding: const EdgeInsets.all(12),
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _selectedMedia.length,
//                 itemBuilder: (context, index) {
//                   final media = _selectedMedia[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: _isImageFile(media)
//                         ? ImagePreview(
//                             imagePath: media.path,
//                             onRemove: () => _removeMedia(index),
//                             width: 100,
//                             height: 100,
//                           )
//                         : VideoPreview(
//                             videoPath: media.path,
//                             onRemove: () => _removeMedia(index),
//                             width: 100,
//                             height: 100,
//                           ),
//                   );
//                 },
//               ),
//             ),

//           // Caption and Details Input
//           if (_selectedMedia.isNotEmpty)
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _captionController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: const InputDecoration(
//                       hintText: 'Write a caption...',
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: InputBorder.none,
//                     ),
//                     maxLines: 3,
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: _locationController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: const InputDecoration(
//                       hintText: 'Add location',
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: InputBorder.none,
//                       prefixIcon: Icon(Icons.location_on, color: Colors.grey),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: _tagsController,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: const InputDecoration(
//                       hintText: 'Add tags (separated by commas)',
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: InputBorder.none,
//                       prefixIcon: Icon(Icons.tag, color: Colors.grey),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//           // Content Area
//           Expanded(
//             child: Stack(
//               children: [
//                 _postTypes[_currentIndex],
//                 if (_isLoading)
//                   Container(
//                     color: Colors.black.withOpacity(0.7),
//                     child: const Center(
//                       child: CircularProgressIndicator(color: Colors.white),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPostTypeTab(String title, int index, IconData icon) {
//     final isSelected = _currentIndex == index;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         child: Container(
//           color: Colors.transparent,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 color: isSelected ? Colors.white : Colors.grey,
//                 size: 20,
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.grey,
//                   fontSize: 12,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 ),
//               ),
//               if (isSelected)
//                 Container(
//                   margin: const EdgeInsets.only(top: 4),
//                   height: 1,
//                   width: 30,
//                   color: Colors.white,
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _PostTypeScreen extends StatelessWidget {
//   final String type;
//   final IconData icon;

//   const _PostTypeScreen({required this.type, required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     final state = context.findAncestorStateOfType<_AddPostScreenState>()!;

//     return Container(
//       color: Colors.black,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: Colors.white, size: 80),
//           const SizedBox(height: 20),
//           Text(
//             'Share $type',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             _getDescription(type),
//             style: const TextStyle(color: Colors.grey, fontSize: 14),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 30),

//           // Action Buttons based on post type
//           if (type == 'Post') ..._buildPostButtons(state),
//           if (type == 'Story') ..._buildStoryButtons(state),
//           if (type == 'Reel') ..._buildReelButtons(state),
//           if (type == 'Live') ..._buildLiveButtons(),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildPostButtons(_AddPostScreenState state) {
//     return [
//       _buildActionButton(
//         'Select from Gallery',
//         Icons.photo_library,
//         () => state._pickImage(),
//       ),
//       const SizedBox(height: 16),
//       _buildActionButton(
//         'Select Multiple Photos',
//         Icons.collections,
//         () => state._pickMultipleImages(),
//       ),
//       const SizedBox(height: 16),
//       _buildActionButton(
//         'Take Photo',
//         Icons.camera_alt,
//         () => _handleCameraAction(false),
//       ),
//     ];
//   }

//   List<Widget> _buildStoryButtons(_AddPostScreenState state) {
//     return [
//       _buildActionButton(
//         'Create Story',
//         Icons.photo_library,
//         () => state._pickImage(),
//       ),
//       const SizedBox(height: 16),
//       _buildActionButton(
//         'Take Photo/Video',
//         Icons.camera_alt,
//         () => _handleCameraAction(true),
//       ),
//     ];
//   }

//   List<Widget> _buildReelButtons(_AddPostScreenState state) {
//     return [
//       _buildActionButton(
//         'Upload from Gallery',
//         Icons.video_library,
//         () => state._pickVideo(),
//       ),
//       const SizedBox(height: 16),
//       _buildActionButton(
//         'Create Reel',
//         Icons.videocam,
//         () => Get.to(() => const ReelCreationScreen()),
//       ),
//     ];
//   }

//   List<Widget> _buildLiveButtons() {
//     return [
//       _buildActionButton('Go Live', Icons.live_tv, () {
//         Get.snackbar(
//           'Live',
//           'Live streaming coming soon!',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }),
//     ];
//   }

//   Widget _buildActionButton(
//     String text,
//     IconData icon,
//     VoidCallback onPressed,
//   ) {
//     return Container(
//       width: 250,
//       height: 50,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Colors.purple, Colors.orange],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: Colors.white, size: 20),
//             const SizedBox(width: 8),
//             Text(
//               text,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _handleCameraAction(bool forStory) async {
//     try {
//       final File? media = await GalleryService.pickFromCamera(
//         isVideo: forStory,
//       );
//       if (media != null) {
//         final state = context.findAncestorStateOfType<_AddPostScreenState>()!;
//         state.setState(() {
//           state._selectedMedia.add(media);
//         });
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Camera error: ${e.toString()}',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }

//   String _getDescription(String type) {
//     switch (type) {
//       case 'Post':
//         return 'Share photos or videos to your feed';
//       case 'Story':
//         return 'Share photos or videos that disappear after 24 hours';
//       case 'Reel':
//         return 'Create and share short videos';
//       case 'Live':
//         return 'Broadcast live video to your followers';
//       default:
//         return '';
//     }
//   }
// }
