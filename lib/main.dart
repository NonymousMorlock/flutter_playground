import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Image> images = [];

  final key = GlobalKey();

  Future<Uint8List> _capturePng(GlobalKey key) async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.grey,
          body: RepaintBoundary(
            key: key,
            child: SafeArea(
              child: Center(
                child: ListView.separated(
                  itemCount: images.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: images[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final directory = await getApplicationDocumentsDirectory();
              final path = directory.path;
              final image = await _capturePng(key);
              final imageName = 'image${images.length}';
              final file = File('$path/$imageName.png');
              await file.writeAsBytes(image);
              setState(() {
                images.add(Image.file(file));
              });
            },
            child: Icon(Icons.camera),
          ),
        );
      }),
    );
  }
}
