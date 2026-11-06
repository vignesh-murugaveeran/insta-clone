class ReelModel {
  final String id;
  final String videoUrl;
  final String thumbnail;
  final String caption;
  final String userName;
  final String userImage;
  final String userId;
  final int likes;
  final int views;
  final int comments;
  final int shares;
  final DateTime timestamp;
  final bool isLiked;
  final bool isBookmarked;
  final bool isPublic; // true for public reels, false for user reels

  const ReelModel({
    required this.id,
    required this.videoUrl,
    required this.thumbnail,
    required this.caption,
    required this.userName,
    required this.userImage,
    required this.userId,
    this.likes = 0,
    this.views = 0,
    this.comments = 0,
    this.shares = 0,
    required this.timestamp,
    this.isLiked = false,
    this.isBookmarked = false,
    this.isPublic = true,
  });

  ReelModel copyWith({
    String? id,
    String? videoUrl,
    String? thumbnail,
    String? caption,
    String? userName,
    String? userImage,
    String? userId,
    int? likes,
    int? views,
    int? comments,
    int? shares,
    DateTime? timestamp,
    bool? isLiked,
    bool? isBookmarked,
    bool? isPublic,
  }) {
    return ReelModel(
      id: id ?? this.id,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnail: thumbnail ?? this.thumbnail,
      caption: caption ?? this.caption,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      userId: userId ?? this.userId,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      timestamp: timestamp ?? this.timestamp,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isPublic: isPublic ?? this.isPublic,
    );
  }
}
