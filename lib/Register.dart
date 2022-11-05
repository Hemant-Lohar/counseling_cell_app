import 'package:counseling_cell_app/LoginDemo.dart';
import 'package:counseling_cell_app/TakePictureScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'TakePictureScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
const List<Widget> role = <Widget>[Text('Counsellor'), Text('User')];
final List<bool> _selectedRole = <bool>[true, false];
var _usernameController = TextEditingController();
var _passwordController = TextEditingController();
var _confirmPasswordController = TextEditingController();

class Register extends StatefulWidget {
  final CameraDescription camera;
  final String str;
  const Register({super.key, required this.camera, required this.str});

  @override
  _RegisterState createState() => _RegisterState(this.camera, this.str);
}

class _RegisterState extends State<Register> {
  CameraDescription x;
  String str;
  _RegisterState(this.x, this.str);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text(
            "Register",
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ToggleButtons(
                  isSelected: _selectedRole,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
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
                //Image.asset('assets/images/logo.png'),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: "Enter your email",
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Choose a password',
                  ),
                ),
                const Text("Password must be atleast 7 characters"
                    "\nPassword must have uppercase and lowercase\nletters and a numerical"
                    "\nPassword must have a spcial character"),

                TextFormField(
                  obscureText: true,
                  controller: _confirmPasswordController,
                  decoration:
                      const InputDecoration(hintText: 'Confirm password'),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginDemo(camera: x)),
                        );
                        Fluttertoast.showToast(
                          msg: "Registered Successfully!!", // message
                          toastLength: Toast.LENGTH_SHORT, // length
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1, // location// duration
                        );
                      }
                    },
                    child: const Text('Register')),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginDemo(camera: x)),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Already Registered ??\nClick here",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  bool validate() {
    String patternUsername = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regexUsername = RegExp(patternUsername);
    String  patternPassword = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regexPassword = RegExp(patternPassword);
    if (!regexUsername.hasMatch(_usernameController.text)) {
      Fluttertoast.showToast(
        msg: "Invalid email id", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1, // location// duration
      );
      return false;
    }
    if (!regexPassword.hasMatch(_passwordController.text)) {
      Fluttertoast.showToast(
        msg: "Invalid password", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1, // location// duration
      );
      return false;
    }
    if(_passwordController.text!=_confirmPasswordController.text){
      Fluttertoast.showToast(
        msg: "Passwords do not match", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1, // location// duration
      );
      return false;
    }

    return true;
    // Continue
  }
}
