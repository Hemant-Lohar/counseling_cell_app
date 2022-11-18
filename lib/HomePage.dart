import 'package:counseling_cell_app/TakePictureScreen.dart';
import 'package:counseling_cell_app/userHomePage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'TakePictureScreen.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text(
            "Homepage for user",
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                    "Welcome user!!\nTake the mental health assessment to improve your experience!",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                SizedBox(
                    height: 100, //height of button
                    width: 300, //width of button
                    child: ElevatedButton(
                      onPressed: () async {
                        final cameras = await availableCameras();
                        final x = cameras[1];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TakePictureScreen(camera: x)),
                        );
                      },
                      child: const Text("Take initial assessment",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    )),
                SizedBox(
                    height: 100, //height of button
                    width: 300, //width of button
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const userHomePage()),
                        );
                      },
                      child: const Text("Skip assessment for now",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    )),
                /*SizedBox(
                    height: 100, //height of button
                    width: 300, //width of button
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Ml()),
                        );
                      },
                      child: const Text("Go to ML testing page",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    )),*/
              ],
            ),
          ),
        ));
  }
}
