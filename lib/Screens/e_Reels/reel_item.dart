import 'package:flutter/material.dart';
import 'package:insta_clone2/consts/images.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

class ReelItem extends StatefulWidget {
  final String videoPath;
  const ReelItem({super.key, required this.videoPath});

  @override
  State<ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath);
    _controller.initialize().then((_) {
      _controller.play();
      //_controller.pause();
      _controller.setLooping(true);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //for Video
        SizedBox.expand(
          child: _controller.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.width + 70,
                    child: VideoPlayer(_controller),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        Positioned(
          right: 20,
          bottom: 55,
          child: Column(
            children: [
              Icon(Icons.favorite_outline, size: 30, color: Colors.white),
              '1'.text.white.size(12).make(),
              12.heightBox,
              Icon(Icons.post_add_outlined, size: 30, color: Colors.white),
              '1'.text.white.size(12).make(),
              12.heightBox,
              Icon(Icons.share, size: 30, color: Colors.white),
              '1'.text.white.size(12).make(),
              12.heightBox,
              Icon(Icons.save_alt_outlined, size: 30, color: Colors.white),
              12.heightBox,
              Icon(Icons.more_vert, size: 30, color: Colors.white),
            ],
          ),
        ),
        Positioned(
          //top: 200,
          left: 20,
          bottom: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(img1, width: 32),
                  ),
                  10.widthBox,
                  'Friend name'.text.white
                      .maxLines(1)
                      .overflow(TextOverflow.ellipsis)
                      .size(17)
                      .make(),
                  27.widthBox,
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: 'Follow'.text.make(),
                  ),
                ],
              ),
              5.heightBox,
              'description about video(Reel)'.text.white
                  .maxLines(1)
                  .overflow(TextOverflow.ellipsis)
                  .size(15)
                  .make(),
              7.heightBox,
            ],
          ),
        ),
      ],
    );
  }
}
