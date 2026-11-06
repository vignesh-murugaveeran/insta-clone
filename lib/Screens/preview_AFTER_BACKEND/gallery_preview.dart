import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GalleryPreview extends StatefulWidget {
  final String mediaPath;
  final VoidCallback onRemove;
  final double width;
  final double height;
  final bool isVideo;
  final String? thumbnailPath;

  const GalleryPreview({
    super.key,
    required this.mediaPath,
    required this.onRemove,
    this.width = 100,
    this.height = 100,
    this.isVideo = false,
    this.thumbnailPath,
  });

  @override
  State<GalleryPreview> createState() => _GalleryPreviewState();
}

class _GalleryPreviewState extends State<GalleryPreview> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    try {
      _videoController = VideoPlayerController.file(File(widget.mediaPath));
      await _videoController.initialize();
      setState(() {
        _isVideoInitialized = true;
      });
    } catch (e) {
      print('Error initializing video: $e');
    }
  }

  void _toggleVideoPlay() {
    if (!_isVideoInitialized) return;

    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        _isPlaying = false;
      } else {
        _videoController.play();
        _isPlaying = true;
      }
    });
  }

  @override
  void dispose() {
    if (widget.isVideo && _isVideoInitialized) {
      _videoController.dispose();
    }
    super.dispose();
  }

  Widget _buildImagePreview() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: FileImage(File(widget.mediaPath)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildVideoPreview() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
      ),
      child: Stack(
        children: [
          // Video player or thumbnail
          if (_isVideoInitialized)
            GestureDetector(
              onTap: _toggleVideoPlay,
              child: VideoPlayer(_videoController),
            )
          else if (widget.thumbnailPath != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(File(widget.thumbnailPath!)),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              color: Colors.grey[800],
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),

          // Play button overlay for video
          if (widget.isVideo)
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _isPlaying ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  color: Colors.black38,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Video badge
          if (widget.isVideo)
            Positioned(
              bottom: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 12),
                    SizedBox(width: 2),
                    Text(
                      'VIDEO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Media content (image or video)
        widget.isVideo ? _buildVideoPreview() : _buildImagePreview(),

        // Remove button
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: widget.onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),

        // Duration for videos (if available)
        if (widget.isVideo && _isVideoInitialized)
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _formatDuration(_videoController.value.duration),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
