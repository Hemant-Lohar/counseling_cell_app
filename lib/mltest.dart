import 'dart:developer';
import 'package:counseling_cell_app/userHomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

TextEditingController _textcontroller = TextEditingController();
List<String> labels = [
  "Angry",
  "Disgust",
  "Fear",
  "Happy",
  "Sad",
  "Surprise",
  "Neutral"
];

class Ml extends StatefulWidget {
  final List arr;
  const Ml({
    super.key,
    required this.arr,
  });

  @override
  _MlState createState() => _MlState(this.arr);
}

class _MlState extends State<Ml> {
  List arr;
  _MlState(this.arr);
  @override
  Widget build(BuildContext context) {
    FirebaseModelDownloader.instance
        .getModel(
      "test_model",
      FirebaseModelDownloadType.latestModel,
      //Don't delete following lines , i'll need'em later bitch !
      /*FirebaseModelDownloadConditions(
          androidChargingRequired: false,
          androidWifiRequired: false,
          androidDeviceIdleRequired: false,
        )*/
    )
        .then((customModel) {
      // Download complete. Depending on your app, you could enable the ML feature, or switch from the local model to the remote model, etc.
      // The CustomModel object contains the local path of the model file, which you can use to instantiate a TensorFlow Lite interpreter.
      //final localModelPath = customModel.file;

      int result = predict(customModel, arr);
      _textcontroller.text = "Detected emotion: " + labels[result].toString();
    });

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text(
            "Testing page for ML",
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
                TextField(
                  controller: _textcontroller,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const userHomePage()),
                      );
                    },
                    child: Text("Go to homepage")),
              ],
            ),
          ),
        ));
  }

  int predict(FirebaseCustomModel x, List ip) {
    final interpreter = Interpreter.fromFile(x.file);
    /*List ip = [255.0, 254.0, 255.0, 254.0, 254.0, 179.0, 122.0, 107.0, 95.0, 124.0, 149.0, 150.0, 169.0, 178.0, 179.0, 179.0, 181.0, 181.0, 184.0, 190.0, 191.0, 191.0, 193.0, 190.0, 190.0, 195.0, 194.0, 192.0, 193.0, 196.0, 193.0, 192.0, 188.0, 182.0, 173.0, 162.0, 152.0, 144.0, 129.0, 116.0, 113.0, 106.0, 184.0, 255.0, 252.0, 254.0, 255.0, 255.0, 255.0, 254.0, 254.0, 255.0, 238.0, 146.0, 122.0, 108.0, 126.0, 148.0, 167.0, 172.0, 179.0, 182.0, 184.0, 185.0, 184.0, 185.0, 186.0, 188.0, 189.0, 191.0, 188.0, 190.0, 192.0, 192.0, 192.0, 192.0, 194.0, 194.0, 194.0, 193.0, 187.0, 182.0, 179.0, 176.0, 168.0, 159.0, 146.0, 126.0, 120.0, 118.0, 148.0, 247.0, 253.0, 253.0, 255.0, 255.0, 255.0, 254.0, 253.0, 255.0, 212.0, 141.0, 125.0, 129.0, 153.0, 168.0, 172.0, 179.0, 182.0, 183.0, 187.0, 185.0, 185.0, 187.0, 188.0, 190.0, 192.0, 190.0, 192.0, 194.0, 193.0, 192.0, 190.0, 189.0, 191.0, 193.0, 191.0, 188.0, 186.0, 182.0, 178.0, 175.0, 171.0, 170.0, 164.0, 141.0, 114.0, 122.0, 125.0, 215.0, 255.0, 252.0, 255.0, 255.0, 254.0, 253.0, 253.0, 252.0, 191.0, 136.0, 123.0, 149.0, 171.0, 172.0, 176.0, 176.0, 179.0, 184.0, 186.0, 184.0, 182.0, 181.0, 178.0, 181.0, 183.0, 183.0, 187.0, 187.0, 186.0, 185.0, 185.0, 187.0, 187.0, 188.0, 185.0, 182.0, 179.0, 175.0, 176.0, 175.0, 174.0, 172.0, 173.0, 159.0, 112.0, 114.0, 124.0, 180.0, 255.0, 252.0, 255.0, 254.0, 253.0, 252.0, 254.0, 239.0, 171.0, 132.0, 130.0, 159.0, 177.0, 170.0, 169.0, 174.0, 177.0, 175.0, 175.0, 179.0, 180.0, 181.0, 182.0, 185.0, 188.0, 189.0, 188.0, 188.0, 189.0, 188.0, 185.0, 185.0, 184.0, 185.0, 182.0, 180.0, 177.0, 177.0, 173.0, 168.0, 171.0, 172.0, 170.0, 163.0, 118.0, 110.0, 127.0, 155.0, 244.0, 254.0, 254.0, 254.0, 253.0, 251.0, 253.0, 238.0, 165.0, 136.0, 133.0, 164.0, 177.0, 173.0, 171.0, 167.0, 167.0, 169.0, 172.0, 171.0, 173.0, 172.0, 173.0, 175.0, 182.0, 185.0, 184.0, 187.0, 187.0, 186.0, 183.0, 180.0, 179.0, 175.0, 171.0, 169.0, 169.0, 169.0, 167.0, 166.0, 168.0, 167.0, 167.0, 159.0, 120.0, 102.0, 124.0, 140.0, 225.0, 255.0, 254.0, 254.0, 253.0, 252.0, 255.0, 232.0, 164.0, 133.0, 132.0, 163.0, 177.0, 169.0, 163.0, 159.0, 160.0, 163.0, 164.0, 169.0, 174.0, 176.0, 178.0, 181.0, 186.0, 187.0, 185.0, 187.0, 186.0, 185.0, 184.0, 181.0, 180.0, 178.0, 179.0, 177.0, 174.0, 172.0, 167.0, 167.0, 164.0, 165.0, 164.0, 153.0, 117.0, 102.0, 120.0, 127.0, 205.0, 255.0, 253.0, 254.0, 253.0, 252.0, 255.0, 231.0, 155.0, 128.0, 138.0, 163.0, 176.0, 158.0, 154.0, 155.0, 161.0, 165.0, 169.0, 175.0, 177.0, 178.0, 182.0, 180.0, 182.0, 182.0, 184.0, 184.0, 184.0, 183.0, 187.0, 189.0, 191.0, 190.0, 189.0, 190.0, 189.0, 188.0, 186.0, 184.0, 175.0, 164.0, 161.0, 156.0, 114.0, 101.0, 110.0, 123.0, 190.0, 255.0, 253.0, 254.0, 254.0, 252.0, 255.0, 231.0, 146.0, 132.0, 137.0, 165.0, 169.0, 159.0, 172.0, 175.0, 175.0, 177.0, 179.0, 182.0, 184.0, 186.0, 189.0, 184.0, 185.0, 187.0, 188.0, 186.0, 188.0, 190.0, 192.0, 195.0, 194.0, 191.0, 179.0, 176.0, 175.0, 178.0, 185.0, 180.0, 176.0, 174.0, 164.0, 153.0, 117.0, 100.0, 102.0, 119.0, 188.0, 255.0, 254.0, 254.0, 254.0, 252.0, 255.0, 234.0, 151.0, 138.0, 135.0, 164.0, 172.0, 173.0, 174.0, 169.0, 163.0, 157.0, 150.0, 156.0, 171.0, 180.0, 188.0, 191.0, 189.0, 190.0, 190.0, 189.0, 191.0, 191.0, 193.0, 195.0, 185.0, 167.0, 146.0, 137.0, 130.0, 128.0, 143.0, 155.0, 152.0, 162.0, 170.0, 160.0, 115.0, 96.0, 98.0, 114.0, 179.0, 255.0, 254.0, 255.0, 254.0, 252.0, 255.0, 237.0, 157.0, 144.0, 130.0, 165.0, 179.0, 159.0, 137.0, 119.0, 103.0, 113.0, 125.0, 132.0, 141.0, 156.0, 177.0, 190.0, 192.0, 190.0, 192.0, 193.0, 193.0, 194.0, 195.0, 188.0, 166.0, 158.0, 152.0, 144.0, 129.0, 123.0, 102.0, 109.0, 130.0, 146.0, 164.0, 167.0, 116.0, 92.0, 102.0, 116.0, 164.0, 251.0, 255.0, 254.0, 253.0, 251.0, 254.0, 237.0, 163.0, 143.0, 128.0, 166.0, 169.0, 135.0, 110.0, 94.0, 104.0, 119.0, 132.0, 144.0, 150.0, 151.0, 169.0, 183.0, 191.0, 193.0, 190.0, 190.0, 193.0, 192.0, 188.0, 176.0, 163.0, 159.0, 157.0, 148.0, 134.0, 136.0, 138.0, 148.0, 161.0, 158.0, 159.0, 172.0, 120.0, 94.0, 102.0, 118.0, 150.0, 247.0, 255.0, 254.0, 253.0, 252.0, 255.0, 232.0, 165.0, 145.0, 128.0, 175.0, 156.0, 148.0, 155.0, 155.0, 156.0, 147.0, 137.0, 144.0, 156.0, 155.0, 159.0, 173.0, 184.0, 187.0, 188.0, 186.0, 186.0, 185.0, 178.0, 171.0, 158.0, 152.0, 147.0, 138.0, 143.0, 162.0, 172.0, 178.0, 175.0, 175.0, 161.0, 173.0, 129.0, 91.0, 104.0, 120.0, 146.0, 244.0, 255.0, 254.0, 253.0, 252.0, 255.0, 228.0, 165.0, 145.0, 129.0, 179.0, 166.0, 171.0, 170.0, 166.0, 161.0, 149.0, 141.0, 131.0, 137.0, 145.0, 152.0, 166.0, 178.0, 178.0, 183.0, 183.0, 179.0, 177.0, 171.0, 162.0, 149.0, 138.0, 131.0, 132.0, 139.0, 140.0, 141.0, 151.0, 163.0, 169.0, 168.0, 165.0, 150.0, 94.0, 103.0, 119.0, 139.0, 240.0, 254.0, 252.0, 253.0, 252.0, 255.0, 229.0, 168.0, 136.0, 136.0, 183.0, 177.0, 173.0, 163.0, 149.0, 135.0, 127.0, 124.0, 122.0, 122.0, 123.0, 131.0, 146.0, 165.0, 171.0, 178.0, 178.0, 175.0, 170.0, 160.0, 142.0, 125.0, 121.0, 112.0, 101.0, 91.0, 92.0, 103.0, 115.0, 123.0, 145.0, 158.0, 158.0, 168.0, 119.0, 98.0, 119.0, 131.0, 229.0, 252.0, 247.0, 253.0, 251.0, 255.0, 219.0, 174.0, 138.0, 150.0, 187.0, 171.0, 160.0, 137.0, 107.0, 82.0, 73.0, 64.0, 69.0, 88.0, 105.0, 106.0, 112.0, 139.0, 157.0, 172.0, 180.0, 178.0, 162.0, 141.0, 118.0, 109.0, 104.0, 90.0, 81.0, 91.0, 115.0, 112.0, 109.0, 121.0, 112.0, 135.0, 146.0, 168.0, 149.0, 105.0, 117.0, 124.0, 216.0, 255.0, 255.0, 254.0, 250.0, 254.0, 219.0, 169.0, 139.0, 163.0, 187.0, 155.0, 133.0, 102.0, 88.0, 88.0, 124.0, 135.0, 107.0, 77.0, 83.0, 94.0, 96.0, 110.0, 134.0, 165.0, 193.0, 187.0, 161.0, 138.0, 115.0, 104.0, 95.0, 90.0, 118.0, 165.0, 161.0, 152.0, 153.0, 117.0, 116.0, 106.0, 132.0, 165.0, 168.0, 121.0, 118.0, 115.0, 203.0, 237.0, 211.0, 254.0, 251.0, 255.0, 211.0, 150.0, 144.0, 172.0, 186.0, 145.0, 116.0, 97.0, 111.0, 168.0, 165.0, 140.0, 173.0, 161.0, 95.0, 93.0, 105.0, 111.0, 129.0, 162.0, 195.0, 192.0, 170.0, 151.0, 126.0, 122.0, 108.0, 112.0, 161.0, 137.0, 72.0, 89.0, 153.0, 160.0, 100.0, 119.0, 136.0, 162.0, 176.0, 145.0, 123.0, 116.0, 151.0, 163.0, 158.0, 255.0, 247.0, 231.0, 200.0, 145.0, 152.0, 176.0, 185.0, 143.0, 121.0, 96.0, 147.0, 168.0, 67.0, 50.0, 108.0, 172.0, 134.0, 102.0, 138.0, 140.0, 142.0, 159.0, 188.0, 186.0, 171.0, 162.0, 158.0, 156.0, 140.0, 121.0, 145.0, 100.0, 35.0, 51.0, 99.0, 173.0, 121.0, 123.0, 140.0, 153.0, 174.0, 160.0, 134.0, 124.0, 144.0, 170.0, 151.0, 253.0, 228.0, 167.0, 157.0, 152.0, 154.0, 182.0, 181.0, 140.0, 126.0, 123.0, 158.0, 135.0, 59.0, 26.0, 80.0, 159.0, 145.0, 121.0, 144.0, 156.0, 146.0, 156.0, 185.0, 180.0, 170.0, 163.0, 166.0, 148.0, 141.0, 118.0, 135.0, 114.0, 68.0, 68.0, 137.0, 153.0, 134.0, 135.0, 148.0, 154.0, 171.0, 168.0, 143.0, 138.0, 174.0, 164.0, 145.0, 253.0, 200.0, 177.0, 178.0, 162.0, 157.0, 188.0, 179.0, 141.0, 132.0, 136.0, 149.0, 146.0, 101.0, 88.0, 115.0, 142.0, 122.0, 125.0, 131.0, 147.0, 143.0, 158.0, 177.0, 175.0, 168.0, 156.0, 158.0, 145.0, 118.0, 116.0, 116.0, 126.0, 126.0, 136.0, 146.0, 144.0, 144.0, 148.0, 154.0, 159.0, 163.0, 166.0, 153.0, 148.0, 174.0, 161.0, 150.0, 255.0, 170.0, 164.0, 205.0, 171.0, 166.0, 190.0, 176.0, 150.0, 141.0, 139.0, 138.0, 139.0, 135.0, 126.0, 126.0, 127.0, 131.0, 129.0, 145.0, 148.0, 141.0, 161.0, 173.0, 177.0, 172.0, 157.0, 157.0, 167.0, 145.0, 127.0, 130.0, 135.0, 132.0, 134.0, 137.0, 146.0, 150.0, 155.0, 158.0, 163.0, 164.0, 167.0, 158.0, 152.0, 170.0, 161.0, 148.0, 249.0, 178.0, 163.0, 196.0, 180.0, 178.0, 189.0, 169.0, 157.0, 146.0, 143.0, 139.0, 133.0, 130.0, 132.0, 137.0, 140.0, 144.0, 155.0, 160.0, 149.0, 145.0, 164.0, 171.0, 180.0, 175.0, 162.0, 159.0, 173.0, 174.0, 155.0, 144.0, 146.0, 151.0, 155.0, 154.0, 159.0, 161.0, 162.0, 164.0, 165.0, 163.0, 169.0, 168.0, 155.0, 151.0, 171.0, 155.0, 247.0, 179.0, 172.0, 184.0, 181.0, 192.0, 185.0, 168.0, 161.0, 156.0, 155.0, 152.0, 150.0, 150.0, 146.0, 140.0, 151.0, 161.0, 163.0, 158.0, 152.0, 153.0, 162.0, 174.0, 176.0, 168.0, 162.0, 159.0, 168.0, 174.0, 170.0, 159.0, 150.0, 148.0, 158.0, 166.0, 171.0, 174.0, 169.0, 168.0, 166.0, 164.0, 169.0, 179.0, 149.0, 135.0, 176.0, 167.0, 251.0, 183.0, 182.0, 167.0, 146.0, 201.0, 185.0, 168.0, 165.0, 163.0, 164.0, 165.0, 161.0, 153.0, 147.0, 155.0, 169.0, 167.0, 166.0, 165.0, 157.0, 157.0, 165.0, 182.0, 180.0, 167.0, 165.0, 162.0, 167.0, 174.0, 176.0, 175.0, 164.0, 159.0, 162.0, 164.0, 170.0, 175.0, 172.0, 168.0, 161.0, 162.0, 173.0, 190.0, 159.0, 145.0, 161.0, 173.0, 254.0, 208.0, 186.0, 154.0, 125.0, 198.0, 188.0, 167.0, 168.0, 168.0, 169.0, 168.0, 162.0, 158.0, 163.0, 169.0, 171.0, 167.0, 169.0, 159.0, 160.0, 158.0, 164.0, 185.0, 182.0, 166.0, 163.0, 166.0, 165.0, 171.0, 176.0, 179.0, 175.0, 171.0, 173.0, 167.0, 169.0, 172.0, 170.0, 165.0, 160.0, 160.0, 174.0, 191.0, 165.0, 166.0, 158.0, 166.0, 254.0, 230.0, 176.0, 134.0, 137.0, 194.0, 189.0, 165.0, 170.0, 170.0, 169.0, 169.0, 164.0, 167.0, 171.0, 169.0, 166.0, 167.0, 167.0, 156.0, 156.0, 158.0, 167.0, 184.0, 189.0, 172.0, 160.0, 162.0, 164.0, 169.0, 173.0, 179.0, 178.0, 172.0, 174.0, 174.0, 170.0, 167.0, 163.0, 162.0, 160.0, 158.0, 177.0, 190.0, 170.0, 186.0, 175.0, 163.0, 255.0, 238.0, 162.0, 138.0, 167.0, 188.0, 188.0, 166.0, 169.0, 167.0, 169.0, 170.0, 169.0, 168.0, 168.0, 167.0, 167.0, 168.0, 164.0, 152.0, 152.0, 158.0, 168.0, 184.0, 185.0, 173.0, 165.0, 159.0, 155.0, 162.0, 175.0, 173.0, 177.0, 175.0, 167.0, 166.0, 169.0, 162.0, 163.0, 160.0, 157.0, 158.0, 175.0, 191.0, 174.0, 174.0, 166.0, 165.0, 255.0, 239.0, 155.0, 138.0, 170.0, 191.0, 188.0, 169.0, 164.0, 161.0, 168.0, 170.0, 168.0, 166.0, 165.0, 170.0, 168.0, 166.0, 152.0, 146.0, 154.0, 160.0, 167.0, 174.0, 179.0, 169.0, 161.0, 157.0, 156.0, 148.0, 166.0, 172.0, 173.0, 175.0, 170.0, 164.0, 166.0, 164.0, 160.0, 156.0, 155.0, 156.0, 171.0, 183.0, 169.0, 158.0, 161.0, 162.0, 254.0, 242.0, 181.0, 148.0, 147.0, 187.0, 188.0, 169.0, 165.0, 161.0, 165.0, 170.0, 167.0, 163.0, 169.0, 171.0, 168.0, 152.0, 136.0, 148.0, 157.0, 162.0, 165.0, 171.0, 176.0, 172.0, 161.0, 155.0, 158.0, 151.0, 138.0, 158.0, 175.0, 168.0, 167.0, 167.0, 162.0, 162.0, 158.0, 153.0, 155.0, 156.0, 170.0, 179.0, 170.0, 160.0, 167.0, 165.0, 254.0, 245.0, 196.0, 191.0, 156.0, 184.0, 186.0, 167.0, 168.0, 159.0, 157.0, 161.0, 163.0, 160.0, 166.0, 170.0, 155.0, 133.0, 148.0, 158.0, 162.0, 162.0, 165.0, 169.0, 171.0, 169.0, 155.0, 153.0, 160.0, 160.0, 140.0, 119.0, 156.0, 169.0, 162.0, 163.0, 163.0, 159.0, 159.0, 154.0, 154.0, 159.0, 169.0, 174.0, 181.0, 163.0, 170.0, 171.0, 253.0, 252.0, 209.0, 189.0, 171.0, 194.0, 186.0, 165.0, 166.0, 159.0, 152.0, 155.0, 157.0, 158.0, 163.0, 159.0, 124.0, 131.0, 151.0, 144.0, 101.0, 117.0, 153.0, 151.0, 159.0, 151.0, 106.0, 79.0, 115.0, 148.0, 143.0, 128.0, 107.0, 156.0, 163.0, 158.0, 160.0, 160.0, 159.0, 157.0, 156.0, 157.0, 166.0, 173.0, 186.0, 176.0, 167.0, 203.0, 253.0, 255.0, 228.0, 184.0, 176.0, 198.0, 188.0, 164.0, 164.0, 159.0, 149.0, 150.0, 150.0, 154.0, 163.0, 131.0, 115.0, 136.0, 133.0, 106.0, 64.0, 78.0, 130.0, 130.0, 130.0, 121.0, 102.0, 94.0, 103.0, 125.0, 148.0, 154.0, 110.0, 119.0, 163.0, 159.0, 156.0, 154.0, 156.0, 152.0, 155.0, 158.0, 166.0, 177.0, 184.0, 161.0, 189.0, 247.0, 253.0, 254.0, 248.0, 201.0, 168.0, 197.0, 190.0, 169.0, 162.0, 158.0, 148.0, 144.0, 146.0, 152.0, 151.0, 110.0, 127.0, 148.0, 146.0, 128.0, 131.0, 126.0, 120.0, 118.0, 113.0, 117.0, 131.0, 147.0, 141.0, 149.0, 159.0, 152.0, 143.0, 99.0, 140.0, 159.0, 154.0, 152.0, 152.0, 152.0, 154.0, 156.0, 165.0, 186.0, 186.0, 197.0, 247.0, 252.0, 254.0, 253.0, 253.0, 249.0, 207.0, 200.0, 196.0, 172.0, 164.0, 154.0, 147.0, 145.0, 147.0, 151.0, 129.0, 109.0, 143.0, 145.0, 152.0, 140.0, 131.0, 126.0, 115.0, 104.0, 107.0, 121.0, 128.0, 129.0, 135.0, 151.0, 152.0, 149.0, 155.0, 120.0, 115.0, 158.0, 150.0, 150.0, 153.0, 153.0, 150.0, 153.0, 166.0, 202.0, 250.0, 255.0, 254.0, 253.0, 254.0, 254.0, 253.0, 254.0, 255.0, 237.0, 199.0, 176.0, 167.0, 153.0, 143.0, 145.0, 148.0, 146.0, 110.0, 123.0, 146.0, 142.0, 151.0, 146.0, 135.0, 125.0, 121.0, 127.0, 134.0, 135.0, 134.0, 137.0, 142.0, 148.0, 154.0, 152.0, 152.0, 140.0, 107.0, 148.0, 149.0, 147.0, 152.0, 150.0, 150.0, 153.0, 173.0, 216.0, 254.0, 252.0, 255.0, 254.0, 255.0, 254.0, 254.0, 254.0, 251.0, 249.0, 210.0, 179.0, 172.0, 157.0, 146.0, 143.0, 152.0, 135.0, 102.0, 130.0, 137.0, 143.0, 152.0, 150.0, 147.0, 144.0, 150.0, 148.0, 147.0, 149.0, 153.0, 155.0, 151.0, 147.0, 145.0, 142.0, 141.0, 146.0, 121.0, 132.0, 152.0, 147.0, 150.0, 151.0, 155.0, 152.0, 181.0, 233.0, 254.0, 253.0, 255.0, 254.0, 255.0, 254.0, 255.0, 255.0, 252.0, 253.0, 227.0, 184.0, 178.0, 165.0, 147.0, 141.0, 154.0, 126.0, 109.0, 130.0, 136.0, 144.0, 155.0, 159.0, 161.0, 163.0, 162.0, 160.0, 162.0, 167.0, 170.0, 167.0, 162.0, 154.0, 146.0, 134.0, 134.0, 145.0, 132.0, 125.0, 149.0, 144.0, 146.0, 155.0, 155.0, 151.0, 196.0, 248.0, 253.0, 253.0, 255.0, 254.0, 255.0, 254.0, 255.0, 255.0, 252.0, 252.0, 242.0, 197.0, 182.0, 175.0, 147.0, 143.0, 156.0, 121.0, 120.0, 133.0, 144.0, 151.0, 154.0, 160.0, 155.0, 147.0, 146.0, 145.0, 151.0, 155.0, 157.0, 158.0, 157.0, 153.0, 149.0, 139.0, 134.0, 139.0, 135.0, 126.0, 145.0, 146.0, 146.0, 160.0, 153.0, 153.0, 218.0, 255.0, 252.0, 254.0, 255.0, 254.0, 255.0, 254.0, 255.0, 255.0, 254.0, 252.0, 253.0, 210.0, 187.0, 185.0, 150.0, 144.0, 156.0, 119.0, 130.0, 137.0, 151.0, 156.0, 141.0, 137.0, 131.0, 129.0, 126.0, 119.0, 126.0, 134.0, 137.0, 137.0, 132.0, 134.0, 141.0, 146.0, 143.0, 139.0, 137.0, 132.0, 141.0, 143.0, 152.0, 165.0, 149.0, 168.0, 241.0, 255.0, 253.0, 254.0, 255.0, 255.0, 255.0, 254.0, 255.0, 255.0, 254.0, 253.0, 255.0, 228.0, 186.0, 194.0, 154.0, 142.0, 159.0, 122.0, 126.0, 139.0, 153.0, 147.0, 124.0, 117.0, 110.0, 103.0, 106.0, 105.0, 105.0, 112.0, 112.0, 107.0, 104.0, 114.0, 120.0, 127.0, 144.0, 142.0, 139.0, 128.0, 135.0, 144.0, 156.0, 163.0, 145.0, 188.0, 251.0, 254.0, 254.0, 254.0, 255.0, 255.0, 255.0, 254.0, 255.0, 255.0, 254.0, 253.0, 254.0, 248.0, 197.0, 194.0, 164.0, 142.0, 158.0, 127.0, 122.0, 128.0, 134.0, 116.0, 84.0, 69.0, 49.0, 56.0, 85.0, 124.0, 111.0, 104.0, 84.0, 64.0, 48.0, 55.0, 73.0, 104.0, 126.0, 132.0, 130.0, 122.0, 139.0, 149.0, 159.0, 155.0, 153.0, 206.0, 252.0, 254.0, 253.0, 254.0, 255.0, 255.0, 255.0, 254.0, 255.0, 255.0, 254.0, 253.0, 252.0, 255.0, 222.0, 192.0, 174.0, 142.0, 161.0, 125.0, 128.0, 134.0, 120.0, 62.0, 19.0, 21.0, 26.0, 28.0, 30.0, 43.0, 38.0, 37.0, 39.0, 36.0, 32.0, 25.0, 18.0, 56.0, 117.0, 138.0, 138.0, 138.0, 148.0, 151.0, 161.0, 149.0, 170.0, 216.0, 253.0, 253.0, 253.0, 254.0, 255.0, 255.0, 255.0, 254.0, 255.0, 255.0, 254.0, 253.0, 253.0, 254.0, 235.0, 192.0, 182.0, 148.0, 163.0, 128.0, 130.0, 134.0, 100.0, 38.0, 24.0, 20.0, 28.0, 35.0, 41.0, 47.0, 45.0, 52.0, 57.0, 53.0, 42.0, 28.0, 22.0, 27.0, 95.0, 140.0, 139.0, 138.0, 144.0, 154.0, 156.0, 151.0, 181.0, 220.0, 255.0, 253.0, 253.0, 254.0, 255.0, 255.0, 255.0, 254.0, 255.0, 255.0, 253.0, 253.0, 252.0, 254.0, 238.0, 187.0, 186.0, 155.0, 160.0, 120.0, 122.0, 127.0, 77.0, 49.0, 54.0, 35.0, 35.0, 54.0, 59.0, 70.0, 70.0, 78.0, 81.0, 75.0, 67.0, 44.0, 34.0, 42.0, 74.0, 122.0, 124.0, 125.0, 129.0, 151.0, 152.0, 153.0, 180.0, 229.0, 255.0, 252.0, 253.0, 254.0, 255.0, 255.0, 255.0, 254.0, 255.0, 255.0, 253.0, 252.0, 250.0, 253.0, 247.0, 176.0, 185.0, 163.0, 159.0, 128.0, 116.0, 132.0, 79.0, 65.0, 77.0, 40.0, 35.0, 65.0, 80.0, 96.0, 86.0, 89.0, 99.0, 95.0, 94.0, 66.0, 52.0, 52.0, 59.0, 117.0, 133.0, 137.0, 145.0, 162.0, 152.0, 161.0, 180.0, 239.0, 255.0, 253.0, 253.0, 254.0, 255.0, 255.0, 255.0, 254.0, 255.0, 255.0, 254.0, 253.0, 252.0, 252.0, 251.0, 181.0, 174.0, 170.0, 160.0, 134.0, 114.0, 133.0, 104.0, 68.0, 83.0, 75.0, 59.0, 88.0, 100.0, 107.0, 99.0, 105.0, 111.0, 112.0, 116.0, 86.0, 85.0, 78.0, 75.0, 124.0, 131.0, 134.0, 146.0, 166.0, 158.0, 174.0, 183.0, 246.0, 254.0, 253.0, 253.0, 254.0, 255.0, 255.0, 255.0, 254.0, 255.0, 255.0, 254.0, 252.0, 253.0, 251.0, 251.0, 190.0, 169.0, 171.0, 160.0, 138.0, 115.0, 131.0, 109.0, 58.0, 92.0, 115.0, 85.0, 105.0, 106.0, 109.0, 108.0, 117.0, 120.0, 114.0, 121.0, 98.0, 116.0, 91.0, 100.0, 122.0, 118.0, 113.0, 129.0, 160.0, 160.0, 176.0, 188.0, 251.0, 252.0, 253.0, 253.0, 254.0, 255.0, 255.0];    //List ip = dt.random.random([1,48,48,1],start: 0, end: 1,dtype: 'double');
    List ip = [0,0,0,0];*/

    List op = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    ip = ListShape(ip).reshape([1, 48, 48, 1]);
    op = ListShape(op).reshape([1, 7]);
    log("Input shape${ListShape(ip).shape.toString()}");
    log("Input expected${interpreter.getInputTensors().toString()}");
    //log("Input shape${ip.runtimeType.toString()}");
    log("Output shape${ListShape(op).shape.toString()}");
    log("Output expected${interpreter.getOutputTensors().toString()}");
    interpreter.run(ip, op);
    log(op.toString());
    int max = 0;
    for (int i = 0; i < 7; i++) {
      if (op[0][max] < op[0][i]) {
        max = i;
      }
    }
    log("Index of max value: ${max.toString()}");
    log("label of max value: ${labels[max].toString()}");
    return max;
  }
}
