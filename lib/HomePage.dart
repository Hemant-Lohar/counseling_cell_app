import 'package:counseling_cell_app/TakePictureScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'TakePictureScreen.dart';
class HomePage extends StatefulWidget {
  final CameraDescription camera;
  const HomePage({
    super.key,
    required this.camera,
  });
  @override
  _HomePageState createState() => _HomePageState(this.camera);
}

class _HomePageState extends State<HomePage> {
  CameraDescription x;
  _HomePageState(this.x);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text(
            "HomePage",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                    "Welcome user!!\nTake the mental health assessment to improve your experience!",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                SizedBox(
                    height:100, //height of button
                    width:300, //width of button
                    child:ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TakePictureScreen(camera: x)),
                          );
                        },
                        child: const Text("Take initial assessment",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20)),)),

              ],
            ),
          ),
        ));
  }
}
