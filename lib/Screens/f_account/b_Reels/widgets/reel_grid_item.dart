import 'dart:typed_data'; // IMPORT FOR Uint8List
import 'package:flutter/material.dart';
import 'package:insta_clone2/Screens/f_account/b_Reels/widgets/services/thumnail_service.dart';
import 'package:insta_clone2/models/reel_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ReelGridItem extends StatefulWidget {
  final ReelModel reel;
  final VoidCallback onTap;

  const ReelGridItem({super.key, required this.reel, required this.onTap});

  @override
  State<ReelGridItem> createState() => _ReelGridItemState();
}

class _ReelGridItemState extends State<ReelGridItem> {
  Uint8List? _thumbnail;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    try {
      print('🎬 Starting thumbnail generation for: ${widget.reel.videoUrl}');

      final thumbnail = await ThumbnailService.generateThumbnail(
        widget.reel.videoUrl,
      );

      if (mounted) {
        setState(() {
          _thumbnail = thumbnail;
          _isLoading = false;
          _hasError = thumbnail == null;
        });

        if (thumbnail == null) {
          print('⚠️ No thumbnail generated for: ${widget.reel.videoUrl}');
        } else {
          print('✅ Thumbnail ready for: ${widget.reel.videoUrl}');
        }
      }
    } catch (e) {
      print('❌ Thumbnail generation failed for ${widget.reel.videoUrl}: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.grey[300],
        child: Stack(
          children: [
            // Thumbnail or Placeholder
            if (_isLoading)
              _buildLoadingState()
            else if (_thumbnail != null)
              _buildThumbnail()
            else
              _buildErrorState(),

            // Gradient Overlay
            _buildGradientOverlay(),

            // Views Count
            _buildViewsCount(),

            // Like Icon (if liked)
            if (widget.reel.isLiked) _buildLikeIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      color: Colors.grey[400],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
            8.heightBox,
            Text(
              'Loading...',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Image.memory(
      _thumbnail!,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorState();
      },
    );
  }

  Widget _buildErrorState() {
    return Container(
      color: Colors.grey[500],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.videocam_rounded, color: Colors.white, size: 40),
            8.heightBox,
            Text(
              'No preview',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.6), Colors.transparent],
        ),
      ),
    );
  }

  Widget _buildViewsCount() {
    return Positioned(
      bottom: 8,
      left: 8,
      child: Row(
        children: [
          Icon(Icons.play_arrow_rounded, color: Colors.white, size: 16),
          4.widthBox,
          Text(
            _formatViews(widget.reel.views),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikeIndicator() {
    return Positioned(
      top: 8,
      right: 8,
      child: Icon(Icons.favorite_rounded, color: Colors.red, size: 16),
    );
  }

  String _formatViews(int views) {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    }
    return views.toString();
  }
}
