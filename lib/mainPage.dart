// import 'package:counseling_cell_app/HomePage.dart';
// import 'package:counseling_cell_app/LoginDemo.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:camera/camera.dart';

// class MainPage extends StatefulWidget {
//   final CameraDescription camera;
//   const MainPage({
//     super.key,
//     required this.camera,
//   });

//   @override 
//   _MainPageState createState() => _MainPageState(this.camera);
// }

// class _MainPageState extends State<MainPage> {
//   CameraDescription x;
//   _MainPageState(this.x);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) => {
//         if(snapshot.hasData){
//           return HomePage(camera: x);
//         }else {
//           return LoginDemo(camera: x)
//         }
//       },
//     ),
//     );
//   }
// }