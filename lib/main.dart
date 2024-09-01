import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Name Printer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NameInputScreen(),
    );
  }
}

class NameInputScreen extends StatefulWidget {
  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _controller = TextEditingController();
  Uint8List? _imageBytes;

  void _generateImage(String name) {
    final image = img.Image(400, 200);
    img.fill(image, img.getColor(255, 255, 255));

    final textStyle = img.arial_48;
    img.drawString(image, textStyle, 20, 80, name,
        color: img.getColor(0, 0, 0));

    setState(() {
      _imageBytes = Uint8List.fromList(img.encodePng(image));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Name Printer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _generateImage(_controller.text);
                }
              },
              child: Text('Generate Image'),
            ),
            SizedBox(height: 20),
            _imageBytes != null ? Image.memory(_imageBytes!) : Container(),
          ],
        ),
      ),
    );
  }
}
