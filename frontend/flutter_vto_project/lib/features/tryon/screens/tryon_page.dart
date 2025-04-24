import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class TryOnPage extends StatefulWidget {
  const TryOnPage({super.key});

  @override
  State<TryOnPage> createState() => _TryOnPageState();
}

class _TryOnPageState extends State<TryOnPage> {
  File? _imageFile;
  // Step 1: Add this function inside your state class
  void _showSuccessDialog(File imageFile) {
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
                CircleAvatar(radius: 40, backgroundImage: FileImage(imageFile)),
                const SizedBox(height: 20),
                const Text(
                  "Your 3D has been successfully created!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    // TODO: Navigate to your 3D cloth try-on screen
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
                    "View clothes in 3D",
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

  // Step 2: Update your camera function to call this modal
  Future<void> _requestCameraPermissionAndCaptureImage() async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedImage != null) {
        setState(() {
          _imageFile = File(pickedImage.path);
        });

        // 🔥 Show the modal here after picking image
        _showSuccessDialog(_imageFile!);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Camera permission is required")),
      );
    }
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
              '📸 Please take a picture in a well-lit area covering your full body.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt, color: Colors.black87),
              label: const Text(
                'Open Camera',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: _requestCameraPermissionAndCaptureImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200], // Light color for dark theme
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

            _imageFile != null
                ? Column(
                  children: [
                    const Text(
                      'Captured Image:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Image.file(_imageFile!, height: 300),
                  ],
                )
                : const Text("No image captured yet."),
          ],
        ),
      ),
    );
  }
}
