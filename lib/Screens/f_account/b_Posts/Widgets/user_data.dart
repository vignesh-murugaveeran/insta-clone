import 'package:insta_clone2/consts/images.dart';
import 'package:insta_clone2/models/post_model.dart';

List<PostModel> userFeedPosts = [
  PostModel(
    id: 1,
    userName: 'Vicky',
    userImage: img1,
    postImage: img2,
    subtitle: 'My recent vacation! 🏖️',
    likes: 2882,
    comments: 298,
    shares: 82,
    timeStamp: DateTime.now().subtract(Duration(days: 2)),
    isBookMarked: true,
  ),
  PostModel(
    id: 2,
    userName: 'Vicky',
    userImage: img1,
    postImage: img2,
    subtitle: 'Sunset vibes 🌅',
    likes: 8881,
    comments: 228,
    shares: 39,
    timeStamp: DateTime.now().subtract(Duration(days: 5)),
    isBookMarked: false,
  ),
  PostModel(
    id: 3,
    userName: 'Vicky',
    userImage: img1,
    postImage: img2,
    subtitle: 'My recent vacation! 🏖️',
    likes: 228,
    comments: 17,
    shares: 10,
    timeStamp: DateTime.now().subtract(Duration(days: 8)),
    isBookMarked: false,
  ),
];
