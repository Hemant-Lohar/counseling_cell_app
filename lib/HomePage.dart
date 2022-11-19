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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "User Assessment",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: const BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:36.0),
          
          child: Center(
            child: Column(
            
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/assessment.png'),
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.center)
                  ),
                   
                ),
                Column(
                  children: const [
                    Text(
                      "Welcome !",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Take Mental Health Assessment\n to Improve\n Your Experience!",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                // SizedBox(
                //      //width of button
                //     child: ElevatedButton(
                //       onPressed: () async {
                //         final cameras = await availableCameras();
                //         final x = cameras[1];
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   TakePictureScreen(camera: x)),
                //         );
                //       },
                //       style: ElevatedButton.styleFrom(
                //             primary: Colors.black,
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 60, vertical: 30),
                //             shape: const StadiumBorder(),
                //             textStyle: const TextStyle(fontSize: 24)),
                //       child: const Text("Take initial assessment",
                //           ),
                //     )
                //     ),

                const SizedBox(height: 40),
                SizedBox(
                    //width of button
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const userHomePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            shape: const StadiumBorder(),
                            textStyle: const TextStyle(fontSize: 16)),
                        child: const Text("Skip Assessment for Now")
                        )
                        ),

                        
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
