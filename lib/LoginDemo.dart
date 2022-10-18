
import 'package:counseling_cell_app/TakePictureScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'HomePage.dart';
const List<Widget> role = <Widget>[
  Text("Counsellor"),
  Text("User")
];
const List r=["Counsellor","User"];
final List<bool> _selectedRole = <bool>[true, false];
String _role="";
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
        backgroundColor: Colors.blueGrey,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                ToggleButtons(
                  isSelected: _selectedRole,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      _role=r[index].toString();
                      for (int i = 0; i < _selectedRole.length; i++) {
                        _selectedRole[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(22)),
                  selectedBorderColor: Colors.blueGrey,
                  selectedColor: Colors.white,
                  fillColor: Colors.blueGrey,
                  color: Colors.white70,
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 100.0,
                  ),
                  children: role,
                ),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Username',
                  ),
                ),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Enter Password'),
                ),
                ElevatedButton(
                    onPressed:  () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(camera: x,user: _role)),
                      );
                    },
                    child: const Text('Login')),

              ],
            ),
          ),
        ));
  }
}
