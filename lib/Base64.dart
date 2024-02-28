import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Display'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: openImage,
            child: Text('Open Image'),
          ),
          SizedBox(height: 20),
          ImageDisplay(uploadInput: uploadInput),
        ],
      ),
    );
  }

  void openImage() {
    uploadInput.click();
  }
}

class ImageDisplay extends StatefulWidget {
  final html.FileUploadInputElement uploadInput;

  const ImageDisplay({Key? key, required this.uploadInput}) : super(key: key);

  @override
  _ImageDisplayState createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return _imageBytes != null
        ? Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(_imageBytes!),
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container();
  }

  @override
  void initState() {
    super.initState();

    widget.uploadInput.onChange.listen((event) async {
      final files = widget.uploadInput.files;
      final file = files!.elementAt(0);

      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) async {
        final byteData =
            Base64Decoder().convert(reader.result.toString().split(',').last);

        // Compress the image
        final compressedBytes = await compressImage(byteData);

        setState(() {
          _imageBytes = Uint8List.fromList(compressedBytes);
        });
      });

      reader.readAsDataUrl(file);
    });
  }

  Future<List<int>> compressImage(Uint8List bytes) async {
    return await FlutterImageCompress.compressWithList(
      bytes,
      minHeight: 800,
      minWidth: 600,
      quality: 80,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: YourWidget(),
  ));
}
