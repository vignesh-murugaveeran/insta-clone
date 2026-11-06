import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class ReelCreationScreen extends StatefulWidget {
  const ReelCreationScreen({super.key});

  @override
  State<ReelCreationScreen> createState() => _ReelCreationScreenState();
}

class _ReelCreationScreenState extends State<ReelCreationScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  bool _isCameraInitialized = false;
  bool _isFrontCamera = false;
  double _recordingProgress = 0.0;
  FlashMode _currentFlashMode = FlashMode.off;
  bool _hasFlash = false;
  List<FlashMode> _availableFlashModes = [FlashMode.off];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller != null) {
        _initializeCamera();
      }
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras!.isEmpty) {
        throw Exception('No cameras found');
      }

      final camera = _isFrontCamera
          ? _cameras!.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras!.first,
            )
          : _cameras!.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras!.first,
            );

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: true,
      );

      await _controller!.initialize();

      // Check available flash modes - simplified approach
      await _checkAvailableFlashModes();

      // Set initial flash mode
      if (_hasFlash && _availableFlashModes.isNotEmpty) {
        await _controller!.setFlashMode(_currentFlashMode);
      }

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  Future<void> _checkAvailableFlashModes() async {
    // Flash is generally only available on back cameras
    _hasFlash = !_isFrontCamera;

    if (!_hasFlash) {
      _availableFlashModes = [FlashMode.off];
      return;
    }

    // Simplified approach: Assume torch is available for back cameras
    // and use it as the "on" mode
    _availableFlashModes = [FlashMode.off, FlashMode.torch];

    print('Using simplified flash modes: $_availableFlashModes');
  }

  void _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    setState(() {
      _isCameraInitialized = false;
      _isFrontCamera = !_isFrontCamera;
      _currentFlashMode = FlashMode.off; // Reset flash when switching camera
    });

    await _controller?.dispose();
    await _initializeCamera();
  }

  void _toggleFlash() async {
    if (_controller == null || !_controller!.value.isInitialized || !_hasFlash)
      return;

    // Simple toggle between off and torch (using torch as "on")
    final newFlashMode = _currentFlashMode == FlashMode.off
        ? FlashMode.torch
        : FlashMode.off;

    print('Toggling flash from $_currentFlashMode to $newFlashMode');

    try {
      await _controller!.setFlashMode(newFlashMode);
      setState(() {
        _currentFlashMode = newFlashMode;
      });
      print('Flash mode successfully changed to: $_currentFlashMode');

      // Show visual feedback
      //_showFlashFeedback(newFlashMode);
    } catch (e) {
      print('Error setting flash mode $newFlashMode: $e');
      // If torch fails, fall back to off
      await _fallbackToFlashOff();
    }
  }

  // void _showFlashFeedback(FlashMode mode) {
  //   String message = mode == FlashMode.off ? 'Flash Off' : 'Flash On';

  //   Get.snackbar(
  //     'Flash',
  //     message,
  //     snackPosition: SnackPosition.TOP,
  //     duration: const Duration(seconds: 1),
  //     backgroundColor: Colors.black.withOpacity(0.7),
  //     colorText: Colors.white,
  //   );
  // }

  Future<void> _fallbackToFlashOff() async {
    try {
      await _controller!.setFlashMode(FlashMode.off);
      setState(() {
        _currentFlashMode = FlashMode.off;
      });
      print('Flash mode set to off (fallback)');
    } catch (e) {
      print('Failed to set flash mode to off: $e');
    }
  }

  void _startRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      await _controller!.startVideoRecording();
      setState(() {
        _isRecording = true;
        _recordingProgress = 0.0;
      });

      // Simulate recording progress (in real app, use actual duration)
      _simulateRecordingProgress();
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  void _stopRecording() async {
    if (!_isRecording) return;

    try {
      final videoFile = await _controller!.stopVideoRecording();
      setState(() {
        _isRecording = false;
        _recordingProgress = 0.0;
      });

      // Here you can process the recorded video
      print('Video saved to: ${videoFile.path}');

      // Show success message
      Get.snackbar(
        'Success',
        'Reel recorded successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  void _simulateRecordingProgress() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_isRecording && _recordingProgress < 1.0) {
        setState(() {
          _recordingProgress += 0.01;
        });
        _simulateRecordingProgress();
      } else if (_recordingProgress >= 1.0) {
        _stopRecording();
      }
    });
  }

  IconData _getFlashIcon() {
    if (!_hasFlash) return Icons.flash_off;
    return _currentFlashMode == FlashMode.off
        ? Icons.flash_off
        : Icons.flash_on;
  }

  String _getFlashLabel() {
    if (!_hasFlash) return 'No Flash';
    return _currentFlashMode == FlashMode.off ? 'Off' : 'On';
  }

  Color _getFlashColor() {
    if (!_hasFlash) return Colors.grey;
    return _currentFlashMode == FlashMode.off ? Colors.white : Colors.yellow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Reel',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Flash Button in AppBar
          if (_hasFlash)
            IconButton(
              icon: Icon(_getFlashIcon(), color: _getFlashColor(), size: 29),
              onPressed: _toggleFlash,
              tooltip: _getFlashLabel(),
            ),
          IconButton(
            icon: const Icon(
              Icons.flip_camera_ios,
              color: Colors.white,
              size: 29,
            ),
            onPressed: _switchCamera,
            tooltip: 'Switch Camera',
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview Area
            if (_isCameraInitialized && _controller != null)
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: CameraPreview(_controller!),
              )
            else
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const SizedBox(height: 20),
                    const Text(
                      'Initializing Camera...',
                      style: TextStyle(color: Colors.white),
                    ),
                    if (!_isCameraInitialized)
                      TextButton(
                        onPressed: _initializeCamera,
                        child: const Text(
                          'Retry',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                  ],
                ),
              ),

            // Recording Progress Bar
            if (_isRecording)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  value: _recordingProgress,
                  backgroundColor: Colors.grey[800],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),

            // Bottom Controls
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  ),
                ),
                child: Column(
                  children: [
                    // Gallery and Effects Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Gallery
                          _buildControlButton(
                            Icons.photo_library,
                            'Gallery',
                            () {
                              Get.snackbar(
                                'Gallery',
                                'Gallery access coming soon!',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                          ),
                          // Effects
                          _buildControlButton(
                            Icons.auto_awesome,
                            'Effects',
                            () {
                              Get.snackbar(
                                'Effects',
                                'Effects coming soon!',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                          ),
                          // Timer
                          _buildControlButton(Icons.timer, 'Timer', () {
                            Get.snackbar(
                              'Timer',
                              'Timer coming soon!',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }),
                          // Music
                          _buildControlButton(Icons.music_note, 'Music', () {
                            Get.snackbar(
                              'Music',
                              'Music coming soon!',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Record Button
                    GestureDetector(
                      onTapDown: (_) => _startRecording(),
                      onTapUp: (_) => _stopRecording(),
                      onTapCancel: _stopRecording,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: _isRecording ? 70 : 80,
                        height: _isRecording ? 70 : 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _isRecording ? Colors.red : Colors.white,
                            width: _isRecording ? 3 : 4,
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isRecording ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Flash Status Indicator
            if (_hasFlash)
              Positioned(
                top: 50,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(_getFlashIcon(), color: _getFlashColor(), size: 16),
                      const SizedBox(width: 6),
                      Text(
                        _getFlashLabel(),
                        style: TextStyle(
                          color: _getFlashColor(),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Recording Indicator
            if (_isRecording)
              Positioned(
                top: 50,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Recording',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(_recordingProgress * 100).toInt()}s',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Flash not available indicator
            if (!_hasFlash && !_isFrontCamera)
              Positioned(
                top: 50,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.flash_off, color: Colors.grey, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'No Flash',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
