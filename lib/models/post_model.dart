class PostModel {
  final int id;
  final String userName;
  final String userImage;
  final String postImage;
  final String subtitle;
  final bool isLiked;
  final int likes;
  final int comments;
  final int shares;
  final DateTime timeStamp;
  final bool isBookMarked;

  const PostModel({
    this.id = 0,
    required this.userName,
    required this.userImage,
    required this.postImage,
    required this.subtitle,
    this.isLiked = false,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    required this.timeStamp,
    this.isBookMarked = false,
  });

  //copywith method for immutable(can't be changed once created)
  PostModel copyWith({
    String? userName,
    String? userImage,
    String? postImage,
    String? subtitle,
    bool? isLiked,
    int? likes,
    int? comments,
    int? shares,
    DateTime? timeStamp,
    bool? isBookMarked,
  }) {
    return PostModel(
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      postImage: postImage ?? this.postImage,
      subtitle: subtitle ?? this.subtitle,
      isLiked: isLiked ?? this.isLiked,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      timeStamp: timeStamp ?? this.timeStamp,
      isBookMarked: isBookMarked ?? this.isBookMarked,
    );
  }
}
