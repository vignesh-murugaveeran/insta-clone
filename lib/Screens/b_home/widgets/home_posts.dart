import 'package:flutter/material.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:insta_clone2/consts/list.dart';
import 'package:insta_clone2/consts/styles.dart';
import 'package:insta_clone2/domain/utils.dart';
import 'package:velocity_x/velocity_x.dart';

// Widget homePosts() {
//   return Column(
//     children: List.generate(1, (index) {
//       return SizedBox(
//         child: Column(
//           children: [
//             ListTile(
//               //we can also use the CirleAvatar instead of ClipOval
//               leading: ClipOval(
//                 child: Image.asset(
//                   img2,
//                   height: 45,
//                   width: 45,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               title: Text(
//                 'Vijay Kumar',
//                 style: vTextStyle15(
//                   fontFamily: secondary,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: 'Subtitle here...'.text.size(13).make(),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadiusGeometry.circular(12),
//                       ),
//                     ),
//                     child: 'Follow'.text.make(),
//                     onPressed: () {},
//                   ),
//                   10.widthBox,
//                   Icon(Icons.more_vert).onTap(() {}),
//                 ],
//               ),
//             ),
//             ClipRRect(child: Image.asset(img2)),
//             Container(
//               padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
//               child: Expanded(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(Icons.favorite_border_sharp, size: 30).onTap(() {}),
//                     '1'.text.make(),
//                     7.widthBox,
//                     Image.asset(icChat, width: 30).onTap(() {}),
//                     '1'.text.make(),
//                     7.widthBox,
//                     Image.asset(icReShare, width: 30).onTap(() {}),
//                     '1'.text.make(),
//                     7.widthBox,
//                     Image.asset(icSend, width: 25),
//                     '1'.text.make(),
//                     const Spacer(),
//                     IconButton(
//                       icon: Icon(Icons.bookmark_outline_sharp, size: 30),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }),
//   );
// }
///????????????????????????????????????????New
// Widget homePosts() {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 10),
//     child: Column(
//       children: [
//         ListTile(
//           leading: ClipOval(
//             child: Image.asset(img2, height: 45, width: 45, fit: BoxFit.cover),
//           ),
//           title: Text(
//             'Vijay Kumar',
//             style: vTextStyle15(
//               fontFamily: secondary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: 'Subtitle here...'.text.size(13).make(),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               OutlinedButton(
//                 style: OutlinedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: 'Follow'.text.make(),
//               ),
//               10.widthBox,
//               Icon(Icons.more_vert).onTap(() {}),
//             ],
//           ),
//         ),
//         Image.asset(img2, fit: BoxFit.cover),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: Row(
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.favorite_border_sharp, size: 30).onTap(() {}),
//                   5.widthBox,
//                   '1'.text.make(),
//                 ],
//               ),
//               15.widthBox,
//               Row(
//                 children: [
//                   Image.asset(icChat, width: 30).onTap(() {}),
//                   5.widthBox,
//                   '1'.text.make(),
//                 ],
//               ),
//               15.widthBox,
//               Row(
//                 children: [
//                   Image.asset(icReShare, width: 30).onTap(() {}),
//                   5.widthBox,
//                   '1'.text.make(),
//                 ],
//               ),
//               15.widthBox,
//               Row(
//                 children: [
//                   Image.asset(icSend, width: 25),
//                   5.widthBox,
//                   '1'.text.make(),
//                 ],
//               ),
//               const Spacer(),
//               IconButton(
//                 icon: Icon(Icons.bookmark_outline_sharp, size: 30),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

class HomePost extends StatelessWidget {
  final int index;

  const HomePost({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var public1 = public['publicNames']![index];
    var public2 = public['publicPosts']![index];
    var public3 = public['publicSubtitle']![index];
    var public4 = public['publicImages']![index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // Space between posts
      child: Column(
        mainAxisSize: MainAxisSize.min, // Important: prevents infinite height
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    public2,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        public1,
                        style: vTextStyle15(
                          fontFamily: secondary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                          public3,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Follow', style: TextStyle(fontSize: 14)),
                ),
                const SizedBox(width: 8),
                Icon(Icons.more_vert, size: 20),
              ],
            ),
          ),

          // Image - Fixed height for predictable layout
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.width, // Square aspect ratio
            child: Image.asset(public4, fit: BoxFit.cover),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                _buildActionButton(Icons.favorite_border, '1'),
                const SizedBox(width: 16),
                _buildActionButton(icChat, '1'), // Assuming icChat is icon path
                const SizedBox(width: 16),
                _buildActionButton(icReShare, '1'),
                const SizedBox(width: 16),
                _buildActionButton(icSend, '1'),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.bookmark_outline, size: 24),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(dynamic icon, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon is IconData)
          Icon(icon, size: 24)
        else if (icon is String)
          Image.asset(icon, width: 24),
        const SizedBox(width: 4),
        Text(count, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      ],
    );
  }
}
