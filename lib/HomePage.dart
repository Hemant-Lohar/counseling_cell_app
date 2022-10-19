import 'package:counseling_cell_app/TakePictureScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'TakePictureScreen.dart';
class HomePage extends StatefulWidget {
  final CameraDescription camera;
  final String user;
  const HomePage({
    super.key,
    required this.camera,
    required this.user,
  });
  @override
  _HomePageState createState() => _HomePageState(this.camera,this.user);
}

class _HomePageState extends State<HomePage> {
  CameraDescription x;
  String user;

  _HomePageState(this.x, this.user);
  Widget _test_widget(){
    if (user=="User"){
      return SizedBox(
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
                    fontSize: 20)),));
    }
    else{
      return Container(height:0); //or any other widget but not null
    }
  }
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
                Text(
                    "Welcome $user!!\nTake the mental health assessment to improve your experience!",
                    style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),

                _test_widget(),

              ],
            ),
          ),
        ));
  }
}
