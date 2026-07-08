// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:login/screens/showNutrition.dart';
// import 'package:tflite/tflite.dart';
// import 'package:get/get.dart';
// import 'package:camera/camera.dart';
// import 'package:image_picker/image_picker.dart';
// import '../utilities/logOut.dart';
// import 'FromFridgeItemsPicker.dart';
// import 'Home.dart';
// import 'Login.dart';
// import 'Preferences.dart';
//
// var image_path;
// var image_content;
// String pth = 'assets/images/banane.jpg';
//
// Future<void> main() async {
//   // Ensure that plugin services are initialized so that `availableCameras()`
//   // can be called before `runApp()`
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Obtain a list of the available cameras on the device.
//   final cameras = await availableCameras();
//
//   // Get a specific camera from the list of available cameras.
//   final firstCamera = cameras.first;
//
//   runApp(
//     MaterialApp(
//       theme: ThemeData.dark(),
//       home: ScanAndLearn(
//         // Pass the appropriate camera to the TakePictureScreen widget.
//         camera: firstCamera,
//       ),
//     ),
//   );
// }
//
// class ScanAndLearn extends StatefulWidget {
//   const ScanAndLearn({Key? key, required this.camera}) : super(key: key);
//
//   final CameraDescription camera;
//
//   @override
//   State<ScanAndLearn> createState() => _ScanAndLearnState();
// }
//
// class _ScanAndLearnState extends State<ScanAndLearn> {
//
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.medium,
//     );
//     _initializeControllerFuture = _controller.initialize();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ButtonStyle style =
//     ElevatedButton.styleFrom(
//       textStyle: const TextStyle(fontSize: 20),
//       fixedSize: const Size(120, 40),
//       alignment: Alignment.center,
//       primary: Colors.redAccent,);
//     return Scaffold(
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.red,
//               ),
//               child: Text(
//                 'Username',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             ListTile(
//               onTap: ()
//               {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home')),
//                 );
//               },
//               leading: Icon(Icons.home),
//               title: Text('Home'),
//             ),
//             ListTile(
//               onTap: ()
//               {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const MyPreferencesPage(title: 'Preferences')),
//                 );
//               },
//               leading: Icon(Icons.pending),
//               title: Text('Preferences'),
//             ),
//             ListTile(
//               onTap: ()
//               {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const FromFridgeItemPicker(title: 'Home')),
//                 );
//               },
//               leading: Icon(Icons.room_service),
//               title: Text('From fridge'),
//             ),
//             ListTile(
//               onTap: ()
//               {
//                 {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) =>
//                         ScanAndLearn(camera: firstCamera,)),
//                   );
//                 }
//               },
//               leading: Icon(Icons.camera_alt_rounded),
//               title: Text('Scan and learn'),
//             ),
//             ListTile(
//               onTap: ()
//               {
//                 signOut();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const MyLoginPage(title: 'Login')),
//                 );
//               },
//               leading: Icon(Icons.room_service),
//               title: Text('Logout'),
//             ),
//           ],
//         ),
//       ),
//         body: FutureBuilder<void>(
//           future: _initializeControllerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               // If the Future is complete, display the preview.
//               return CameraPreview(_controller);
//             } else {
//               // Otherwise, display a loading indicator.
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       floatingActionButton: FloatingActionButton(
//         // Provide an onPressed callback.
//         onPressed: () async {
//           // Take the Picture in a try / catch block. If anything goes wrong,
//           // catch the error.
//           try {
//             // Ensure that the camera is initialized.
//             await _initializeControllerFuture;
//
//             // Attempt to take a picture and get the file `image`
//             // where it was saved.
//             final image = await _controller.takePicture();
//             image_path = image.path;
//             // If the picture was taken, display it on a new screen.
//             await Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => DisplayInformation(
//                   // Pass the automatically generated path to
//                   // the DisplayPictureScreen widget.
//                   imagePath: image.path,
//                 ),
//               ),
//             );
//           } catch (e) {
//             // If an error occurs, log the error to the console.
//             print(e);
//           }
//         },
//         child: const Icon(Icons.camera_alt),
//       ),
//     );
//   }
// }
//
// class DisplayInformation extends StatefulWidget {
//
//   final String imagePath;
//
//   const DisplayInformation({Key? key, required this.imagePath})
//       : super(key: key);
//
//   @override
//   State<DisplayInformation> createState() => _DisplayInformation();
// }
//
// class _DisplayInformation extends State<DisplayInformation>{
//   List? _listResult;
//   PickedFile? _imageFile;
//   bool _loading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loading = true;
//     _loadModel();
//   }
//
//   void _loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/model/model.tflite",
//       labels: "assets/classes/classes.txt",
//     ).then((value) {
//       setState(() {
//         _loading = false;
//       });
//     });
//   }
//
//   void _imageClasification() async {
//     var output = await Tflite.runModelOnImage(
//       path: image_path,
//       numResults: 1,
//       threshold: 0.1,
//       imageMean: 0.0,
//       imageStd: 255,
//     );
//     setState(() {
//       _loading = false;
//       _listResult = output;
//     });
//     print(output);
//     image_content = output![0]['label'];
//     print(image_content);
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Display the Picture')),
//       // The image is stored as a file on the device. Use the `Image.file`
//       // constructor with the given path to display the image.
//       body: Column(
//               children:<Widget>[
//                 Image.file(File(image_path)),
//                 FloatingActionButton(
//                   onPressed:(){
//                     _imageClasification();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const showNutrition(
//                           title: "Nutritional information")),
//                     );
//                   }
//                 ),
//
//       ]
//     ));
//   }
//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }
// }

