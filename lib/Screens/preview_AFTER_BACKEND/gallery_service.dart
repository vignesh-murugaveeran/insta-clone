// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:video_player/video_player.dart';

// class GalleryService {
//   static final ImagePicker _picker = ImagePicker();

//   // Check and request gallery permissions
//   static Future<bool> _checkGalleryPermission() async {
//     if (Platform.isAndroid) {
//       // For Android, use photos permission
//       final status = await Permission.photos.status;
//       if (!status.isGranted) {
//         final result = await Permission.photos.request();
//         return result.isGranted;
//       }
//       return true;
//     } else if (Platform.isIOS) {
//       // For iOS, use photos permission
//       final status = await Permission.photos.status;
//       if (!status.isGranted) {
//         final result = await Permission.photos.request();
//         return result.isGranted;
//       }
//       return true;
//     }
//     return true;
//   }

//   // Check and request camera permissions
//   static Future<bool> _checkCameraPermission() async {
//     final status = await Permission.camera.status;
//     if (!status.isGranted) {
//       final result = await Permission.camera.request();
//       return result.isGranted;
//     }
//     return true;
//   }

//   // Check and request storage permissions (for Android)
//   static Future<bool> _checkStoragePermission() async {
//     if (Platform.isAndroid) {
//       final status = await Permission.storage.status;
//       if (!status.isGranted) {
//         final result = await Permission.storage.request();
//         return result.isGranted;
//       }
//     }
//     return true;
//   }

//   // Pick single image from gallery
//   static Future<File?> pickImageFromGallery() async {
//     try {
//       final hasPermission = await _checkGalleryPermission();
//       if (!hasPermission) {
//         throw Exception('Gallery permission denied');
//       }

//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1920,
//         maxHeight: 1080,
//         imageQuality: 85,
//       );

//       if (image != null) {
//         return File(image.path);
//       }
//       return null;
//     } catch (e) {
//       print('Error picking image: $e');
//       rethrow;
//     }
//   }

//   // Pick multiple images from gallery
//   static Future<List<File>> pickMultipleImagesFromGallery() async {
//     try {
//       final hasPermission = await _checkGalleryPermission();
//       if (!hasPermission) {
//         throw Exception('Gallery permission denied');
//       }

//       final List<XFile> images = await _picker.pickMultiImage(
//         maxWidth: 1920,
//         maxHeight: 1080,
//         imageQuality: 85,
//       );

//       return images.map((xFile) => File(xFile.path)).toList();
//     } catch (e) {
//       print('Error picking multiple images: $e');
//       rethrow;
//     }
//   }

//   // Pick video from gallery
//   static Future<File?> pickVideoFromGallery() async {
//     try {
//       final hasPermission = await _checkGalleryPermission();
//       if (!hasPermission) {
//         throw Exception('Gallery permission denied');
//       }

//       final XFile? video = await _picker.pickVideo(
//         source: ImageSource.gallery,
//         maxDuration: const Duration(minutes: 10),
//       );

//       if (video != null) {
//         return File(video.path);
//       }
//       return null;
//     } catch (e) {
//       print('Error picking video: $e');
//       rethrow;
//     }
//   }

//   // Pick image or video from camera
//   static Future<File?> pickFromCamera({bool isVideo = false}) async {
//     try {
//       final hasPermission = await _checkCameraPermission();
//       if (!hasPermission) {
//         throw Exception('Camera permission denied');
//       }

//       if (isVideo) {
//         final XFile? video = await _picker.pickVideo(
//           source: ImageSource.camera,
//           maxDuration: const Duration(minutes: 5),
//         );
//         return video != null ? File(video.path) : null;
//       } else {
//         final XFile? image = await _picker.pickImage(
//           source: ImageSource.camera,
//           maxWidth: 1920,
//           maxHeight: 1080,
//           imageQuality: 90,
//         );
//         return image != null ? File(image.path) : null;
//       }
//     } catch (e) {
//       print('Error from camera: $e');
//       rethrow;
//     }
//   }

//   // Pick both images and videos from gallery
//   static Future<List<File>> pickMediaFromGallery() async {
//     try {
//       final hasPermission = await _checkGalleryPermission();
//       if (!hasPermission) {
//         throw Exception('Gallery permission denied');
//       }

//       final List<XFile>? media = await _picker.pickMedia(
//         maxWidth: 1920,
//         maxHeight: 1080,
//         imageQuality: 85,
//       );

//       if (media != null && media.isNotEmpty) {
//         return media.map((xFile) => File(xFile.path)).toList();
//       }
//       return [];
//     } catch (e) {
//       print('Error picking media: $e');
//       rethrow;
//     }
//   }

//   // Get file type (image or video)
//   static String getFileType(File file) {
//     final path = file.path.toLowerCase();
//     if (path.endsWith('.jpg') || 
//         path.endsWith('.jpeg') || 
//         path.endsWith('.png') || 
//         path.endsWith('.gif') ||
//         path.endsWith('.webp')) {
//       return 'image';
//     } else if (path.endsWith('.mp4') || 
//                path.endsWith('.mov') || 
//                path.endsWith('.avi') || 
//                path.endsWith('.mkv') ||
//                path.endsWith('.wmv')) {
//       return 'video';
//     }
//     return 'unknown';
//   }

//   // Get file size in readable format
//   static String getFileSize(File file) {
//     final sizeInBytes = file.lengthSync();
//     if (sizeInBytes < 1024) {
//       return '$sizeInBytes B';
//     } else if (sizeInBytes < 1048576) {
//       return '${(sizeInBytes / 1024).toStringAsFixed(1)} KB';
//     } else {
//       return '${(sizeInBytes / 1048576).toStringAsFixed(1)} MB';
//     }
//   }

//   // Check if file is an image
//   static bool isImageFile(File file) {
//     return getFileType(file) == 'image';
//   }

//   // Check if file is a video
//   static bool isVideoFile(File file) {
//     return getFileType(file) == 'video';
//   }

//   // Get video duration (requires video_player package)
//   static Future<Duration?> getVideoDuration(String videoPath) async {
//     try {
//       final controller = VideoPlayerController.file(File(videoPath));
//       await controller.initialize();
//       final duration = controller.value.duration;
//       controller.dispose();
//       return duration;
//     } catch (e) {
//       print('Error getting video duration: $e');
//       return null;
//     }
//   }

//   // Get video duration in readable format
//   static Future<String> getVideoDurationFormatted(String videoPath) async {
//     final duration = await getVideoDuration(videoPath);
//     if (duration != null) {
//       final minutes = duration.inMinutes;
//       final seconds = duration.inSeconds.remainder(60);
//       return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//     }
//     return '00:00';
//   }

//   // Validate file size (useful for upload limits)
//   static bool isValidFileSize(File file, {double maxSizeInMB = 100}) {
//     final sizeInBytes = file.lengthSync();
//     final maxSizeInBytes = maxSizeInMB * 1024 * 1024;
//     return sizeInBytes <= maxSizeInBytes;
//   }

//   // Get image dimensions
//   static Future<Size?> getImageDimensions(File imageFile) async {
//     try {
//       final image = Image.file(imageFile);
//       final completer = Completer<Size>();
//       image.image.resolve(const ImageConfiguration()).addListener(
//         ImageStreamListener((ImageInfo info, bool _) {
//           completer.complete(Size(
//             info.image.width.toDouble(),
//             info.image.height.toDouble(),
//           ));
//         }),
//       );
//       return await completer.future;
//     } catch (e) {
//       print('Error getting image dimensions: $e');
//       return null;
//     }
//   }

//   // Compress image (basic implementation)
//   static Future<File?> compressImage(File imageFile, {int quality = 85}) async {
//     try {
//       // For actual compression, you might want to use flutter_image_compress package
//       // This is a basic implementation that returns the original file
//       // You can implement actual compression here
//       return imageFile;
//     } catch (e) {
//       print('Error compressing image: $e');
//       return null;
//     }
//   }

//   // Show permission denied dialog
//   static void showPermissionDeniedDialog(BuildContext context, String permissionType) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Permission Required'),
//         content: Text('$permissionType permission is required to access your media. Please enable it in your device settings.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => openAppSettings(),
//             child: const Text('Open Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Clean up temporary files (useful for camera captures)
//   static void cleanupTempFiles(List<File> files) {
//     for (final file in files) {
//       try {
//         if (file.existsSync()) {
//           file.deleteSync();
//         }
//       } catch (e) {
//         print('Error deleting file: $e');
//       }
//     }
//   }
// }