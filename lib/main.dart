import 'package:counseling_cell_app/LoginDemo.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'TakePictureScreen.dart';
import 'LoginDemo.dart';
import 'Register.dart';
import 'dart:developer' as developer;
Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  developer.log(cameras.toString());
  // Get a specific camera from the list of available cameras.
  final frontCamera = cameras[1];

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: Register(camera: frontCamera,str: cameras.toString()),
    ),
  );
}
