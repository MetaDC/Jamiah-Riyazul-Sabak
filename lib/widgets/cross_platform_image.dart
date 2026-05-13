import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import '../shared/const/firbase.dart';

// This is the common interface.
// The actual implementation for Web will be handled via conditional logic.
class StorageImage extends StatefulWidget {
  final String imageUrl;

  const StorageImage({super.key, required this.imageUrl});

  @override
  State<StorageImage> createState() => _StorageImageState();
}

class _StorageImageState extends State<StorageImage> {
  // We use a dynamic to avoid importing web-only types here
  Object? _webParams; 

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _webParams = 'img-${widget.imageUrl.hashCode}';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // On Web, we fall back to a standard Image.network but recommend CORS setup
      // or we can use a simpler approach that doesn't break mobile builds.
      return Image.network(
        widget.imageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[100],
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image_outlined, color: Colors.grey),
                SizedBox(height: 8),
                Text('Web CORS Blocked', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          );
        },
      );
    }

    // On Mobile (APK), we use the high-performance SDK method
    return FutureBuilder<Uint8List?>(
      future: _getImageBytes(widget.imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[100],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[100],
            child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
          );
        }

        return Image.memory(
          snapshot.data!,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      },
    );
  }

  Future<Uint8List?> _getImageBytes(String url) async {
    try {
      final ref = FBStorage.storage.refFromURL(url);
      return await ref.getData(10 * 1024 * 1024);
    } catch (e) {
      debugPrint('Error fetching storage bytes: $e');
      return null;
    }
  }
}
