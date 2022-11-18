import 'dart:developer';

import 'package:counseling_cell_app/counsellorHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:fluttertoast/fluttertoast.dart';

const List<Widget> role = <Widget>[Text('Counsellor'), Text('User')];
final List<bool> _selectedRole = <bool>[true, false];
// var _usernameController = TextEditingController();
// var _passwordController = TextEditingController();
class LoginDemo extends StatefulWidget {
  const LoginDemo({
    super.key,
  });

  @override
  _LoginDemoState createState() => _LoginDemoState();
}



class _LoginDemoState extends State<LoginDemo> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var islogin = false;

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  static Future<User?> loginUsingEmailPassword({required String email,required String password, required BuildContext context})async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        Fluttertoast.showToast(
          msg: "User not found for this email", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1, // location// duration
        );
      }
    }
    return user;
  }

  _LoginDemoState();
  @override

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
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
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if( snapshot.connectionState==ConnectionState.done){
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Image.asset('assets/images/logo.png'),
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
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Username',
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(hintText: 'Enter Password'),
                        ),
                        ElevatedButton(
                            onPressed:  () async {

                              User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                              log(user.toString());
                              if(user!=null && _selectedRole[1]){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
                              }
                              else if(user!=null && _selectedRole[0]){
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const counsellorHomePage()));
                              }
                              else{
                                Fluttertoast.showToast(
                                  msg: "Invalid email or password", // message
                                  toastLength: Toast.LENGTH_SHORT, // length
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1, // location// duration
                                );
                              }
                            },
                            child: const Text('Login')),

                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );

          }),
        );

  }
}
