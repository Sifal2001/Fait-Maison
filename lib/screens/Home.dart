import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/Login.dart';
import 'package:login/screens/preferencesLogged.dart';
import 'package:login/screens/showRecepie.dart';
import 'package:login/utilities/addBreakfastMenu.dart';
import 'package:login/utilities/addDinnerMenu.dart';
import 'package:login/utilities/fetchRecipe.dart';
import 'package:login/utilities/getBreakfastMenuFromDB.dart';
import 'package:login/utilities/getDinnerMenuFromDB.dart';
import 'package:login/utilities/getDnRecipesForMenu.dart';
import 'package:login/utilities/getLikes.dart';
import 'package:login/utilities/getLnRecipesForMenu.dart';
import 'package:login/utilities/getLunchMenuFromDB.dart';
import '../Modals/recipe.dart';
import '../utilities/RemoveBreakfastMenu.dart';
import '../utilities/addLunchMenu.dart';
import '../utilities/getBrRecipesForMenu.dart';
import '../utilities/getUsername.dart';
import 'FromFridgeItemsPicker.dart';
import 'package:login/utilities/logOut.dart';
import 'package:login/utilities/removeLunchMenu.dart';
import 'package:login/utilities/removeDinnerMenu.dart';

late var firstCamera;

void camera() async{
// Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  firstCamera = cameras.first;
// Get a specific camera from the list of available cameras.
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<Recipe> futureMBAlbum;
  // late Future<TBRecipe> futureTBAlbum;
  // late Future<WBRecipe> futureWBAlbum;
  // late Future<ThBRecipe> futureThBAlbum;
  // late Future<FBRecipe> futureFBAlbum;
  // late Future<SBRecipe> futureSBAlbum;
  // late Future<SuBRecipe> futureSuBAlbum;
  // late Future<MLRecipe> futureMLAlbum;
  // late Future<TLRecipe> futureTLAlbum;
  // late Future<WLRecipe> futureWLAlbum;
  // late Future<ThLRecipe> futureThLAlbum;
  // late Future<FLRecipe> futureFLAlbum;
  // late Future<SLRecipe> futureSLAlbum;
  // late Future<SuLRecipe> futureSuLAlbum;
  // late Future<MDRecipe> futureMDAlbum;
  // late Future<TDRecipe> futureTDAlbum;
  // late Future<WDRecipe> futureWDAlbum;
  // late Future<ThDRecipe> futureThDAlbum;
  // late Future<FDRecipe> futureFDAlbum;
  // late Future<SDRecipe> futureSDAlbum;
  // late Future<SuDRecipe> futureSuDAlbum;



  @override
  void initState() {
    futureMBAlbum = fetchRecipe(breakfastMenu, 0);
    // futureTBAlbum = fetchTBRecipeAlbum();
    // futureWBAlbum = fetchWBRecipeAlbum();
    // futureThBAlbum = fetchThBRecipeAlbum();
    // futureFBAlbum = fetchFBRecipeAlbum();
    // futureSBAlbum = fetchSBRecipeAlbum();
    // futureSuBAlbum = fetchSuBRecipeAlbum();
    // futureMLAlbum = fetchMLRecipeAlbum();
    // futureTLAlbum = fetchTLRecipeAlbum();
    // futureWLAlbum = fetchWLRecipeAlbum();
    // futureThLAlbum = fetchThLRecipeAlbum();
    // futureFLAlbum = fetchFLRecipeAlbum();
    // futureSLAlbum = fetchSLRecipeAlbum();
    // futureSuLAlbum = fetchSuLRecipeAlbum();
    // futureMDAlbum = fetchMDRecipeAlbum();
    // futureTDAlbum = fetchTDRecipeAlbum();
    // futureWDAlbum = fetchWDRecipeAlbum();
    // futureThDAlbum = fetchThDRecipeAlbum();
    // futureFDAlbum = fetchFDRecipeAlbum();
    // futureSDAlbum = fetchSDRecipeAlbum();
    // futureSuDAlbum = fetchSuDRecipeAlbum();
    // camera();
    getUserName().then((_) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    const TextStyle styleTitle =
    TextStyle(fontSize: 28);

    const TextStyle styleType =
    TextStyle(fontSize: 16);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              onTap: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home')),
                );
              },
              leading: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            ListTile(
              onTap: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPreferencesLoggedPage(title: 'Preferences')),
                );
              },
              leading: const Icon(Icons.pending),
              title: const Text('Preferences'),
            ),
            ListTile(
              onTap: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FromFridgeItemPicker(title: 'FromFridge')),
                );
              },
              leading: const Icon(Icons.room_service),
              title: const Text('From fridge'),
            ),
            ListTile(
              onTap: ()
              {
                {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>
                  //       ScanAndLearn(camera: firstCamera,)),
                  // );
                }
              },
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Scan and learn'),
            ),
            ListTile(
              onTap: ()
              {
                signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyLoginPage(title: 'Login')),
                );
              },
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
            ),
          ],
        ),
      ),
      body:ListView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
            children:[
              Center(
                  child:Container(
                    child:const Text("Monday",
                      style: styleTitle,
                    )
                  )
              ),
              FutureBuilder<Recipe>(
                  future: futureMBAlbum,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                    // Uncompleted State
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                      // Completed with error
                        if (snapshot.hasError) {
                          return Container(
                              child: Text(snapshot.error.toString()));
                        }
                        return Column(
                            children: <Widget>[
                              const SizedBox(height: 20),
                              GestureDetector(
                                  onTap: () async {
                                    recipeMenu = breakfastMenu;
                                    recipeIndex = 0;
                                    collection_path = 'Breakfast_r';
                                    doc_path = breakfastMenu[0];
                                    Type = 'suggestion_br_r';
                                    userType = 'breakfast';
                                    await getLikes();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                      const MyRecipePage(
                                          title: "Recipe")),
                                    );
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          4.0, 10.0, 4.0, 10.0),
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 48.0, 0.0, 48.0),
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 3.0,
                                              offset: Offset(1.0, 1.0)
                                          )
                                        ],
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.red,
                                              Colors.deepOrangeAccent
                                            ]
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                      ),
                                      child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  10.0, 10.0, 10.0, 10.0),
                                              child: Text(snapshot.data!.title.toString(),
                                                style: styleTitle,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Column(
                                                    children: [
                                                      const Text("Servings",
                                                          style: styleType
                                                      ),
                                                      Container(
                                                        decoration: const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                                width: 4.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        child: Text(
                                                            snapshot.data!
                                                                .servings
                                                                .toString()),
                                                      ),
                                                    ]
                                                ),
                                                const SizedBox(width: 24),
                                                Column(
                                                  children: [
                                                    const Text("Rating",
                                                        style: styleType
                                                    ),
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              width: 4.0,
                                                              color: Colors
                                                                  .white),
                                                        ),
                                                      ),
                                                      child: Text(
                                                          snapshot.data!.score.toString()),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 24),
                                                Column(
                                                  children: [
                                                    const Text("HScore",
                                                        style: styleType
                                                    ),
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              width: 4.0,
                                                              color: Colors
                                                                  .white),
                                                        ),
                                                      ),
                                                      child: Text(
                                                          snapshot.data!
                                                              .healthScore
                                                              .toString()),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ]
                                      )
                                  )
                              )
                            ]
                        );
                    }
                  },
              ),
              // FutureBuilder<MLRecipe>(
              //   future: futureMLAlbum,
              //   builder: (context, snapshot) {
              //     switch (snapshot.connectionState) {
              //     // Uncompleted State
              //       case ConnectionState.none:
              //       case ConnectionState.waiting:
              //         return Center(child: CircularProgressIndicator());
              //         break;
              //       default:
              //       // Completed with error
              //         if (snapshot.hasError)
              //           return Container(
              //               child: Text(snapshot.error.toString()));
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap: () async {
              //                     br_index = 0;
              //                     collection_path = 'Breakfast_r';
              //                     doc_path = breakfastMenu[0];
              //                     Type = 'suggestion_br_r';
              //                     userType = 'breakfast';
              //                     await getLikes();
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) =>
              //                       const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(
              //                           4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(
              //                           0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0, 1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children: [
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(
              //                                   10.0, 10.0, 10.0, 10.0),
              //                               child: Text(snapshot.data!.title.toString(),
              //                                 style: style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment
              //                                   .center,
              //                               children: [
              //                                 Column(
              //                                     children: [
              //                                       Text("Servings",
              //                                           style: style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(
              //                                                 width: 4.0,
              //                                                 color: Colors
              //                                                     .white),
              //                                           ),
              //                                         ),
              //                                         child: Text(
              //                                             snapshot.data!
              //                                                 .servings
              //                                                 .toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children: [
              //                                     Text("Rating",
              //                                         style: style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(
              //                                               width: 4.0,
              //                                               color: Colors
              //                                                   .white),
              //                                         ),
              //                                       ),
              //                                       child: Text(
              //                                           snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children: [
              //                                     Text("HScore",
              //                                         style: style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(
              //                                               width: 4.0,
              //                                               color: Colors
              //                                                   .white),
              //                                         ),
              //                                       ),
              //                                       child: Text(
              //                                           snapshot.data!
              //                                               .healthScore
              //                                               .toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //     }
              //   },
              // ),
              // FutureBuilder<MDRecipe>(
              //   future: futureMDAlbum,
              //   builder: (context, snapshot) {
              //     switch (snapshot.connectionState) {
              //     // Uncompleted State
              //       case ConnectionState.none:
              //       case ConnectionState.waiting:
              //         return Center(child: CircularProgressIndicator());
              //         break;
              //       default:
              //       // Completed with error
              //         if (snapshot.hasError)
              //           return Container(
              //               child: Text(snapshot.error.toString()));
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap: () async {
              //                     br_index = 0;
              //                     collection_path = 'Breakfast_r';
              //                     doc_path = breakfastMenu[0];
              //                     Type = 'suggestion_br_r';
              //                     userType = 'breakfast';
              //                     await getLikes();
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) =>
              //                       const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(
              //                           4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(
              //                           0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0, 1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children: [
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(
              //                                   10.0, 10.0, 10.0, 10.0),
              //                               child: Text(snapshot.data!.title.toString(),
              //                                 style: style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment
              //                                   .center,
              //                               children: [
              //                                 Column(
              //                                     children: [
              //                                       Text("Servings",
              //                                           style: style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(
              //                                                 width: 4.0,
              //                                                 color: Colors
              //                                                     .white),
              //                                           ),
              //                                         ),
              //                                         child: Text(
              //                                             snapshot.data!
              //                                                 .servings
              //                                                 .toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children: [
              //                                     Text("Rating",
              //                                         style: style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(
              //                                               width: 4.0,
              //                                               color: Colors
              //                                                   .white),
              //                                         ),
              //                                       ),
              //                                       child: Text(
              //                                           snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children: [
              //                                     Text("HScore",
              //                                         style: style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(
              //                                               width: 4.0,
              //                                               color: Colors
              //                                                   .white),
              //                                         ),
              //                                       ),
              //                                       child: Text(
              //                                           snapshot.data!
              //                                               .healthScore
              //                                               .toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //     }
              //   },
              // ),
              // Center(
              //     child:Container(
              //         child:Text("Tuesday",
              //           style: TextStyle(fontSize: 24),
              //         )
              //     )
              // ),
              // FutureBuilder<TBRecipe>(
              //     future: futureTBAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     br_index = 1;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title.toString(),
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<TLRecipe>(
              //     future: futureTLAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     ln_index = 1;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<TDRecipe>(
              //     future: futureTDAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     dn_index = 1;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // Center(
              //     child:Container(
              //         child:const Text("Wednesday",
              //           style: TextStyle(fontSize: 24),
              //         )
              //     )
              // ),
              // FutureBuilder<WBRecipe>(
              //     future: futureWBAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     br_index = 2;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<WLRecipe>(
              //     future: futureWLAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     ln_index = 2;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<WDRecipe>(
              //     future: futureWDAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     dn_index = 2;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // Center(
              //     child:Container(
              //         child:Text("Thursday",
              //           style: TextStyle(fontSize: 24),
              //         )
              //     )
              // ),
              // FutureBuilder<ThBRecipe>(
              //     future: futureThBAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     br_index = 3;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<ThLRecipe>(
              //     future: futureThLAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     ln_index = 3;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<ThDRecipe>(
              //     future: futureThDAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     dn_index = 3;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // Center(
              //     child:Container(
              //         child:Text("Friday",
              //           style: TextStyle(fontSize: 24),
              //         )
              //     )
              // ),
              // FutureBuilder<FBRecipe>(
              //     future: futureFBAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     br_index = 4;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<FLRecipe>(
              //     future: futureFLAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     ln_index = 4;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<FDRecipe>(
              //     future: futureFDAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     dn_index = 4;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // Center(
              //     child:Container(
              //         child:Text("Saturday",
              //           style: TextStyle(fontSize: 24),
              //         )
              //     )
              // ),
              // FutureBuilder<SBRecipe>(
              //     future: futureSBAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     br_index = 5;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<SLRecipe>(
              //     future: futureSLAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     ln_index = 5;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<SDRecipe>(
              //     future: futureSDAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     dn_index = 5;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // Center(
              //     child:Container(
              //         child:Text("Sunday",
              //           style: TextStyle(fontSize: 24),
              //         )
              //     )
              // ),
              // FutureBuilder<SuBRecipe>(
              //     future: futureSuBAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     br_index = 6;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<SuLRecipe>(
              //     future: futureSuLAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     ln_index = 6;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              // FutureBuilder<SuDRecipe>(
              //     future: futureSuDAlbum,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //             children: <Widget>[
              //               SizedBox(height: 20),
              //               GestureDetector(
              //                   onTap:(){
              //                     dn_index = 6;
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(builder: (context) => const MyRecipePage(
              //                           title: "Recipe")),
              //                     );
              //                   },
              //                   child: Container(
              //                       margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
              //                       padding: EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 48.0),
              //                       decoration: const BoxDecoration(
              //                         boxShadow: [
              //                           BoxShadow(
              //                               color: Colors.grey ,
              //                               blurRadius: 3.0,
              //                               offset: Offset(1.0,1.0)
              //                           )
              //                         ],
              //                         gradient: LinearGradient(
              //                             colors: [
              //                               Colors.red,
              //                               Colors.deepOrangeAccent
              //                             ]
              //                         ),
              //                         borderRadius: BorderRadius.all(
              //                           Radius.circular(12.0),
              //                         ),
              //                       ),
              //                       child: Column(
              //                           children:[
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //                               child:Text(snapshot.data!.title,
              //                                 style:style_title,
              //                                 textAlign: TextAlign.center,
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisAlignment: MainAxisAlignment.center,
              //                               children:[
              //                                 Column(
              //                                     children:[
              //                                       Text("Servings",
              //                                           style:style_type
              //                                       ),
              //                                       Container(
              //                                         decoration: const BoxDecoration(
              //                                           border: Border(
              //                                             bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                           ),
              //                                         ),
              //                                         child:Text(snapshot.data!.servings.toString()),
              //                                       ),
              //                                     ]
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("Rating",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.score.toString()),
              //                                     ),
              //                                   ],
              //                                 ),
              //                                 const SizedBox(width: 24),
              //                                 Column(
              //                                   children:[
              //                                     Text("HScore",
              //                                         style:style_type
              //                                     ),
              //                                     Container(
              //                                       decoration: const BoxDecoration(
              //                                         border: Border(
              //                                           bottom: BorderSide(width: 4.0, color: Colors.white),
              //                                         ),
              //                                       ),
              //                                       child:Text(snapshot.data!.healthScore.toString()),
              //                                     ),
              //                                   ],
              //                                 )
              //                               ],
              //                             )
              //                           ]
              //                       )
              //                   )
              //               )
              //             ]
              //         );
              //       }
              //       else if (snapshot.hasError) {
              //         return Text('${snapshot.error}');
              //       }
              //       // By default, show a loading spinner.
              //       return const CircularProgressIndicator();
              //     }
              // ),
              ElevatedButton(
                  onPressed: () async
                  {
                    await removeBreakfastMenu();
                    await removeLunchMenu();
                    await removeDinnerMenu();
                    await getBrRecepiesForMenu();
                    await getLnRecepiesForMenu();
                    await getDnRecepiesForMenu();
                    await addBreakfastMenu();
                    await addLunchMenu();
                    await addDinnerMenu();
                    await getBreakfastMenuFromDB();
                    await getLunchMenuFromDB();
                    await getDinnerMenuFromDB();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage(
                          title: "Home")),
                    );
                  },
                  child: const Text('generate'))
      ]
    )
    );
  }
}