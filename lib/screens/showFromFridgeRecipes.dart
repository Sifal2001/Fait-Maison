import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:login/Modals/first_recipe_from_fridge.dart';
import 'package:login/screens/showRecepie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utilities/fetchFirstRecipeFromFridge.dart';
import '../utilities/getUsername.dart';
import 'FromFridgeItemsPicker.dart';
import 'package:login/screens/Home.dart';


class showFromFridgeRecipes extends StatefulWidget {
  const showFromFridgeRecipes({super.key, required this.title});

  final String title;

  @override
  State<showFromFridgeRecipes> createState() => _showFromFridgeRecipesState();
}

class _showFromFridgeRecipesState extends State<showFromFridgeRecipes> {

  late Future<FirstRecipeFromFridge> futureFRAlbum;

  @override
  void initState() {
    futureFRAlbum = fetchFRRecipeAlbum();
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: 'Home')),
                  );
                },
                leading: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.account_circle),
                title: const Text('Profile'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.pending),
                title: const Text('Preferences'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const FromFridgeItemPicker(
                            title: 'Home')),
                  );
                },
                leading: const Icon(Icons.room_service),
                title: const Text('From fridge'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text('Scan and learn'),
              ),
            ],
          ),
        ),
        body: ListView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            children: [
              Center(
                  child: Container(
                      child: const Text("Monday",
                        style: TextStyle(fontSize: 24),
                      )
                  )),
              FutureBuilder<FirstRecipeFromFridge>(
                  future: futureFRAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          children: <Widget>[
                            const SizedBox(height: 20),
                            GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                    const MyRecipePage(title: "Recipe")),
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
                                            child: Text(snapshot.data!.title,
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
                                                      child: Text(snapshot.data!
                                                          .servings.toString()),
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
                                                        snapshot.data!.score
                                                            .toString()),
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
                                                    child: Text(snapshot.data!
                                                        .healthScore
                                                        .toString()),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Linkify(
                                            onOpen: (link)  async{
                                              if (await canLaunch(link.url)) {
                                                await launch(link.url);
                                              } else {
                                                throw 'Could not launch $link';
                                              }
                                            },
                                            text: snapshot.data!.instructions,
                                            style: const TextStyle(color: Colors.blue),
                                            textAlign: TextAlign.center,
                                            linkStyle: const TextStyle(color: Colors.green),
                                          ),
                                        ]
                                    )
                                )
                            )
                          ]
                      );
                    }
                    else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  }
              ),
            ]
        )
    );
  }
}