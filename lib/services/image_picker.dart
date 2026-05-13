import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

abstract class PickedFile {
  final String name;
  final String extension;
  final Uint8List uInt8List;

  PickedFile({
    required this.name,
    required this.uInt8List,
    required this.extension,
  });

  int get length => uInt8List.length;
}

class SelectedImage extends PickedFile {
  SelectedImage({
    required super.name,
    required super.uInt8List,
    required super.extension,
  });
}

class SelectedVideo extends PickedFile {
  SelectedVideo({
    required super.name,
    required super.uInt8List,
    required super.extension,
  });
}

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<List<SelectedImage>> pickImageAndCompress({
    required bool useCompressor,
  }) async {
    try {
      // Using ImagePicker.pickMultiImage instead of FilePicker for better stability
      final List<XFile> pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        final imgs = <SelectedImage>[];
        for (var file in pickedFiles) {
          final bytes = await file.readAsBytes();

          final finalBytes = useCompressor
              ? await imageCompressor(bytes)
              : bytes;

          final lastDotIndex = file.name.lastIndexOf('.');
          final name = lastDotIndex != -1
              ? file.name.substring(0, lastDotIndex)
              : file.name;
          final extension = lastDotIndex != -1
              ? file.name.substring(lastDotIndex + 1)
              : "";

          imgs.add(
            SelectedImage(
              name: name,
              extension: extension,
              uInt8List: finalBytes,
            ),
          );
        }
        return imgs;
      }
      return [];
    } catch (e) {
      debugPrint("ImagePicker Error: ${e.toString()}");
      return [];
    }
  }

  Future<List<SelectedImage>> pickImageAndCrop({
    required bool useCompressor,
  }) async {
    // Re-using the stable multi-pick logic
    return pickImageAndCompress(useCompressor: useCompressor);
  }

  Future<SelectedImage?> pickImageNew({required bool useCompressor}) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final lastDotIndex = image.name.lastIndexOf('.');
        final name = lastDotIndex != -1
            ? image.name.substring(0, lastDotIndex)
            : image.name;
        final extension = lastDotIndex != -1
            ? image.name.substring(lastDotIndex + 1)
            : "";

        final bytes = await image.readAsBytes();
        final finalBytes = useCompressor ? await imageCompressor(bytes) : bytes;

        return SelectedImage(
          name: name,
          extension: extension,
          uInt8List: finalBytes,
        );
      }
      return null;
    } catch (e) {
      debugPrint("ImagePicker Error: ${e.toString()}");
      Clipboard.setData(ClipboardData(text: e.toString()));
      return null;
    }
  }

  // Video picking methods - using FilePicker for videos as it handles large files better
  // Note: If you get MissingPluginException here, please rebuild the app.
  Future<List<SelectedVideo>> pickVideos({bool allowMultiple = true}) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.video,
        allowMultiple: allowMultiple,
        withData: true,
      );

      if (result != null) {
        final vids = <SelectedVideo>[];
        for (var e in result.files) {
          Uint8List? bytes = e.bytes;
          if (bytes == null && e.path != null) {
            bytes = await File(e.path!).readAsBytes();
          }

          if (bytes != null) {
            vids.add(
              SelectedVideo(
                name: e.name,
                extension: e.extension ?? "",
                uInt8List: bytes,
              ),
            );
          }
        }
        return vids;
      }
      return [];
    } catch (e) {
      debugPrint("VideoPicker Error: ${e.toString()}");
      return [];
    }
  }

  Future<SelectedVideo?> pickVideoNew() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        final lastDotIndex = video.name.lastIndexOf('.');
        final name = lastDotIndex != -1
            ? video.name.substring(0, lastDotIndex)
            : video.name;
        final extension = lastDotIndex != -1
            ? video.name.substring(lastDotIndex + 1)
            : "";

        final bytes = await video.readAsBytes();
        return SelectedVideo(
          name: name,
          extension: extension,
          uInt8List: bytes,
        );
      }
      return null;
    } catch (e) {
      debugPrint("VideoPicker error: ${e.toString()}");
      Clipboard.setData(ClipboardData(text: e.toString()));
      return null;
    }
  }
}

Future<Uint8List> imageCompressor(Uint8List list) async {
  // Check if we are on Web - flutter_image_compress does not support web
  if (kIsWeb) {
    return list; // Return original bytes on web
  }

  try {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 70,
    );
    return result;
  } catch (e) {
    debugPrint("Compression Error: $e");
    return list; // Fallback to original bytes
  }
}
