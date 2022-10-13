import 'package:counseling_cell_app/TakePictureScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'TakePictureScreen.dart';
class LoginDemo extends StatefulWidget {
  final CameraDescription camera;
  const LoginDemo({
    super.key,
    required this.camera,
  });

  @override
  _LoginDemoState createState() => _LoginDemoState(this.camera);
}

class _LoginDemoState extends State<LoginDemo> {
  CameraDescription x;
  _LoginDemoState(this.x);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: const Text(
            "Login",
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/images/logo.png'),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Username',
                  ),
                ),
                const TextField(
                  decoration: InputDecoration(hintText: 'Enter Password'),
                ),
                ElevatedButton(
                    onPressed:  () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TakePictureScreen(camera: x)),
                      );
                    },
                    child: const Text('Login'))
              ],
            ),
          ),
        ));
  }
}
