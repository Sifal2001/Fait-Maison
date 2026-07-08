// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:login/Modals/nutritionInformation.dart';
//
// import '../utilities/getScannedItemId.dart';
// import '../utilities/getUsername.dart';
// import '../utilities/logOut.dart';
// import 'FromFridgeItemsPicker.dart';
// import 'Home.dart';
// import 'Login.dart';
// import 'Preferences.dart';
// import 'ScanAndLearn.dart';
//
// class showNutrition extends StatefulWidget {
//   const showNutrition({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<showNutrition> createState() => _showNutrition();
// }
//
// class _showNutrition extends State<showNutrition> {
//
//   final TextStyle style_title =
//   const TextStyle(fontSize: 28);
//   final TextStyle style_Header =
//   const TextStyle(fontSize: 12);
//
//   late Future<nutritionInfrormation> futureAlbum;
//
//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchNIAlbum();
//   }
//
//   customBoxDecoration(isActive) {
//     return BoxDecoration(
//       color: isActive ? Color(0xff1763DD) : Colors.white,
//       border: Border(
//           left: BorderSide(color: Colors.black12, width: 1.0),
//           bottom: BorderSide(color: Colors.black12, width: 1.0),
//           top: BorderSide(color: Colors.black12, width: 1.0),
//           right: BorderSide(color: Colors.black12, width: 1.0)),
//       borderRadius: const BorderRadius.all(
//         Radius.circular(5.0),
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final ButtonStyle style =
//     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
//         fixedSize: const Size(50, 20),
//         alignment: Alignment.center);
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                 ),
//                 child: Text(
//                   name,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//               ListTile(
//                 onTap: ()
//                 {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home')),
//                   );
//                 },
//                 leading: Icon(Icons.home),
//                 title: Text('Home'),
//               ),
//               ListTile(
//                 onTap: ()
//                 {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const MyPreferencesPage(title: 'Preferences')),
//                   );
//                 },
//                 leading: Icon(Icons.pending),
//                 title: Text('Preferences'),
//               ),
//               ListTile(
//                 onTap: ()
//                 {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const FromFridgeItemPicker(title: 'Home')),
//                   );
//                 },
//                 leading: Icon(Icons.room_service),
//                 title: Text('From fridge'),
//               ),
//               ListTile(
//                 onTap: ()
//                 {
//                   {
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (context) => ScanAndLearn(camera: firstCamera,)),
//                     // );
//                   }
//                 },
//                 leading: Icon(Icons.camera_alt_rounded),
//                 title: Text('Scan and learn'),
//               ),
//               ListTile(
//                 onTap: ()
//                 {
//                   signOut();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const MyLoginPage(title: 'Login')),
//                   );
//                 },
//                 leading: Icon(Icons.logout),
//                 title: Text('Logout'),
//               ),
//             ],
//           ),
//         ),
//
//         body: FutureBuilder<nutritionInfrormation>(
//           future: futureAlbum,
//           builder: (context, snapshot) {
//     if (snapshot.hasData) {return ListView(
//     padding: const EdgeInsets.all(10),
//     children: <Widget>[
//     Center(
//     child:
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     Text(snapshot.data!.title.toString(),style: style_title,)
//     )
//     ),
//     Center(
//     child:
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 10.0),
//     child:
//     Text('(per medium piece)',style: style_Header,)
//     )
//     ),
//     Container(
//     decoration: BoxDecoration(
//     border: Border(
//     bottom: BorderSide(width: 2.0, color: Colors.red),
//     ),
//     color: Colors.white,
//     ),
//     child: Row(
//     children:[
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Text('Carbohydrates'),
//     ),
//     SizedBox(width: 80,),
//     Text(snapshot.data!.Carbohydrates.toString()),
//     Text('mg'),
//     ]
//     )
//     )
//     ),
//     ]
//     )
//     ),
//     Container(
//     decoration: BoxDecoration(
//     border: Border(
//     bottom: BorderSide(width: 2.0, color: Colors.red),
//     ),
//     color: Colors.white,
//     ),
//     child: Row(
//     children:[
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Text('Calories'),
//     ),
//     SizedBox(width: 120,),
//     Text(snapshot.data!.Calories.toString()),
//     Text('Kcal'),
//     ]
//     )
//     )
//     ),
//     ]
//     )
//     ),
//     Container(
//     decoration: BoxDecoration(
//     border: Border(
//     bottom: BorderSide(width: 2.0, color: Colors.red),
//     ),
//     color: Colors.white,
//     ),
//     child: Row(
//     children:[
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Text('Protein'),
//     ),
//     SizedBox(width: 126,),
//     Text(snapshot.data!.Protein.toString()),
//     Text('g'),
//     ]
//     )
//     )
//     ),
//     ]
//     )
//     ),
//     Container(
//     decoration: BoxDecoration(
//     border: Border(
//     bottom: BorderSide(width: 2.0, color: Colors.red),
//     ),
//     color: Colors.white,
//     ),
//     child: Row(
//     children:[
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Text('Fat'),
//     ),
//     SizedBox(width: 152,),
//     Text(snapshot.data!.Fat.toString()),
//     Text('g'),
//     ]
//     )
//     )
//     ),
//     ]
//     )
//     ),
//     Container(
//     decoration: BoxDecoration(
//     border: Border(
//     bottom: BorderSide(width: 2.0, color: Colors.red),
//     ),
//     color: Colors.white,
//     ),
//     child: Row(
//     children:[
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Text('Calcium'),
//     ),
//     SizedBox(width: 120,),
//     Text(snapshot.data!.Calcium.toString()),
//     Text('mg'),
//     ]
//     )
//     )
//     ),
//     ]
//     )
//     ),
//     Container(
//     decoration: BoxDecoration(
//     border: Border(
//     bottom: BorderSide(width: 2.0, color: Colors.red),
//     ),
//     color: Colors.white,
//     ),
//     child: Row(
//     children:[
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Text('Fiber'),
//     ),
//     SizedBox(width: 140,),
//     Text(snapshot.data!.Fiber.toString()),
//     Text('g'),
//     ]
//     )
//     )
//     ),
//     ]
//     )
//     ),
//     Container(
//     decoration: BoxDecoration(
//     border: Border(
//     bottom: BorderSide(width: 2.0, color: Colors.red),
//     ),
//     color: Colors.white,
//     ),
//     child: Row(
//     children:[
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Text('Sugar'),
//     ),
//     SizedBox(width: 138,),
//     Text(snapshot.data!.Sugar.toString()),
//     Text('g'),
//     ]
//     )
//     )
//     ),
//     ]
//     )
//     ),
//     Container(
//     decoration: BoxDecoration(
//     border: Border(
//     bottom: BorderSide(width: 2.0, color: Colors.red),
//     ),
//     color: Colors.white,
//     ),
//     child: Row(
//     children:[
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Text('Vitamine D'),
//     ),
//     SizedBox(width: 100,),
//     Text(snapshot.data!.VitaminD.toString()),
//     Text('mg'),
//     ]
//     )
//     )
//     ),
//     ]
//     )
//     ),
//     Container(
//     decoration: BoxDecoration(
//     border: Border(
//     bottom: BorderSide(width: 2.0, color: Colors.red),
//     ),
//     color: Colors.white,
//     ),
//     child: Row(
//     children:[
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(20.0),
//     child:
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//     children: [
//     Container(
//     margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Text('Vitamine A'),
//     ),
//     SizedBox(width: 100,),
//     Text(snapshot.data!.VitaminA.toString()),
//     Text('mg'),
//     ]
//     )
//     )
//     ),
//     ]
//     )
//     ),
//     ]
//     );
//     }              else if (snapshot.hasError) {
//       return Text('${snapshot.error}');
//     }
//
//     // By default, show a loading spinner.
//     return const CircularProgressIndicator();
//     }
//     )
//     );
//   }
// }

