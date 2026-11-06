import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:insta_clone2/models/reel_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ReelScreen1 extends StatefulWidget {
  final List<ReelModel> reels;
  final int initialIndex;

  const ReelScreen1({super.key, required this.reels, this.initialIndex = 0});

  @override
  ReelScreen1State createState() => ReelScreen1State();
}

class ReelScreen1State extends State<ReelScreen1> {
  late PageController _pageController;
  late List<VideoPlayerController> _videoControllers;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _initializeVideoControllers();
  }

  void _initializeVideoControllers() {
    _videoControllers = [];

    for (int i = 0; i < widget.reels.length; i++) {
      final controller = VideoPlayerController.asset(widget.reels[i].videoUrl);
      _videoControllers.add(controller);

      controller.initialize().then((_) {
        if (mounted) {
          setState(() {});
          // Auto-play only the current video
          if (i == _currentIndex) {
            _playCurrentVideo();
          }
        }
      });
    }
  }

  void _playCurrentVideo() {
    if (_currentIndex < _videoControllers.length) {
      final currentController = _videoControllers[_currentIndex];
      if (currentController.value.isInitialized &&
          !currentController.value.isPlaying) {
        currentController.play();
        currentController.setLooping(true);
      }
    }
  }

  void _pauseCurrentVideo() {
    if (_currentIndex < _videoControllers.length) {
      final currentController = _videoControllers[_currentIndex];
      if (currentController.value.isInitialized &&
          currentController.value.isPlaying) {
        currentController.pause();
      }
    }
  }

  void _resetCurrentVideo() {
    if (_currentIndex < _videoControllers.length) {
      final currentController = _videoControllers[_currentIndex];
      if (currentController.value.isInitialized) {
        currentController.seekTo(Duration.zero);
      }
    }
  }

  void _togglePlayPause(int index) {
    if (index >= _videoControllers.length) return;

    final controller = _videoControllers[index];
    if (!controller.value.isInitialized) return;

    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
      controller.setLooping(true);
    }
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose all video controllers when screen is disposed
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          // Pause current video
          _pauseCurrentVideo();

          setState(() {
            _currentIndex = index;
          });

          // Reset and play new video
          _resetCurrentVideo();
          _playCurrentVideo();
        },
        itemCount: widget.reels.length,
        itemBuilder: (context, index) {
          return _buildReelItem(widget.reels[index], index);
        },
      ),
    );
  }

  Widget _buildReelItem(ReelModel reel, int index) {
    final videoController = _videoControllers[index];
    final isCurrentReel = index == _currentIndex;
    final isPlaying =
        videoController.value.isInitialized && videoController.value.isPlaying;
    final showPlayIcon = !isPlaying && isCurrentReel;

    return SafeArea(
      child: Stack(
        children: [
          // Video Player
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _togglePlayPause(index);
              },
              child: videoController.value.isInitialized
                  ? Stack(
                      children: [
                        // Video that fills the screen
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.width /
                                  videoController.value.aspectRatio,
                              child: VideoPlayer(videoController),
                            ),
                          ),
                        ),

                        // Play/Pause Overlay
                        if (showPlayIcon)
                          Container(
                            color: Colors.black38,
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  : Container(
                      color: Colors.black,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ),
            ),
          ),

          // Gradient Overlays
          _buildGradientOverlays(),

          // Reel Information
          _buildReelInfo(reel),

          // Action Buttons (Right Side)
          _buildActionButtons(reel, index),

          // Header
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Reels',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientOverlays() {
    return Column(
      children: [
        // Top Gradient
        Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.4), Colors.transparent],
            ),
          ),
        ),
        Spacer(),
        // Bottom Gradient
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReelInfo(ReelModel reel) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[300],
                child: reel.userImage != null
                    ? ClipOval(
                        child: Image.asset(
                          reel.userImage,
                          fit: BoxFit.cover,
                          width: 35,
                          height: 35,
                        ),
                      )
                    : Icon(Icons.person, color: Colors.grey),
              ),
              8.widthBox,
              SizedBox(
                width: 105,
                child: Text(
                  reel.userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              22.widthBox,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Follow',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          12.heightBox,

          // Caption
          Text(
            reel.caption,
            style: TextStyle(color: Colors.white, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          8.heightBox,

          // Music
          Row(
            children: [
              Icon(Icons.music_note_rounded, color: Colors.white, size: 16),
              4.widthBox,
              Text(
                'Original Audio • ${reel.userName}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ReelModel reel, int index) {
    return Positioned(
      bottom: 30,
      right: 16,
      child: Column(
        children: [
          // Like Button
          Column(
            children: [
              IconButton(
                icon: Icon(
                  reel.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: reel.isLiked ? Colors.red : Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  print('Like reel: ${reel.id}');
                },
              ),
              Text(
                _formatCount(reel.likes),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          20.heightBox,

          // Comment Button
          Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  print('Comment on reel: ${reel.id}');
                },
              ),
              Text(
                _formatCount(reel.comments),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          20.heightBox,

          // Share Button
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.send_rounded, color: Colors.white, size: 28),
                onPressed: () {
                  print('Share reel: ${reel.id}');
                },
              ),
              Text(
                'Share',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          20.heightBox,

          // More Button
          IconButton(
            icon: Icon(Icons.more_vert_rounded, color: Colors.white, size: 28),
            onPressed: () {
              _showMoreOptions(reel);
            },
          ),
          20.heightBox,

          // Album Thumbnail
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(reel.thumbnail, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions(ReelModel reel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.flag_outlined, color: Colors.white),
                  title: Text('Report', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    print('Report reel: ${reel.id}');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.link, color: Colors.white),
                  title: Text(
                    'Copy Link',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    print('Copy link for reel: ${reel.id}');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.share_outlined, color: Colors.white),
                  title: Text(
                    'Share to...',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    print('Share reel: ${reel.id}');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bookmark_border, color: Colors.white),
                  title: Text('Save', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    print('Save reel: ${reel.id}');
                  },
                ),
                Container(height: 1, color: Colors.grey[700]),
                ListTile(
                  leading: Icon(
                    Icons.notifications_off_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Turn off notifications for this reel',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    print('Turn off notifications for reel: ${reel.id}');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
