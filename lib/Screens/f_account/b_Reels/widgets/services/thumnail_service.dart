import 'dart:typed_data';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailService {
  static Future<Uint8List?> generateThumbnail(String videoPath) async {
    try {
      print('🔄 Generating thumbnail for: $videoPath');

      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300,
        quality: 75,
        timeMs: 1000,
      );

      if (uint8list == null) {
        print('❌ Thumbnail generation returned null');
      } else {
        print(
          '✅ Thumbnail generated successfully, size: ${uint8list.length} bytes',
        );
      }

      return uint8list;
    } catch (e) {
      print('❌ Error generating thumbnail for $videoPath: $e');
      return null;
    }
  }

  static Future<Uint8List?> generateThumbnailFromNetwork(
    String videoUrl,
  ) async {
    try {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300,
        quality: 75,
        timeMs: 1000,
      );
      return uint8list;
    } catch (e) {
      print('Error generating thumbnail from network: $e');
      return null;
    }
  }
}
