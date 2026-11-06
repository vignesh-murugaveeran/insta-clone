import 'package:insta_clone2/consts/images.dart';
import 'package:insta_clone2/models/post_model.dart';

List<PostModel> homeFeedPosts = [
  PostModel(
    userName: 'Vijay Kumar',
    userImage: img1,
    postImage: img2,
    subtitle: 'Travel enthusiast • Exploring the world 🌍',
    likes: 323,
    comments: 272,
    shares: 112,
    timeStamp: DateTime.now().subtract(Duration(hours: 2)),
  ),
  PostModel(
    userName: 'John Doe',
    userImage: img1,
    postImage: img1,
    subtitle: 'Photographer • Capturing moments 📸',
    likes: 8377,
    comments: 2822,
    shares: 2222,
    timeStamp: DateTime.now().subtract(Duration(hours: 8)),
  ),
  PostModel(
    userName: 'Jane Smith',
    userImage: img2,
    postImage: img2,
    subtitle: 'Food blogger • Food is life 🍕',
    likes: 323,
    comments: 272,
    shares: 112,
    timeStamp: DateTime.now().subtract(Duration(hours: 5)),
  ),
];
