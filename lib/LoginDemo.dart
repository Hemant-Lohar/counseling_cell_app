import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'HomePage.dart';

const List<Widget> role = <Widget>[Text('Counsellor'), Text('User')];
final List<bool> _selectedRole = <bool>[true, false];

// var _usernameController = TextEditingController();
// var _passwordController = TextEditingController();

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var islogin = true;

  Future signIn() async {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      islogin = true;
    
  }

  CameraDescription x;
  _LoginDemoState(this.x);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: const Text(
        //     "Login",
        //     style: TextStyle(
        //       color: Colors.black,
        //     ),
        //   ),
        //   backgroundColor: Color.fromARGB(255, 185, 218, 243),
        //   elevation: 0,
        // ),
        // body: Padding(
        //   padding: const EdgeInsets.all(36.0),
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Image.asset('assets/images/logo.png'),
        //         ToggleButtons(
        //           isSelected: _selectedRole,
        //           onPressed: (int index) {
        //             setState(() {
        //               // The button that is tapped is set to true, and the others to false.
        //               for (int i = 0; i < _selectedRole.length; i++) {
        //                 _selectedRole[i] = i == index;
        //               }
        //             });
        //           },
        //           borderRadius: const BorderRadius.all(Radius.circular(22)),
        //           selectedBorderColor: Colors.blueGrey,
        //           selectedColor: Colors.white,
        //           fillColor: Colors.blueGrey,
        //           color: Colors.white70,
        //           constraints: const BoxConstraints(
        //             minHeight: 40.0,
        //             minWidth: 100.0,
        //           ),
        //           children: role,
        //         ),
        // TextFormField(
        //   controller: _usernameController,
        //   decoration: const InputDecoration(
        //     hintText: 'Enter Username',
        //   ),
        // ),
        //         // TextFormField(
        //         //   controller: _passwordController,
        //         //   obscureText: true,
        //         //   decoration: const InputDecoration(hintText: 'Enter Password'),
        //         // ),
        // ElevatedButton(
        //     onPressed:  () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => HomePage(camera: x)),
        //       );
        //     },
        //     child: const Text('Login')),

        //       ],
        //     ),
        //   ),
        // )

        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 80),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 185, 218, 243),
                          Color.fromARGB(255, 221, 240, 255)
                        ],
                      ),
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomLeft)),
                ),

                const SizedBox(height: 50),
                // Username
                Padding(
                  padding:
                      const EdgeInsets.only(right: 0, left: 0, bottom: 200),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black87),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  fillColor: Colors.white,
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black87),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: _passwordController,
                              style: const TextStyle(color: Colors.black),
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          signIn();
                          islogin
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(camera: x)),
                                )
                              : " ";
                        },
                        child: const Text('Login'),
                      ),

                      // ElevatedButton(
                      //   style: const ButtonStyle(
                      //     textStyle: TextStyle(
                      //       fontSize: 20
                      //     )
                      //   ),
                      //   onPressed: () {},
                      //   child: const Text('Login'),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
