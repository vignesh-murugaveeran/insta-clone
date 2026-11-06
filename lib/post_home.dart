import 'package:flutter/material.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:insta_clone2/consts/styles.dart';
import 'package:insta_clone2/domain/utils.dart';
import 'package:insta_clone2/models/post_model.dart';
import 'package:velocity_x/velocity_x.dart';

//Common for home and user post
class PostHome extends StatelessWidget {
  final PostModel post;
  final bool isUserPost;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final VoidCallback? onFollow;

  const PostHome({
    super.key,
    required this.post,
    this.isUserPost = false,
    this.onLike,
    this.onComment,
    this.onSave,
    this.onShare,
    this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  post.userImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              10.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: vTextStyle15(
                        fontFamily: secondary,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Text(
                        post.subtitle,
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              //Follow Button
              if (!isUserPost) ...[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onFollow,
                  child: Text('Follow', style: TextStyle(fontSize: 14)),
                ),
                8.widthBox,
              ],
              Icon(Icons.more_vert, size: 20).onTap(() {
                _showPostOptions(context);
              }),
            ],
          ),
        ),
        //Post Image
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.width,
          child: Image.asset(post.postImage, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              //Like button
              _buildActionButton(
                icon: post.isLiked
                    ? Icons.favorite
                    : Icons.favorite_outline_rounded,
                iconColor: post.isLiked ? Colors.red : null,
                count: post.likes.toString(),
                onTap: onLike,
              ),
              10.widthBox,
              _buildActionButton(
                icon: icChat,
                count: post.comments.toString(),
                onTap: onComment,
              ),
              10.widthBox,
              _buildActionButton(
                icon: icReShare,
                count: post.shares.toString(),
                onTap: onShare,
              ),
              10.widthBox,
              _buildActionButton(icon: icSend, count: '', onTap: () {}),
              const Spacer(),
              //Save Button
              IconButton(
                icon: Icon(
                  post.isBookMarked ? Icons.bookmark : Icons.bookmark_outline,
                  size: 24,
                  color: post.isBookMarked ? Colors.black : null,
                ),
                onPressed: onSave,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required dynamic icon,
    Color? iconColor,
    VoidCallback? onTap,
    required String count,
  }) {
    return Row(
      children: [
        if (icon is IconData)
          Icon(icon, size: 24, color: iconColor).onTap(onTap)
        else if (icon is String)
          Image.asset(icon, width: 24, color: iconColor).onTap(onTap),
        if (count.isNotEmpty) ...[
          4.widthBox,
          Text(count, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        ],
      ],
    );
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: false,
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 17),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.flag_outlined),
                title: Text('Report'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Copy link...'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.share_outlined),
                title: Text('Share to...'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              if (isUserPost) ...[
                const Divider(),
                ListTile(
                  leading: Icon(Icons.edit_outlined),
                  title: Text('Edit Post'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Delete'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
