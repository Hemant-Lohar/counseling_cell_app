
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
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            if (!mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
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
// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});
  @override
  Widget build(BuildContext context) {
    log(imagePath);
    Image image = Image.file(File(imagePath));
    /*double?  h = image.height;
    double? w = image.width;
    int height=0;
    int width=0;
    if(h!=null){height=h.toInt();}
    if(w!=null){width=w.toInt();}
    log("$height $width");*/
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: image,

    );

  }


}
/*void readImage(XFile image)async{
  List<double> imgArray =[];
  Image x = Image.file(File(image.path));
  final bytes = await image.readAsBytes();
  final decoder = img.JpegDecoder();
  final decodedImg = decoder.decodeImage(bytes);
  final decodedBytes = decodedImg!.getBytes(format: img.Format.rgb);

  double?  h = x.height;
  double? w = x.width;
  int height=0;
  int width=0;
  if(h!=null){height=h.toInt();}
  if(w!=null){width=w.toInt();}
  log("$height $width");
  for(int i = 0; i < height; i++){
       for(int j = 0; j < width; j++){

         int red = decodedBytes[decodedImg.width*3 + i*3];
         int green = decodedBytes[decodedImg.width*3 + i*3 + 1];
         int blue = decodedBytes[decodedImg.width*3 + i*3 + 2];
         double gray = 0.3*red + 0.59*green + 0.11*blue;
         imgArray.add(gray);
       }

      }
      log(imgArray.toString());
      log(imgArray.shape.toString());
      //imgArray.reshape([1,43,43,1]);
  return ;
}*/
