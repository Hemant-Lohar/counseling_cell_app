import 'package:counseling_cell_app/mltest.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.veryHigh,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            _initializeControllerFuture;
            // Attempt to take a picture and get the file `image` where it was saved.
            final image = _controller.takePicture();
            final arr = await readImage(await image);
            log(arr.shape.toString());
            /*var decodedImage = await decodeImageFromList(File(image.path).readAsBytesSync());
            log("${decodedImage.height} ${decodedImage.width}");*/
            // If the picture was taken, display it on a new screen.

            if (!mounted) return;
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>  Ml(arr: arr)),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            log(e.toString());
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A function which takes image file as input and returns a 1*43*43*1 list
Future<List<List<double>>> readImage(XFile image) async {
  List<List<double>> imgArray = [];
  final bytes = await image.readAsBytes();
  final decoder = img.JpegDecoder();
  final decodedImgOriginal = decoder.decodeImage(bytes);
  final decodedBytes = decodedImgOriginal!.getBytes(format: img.Format.rgb);
  img.Image thumbnail = img.copyResize(decodedImgOriginal, width: 48, height: 48);
  final decodedImg = thumbnail;
  int height = decodedImg.height;
  int width = decodedImg.width;
  //log("$height $width");
  for (int y = 0; y < height; y++) {
    imgArray.add([]);
    for (int x = 0; x < width; x++) {
      int red = decodedBytes[y * decodedImg.width * 3 + x * 3];
      int green = decodedBytes[y * decodedImg.width * 3 + x * 3 + 1];
      int blue = decodedBytes[y * decodedImg.width * 3 + x * 3 + 2];
      double gray = 0.3 * red + 0.59 * green + 0.11 * blue;
      imgArray[y].add(gray);
    }
  }
  //log(imgArray[0].toString());
  imgArray.reshape([1, 48, 48, 1]);
  //log(imgArray.shape.toString());
  return imgArray;
}
