import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_vto_project/features/tryon/screens/View3DClothesPage.dart';

class TryOnPage extends StatefulWidget {
  const TryOnPage({super.key});

  @override
  State<TryOnPage> createState() => _TryOnPageState();
}

class _TryOnPageState extends State<TryOnPage> {
  File? _videoFile;
  VideoPlayerController? _videoController;

  void _showSuccessDialog(File videoFile) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.videocam, size: 60, color: Colors.indigo),
                const SizedBox(height: 20),
                const Text(
                  "Your video has been successfully recorded!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const View3DClothesPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 14,
                    ),
                  ),
                  child: const Text(
                    "Process Video for 3D",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _requestCameraPermissionAndRecordVideo() async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      final pickedVideo = await ImagePicker().pickVideo(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        maxDuration: const Duration(seconds: 30), // Optional: Limit duration
      );

      if (pickedVideo != null) {
        final videoFile = File(pickedVideo.path);

        setState(() {
          _videoFile = videoFile;
          _videoController?.dispose(); // Dispose old controller
          _videoController = VideoPlayerController.file(videoFile)
            ..initialize().then((_) {
              setState(() {});
              _videoController?.setLooping(true);
              _videoController?.play(); // Autoplay
            });
        });

        _showSuccessDialog(videoFile);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission is required")),
      );
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Virtual Try-On")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              '🎥 Please record a full-body video in a well-lit area.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.videocam, color: Colors.black87),
              label: const Text(
                'Record Video',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: _requestCameraPermissionAndRecordVideo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 14.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 3,
                shadowColor: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            _videoFile != null
                ? Column(
                  children: [
                    const Text(
                      'Recorded Video:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height:
                          MediaQuery.of(context).size.height *
                          0.6, // taller height
                      padding: const EdgeInsets.all(12),
                      child:
                          _videoController != null &&
                                  _videoController!.value.isInitialized
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: FittedBox(
                                  fit: BoxFit.contain, // maintain proportions
                                  child: SizedBox(
                                    width:
                                        _videoController!
                                            .value
                                            .size
                                            .height, // switch width and height
                                    height: _videoController!.value.size.width,
                                    child: VideoPlayer(_videoController!),
                                  ),
                                ),
                              )
                              : const Center(
                                child: CircularProgressIndicator(),
                              ),
                    ),
                  ],
                )
                : const Text("No video recorded yet."),
          ],
        ),
      ),
    );
  }
}
