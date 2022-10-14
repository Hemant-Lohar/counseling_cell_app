import 'package:counseling_cell_app/LoginDemo.dart';
import 'package:counseling_cell_app/TakePictureScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'TakePictureScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Register extends StatefulWidget {
  final CameraDescription camera;
  final String str;
  const Register({
    super.key,
    required this.camera,
    required this.str
  });

  @override
  _RegisterState createState() => _RegisterState(this.camera,this.str);
}

class _RegisterState extends State<Register> {
  CameraDescription x;
  String str;
  _RegisterState(this.x,this.str);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Image.asset('assets/images/logo.png'),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                  ),
                ),
                const TextField(
                  obscureText: true,
                   style: TextStyle(
              color: Colors.black,
            ),
                  decoration: InputDecoration(
                    hintText: 'Enter a password',
                  ),
                ),
                const Text("Password must be atleast 7 characters"
                    "\nPassword must have uppercase and lowercase letters"
                    "\nPassword must have a spcial character"),

                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Confirm password'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Registered Successfully!!",  // message
                          toastLength: Toast.LENGTH_SHORT, // length
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,// location// duration
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginDemo(camera: x)),
                      );
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
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: const Text("Already Registered ??\nClick here",textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
