// models/media_item.dart
class MediaItem {
  final String id;
  final String thumbnailPath;
  final String mediaPath;
  final MediaType type;
  final int? likes;
  final int? views;
  final String? caption;
  final DateTime createdAt;
  final bool isVerifiled;

  MediaItem({
    required this.id,
    required this.thumbnailPath,
    required this.mediaPath,
    required this.type,
    this.likes,
    this.views,
    this.caption,
    required this.createdAt,
    required this.isVerifiled,
  });
}

enum MediaType { image, video }
