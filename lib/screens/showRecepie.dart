import 'package:flutter/material.dart';
import 'package:login/screens/Home.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:login/utilities/getLikes.dart';
import 'package:login/utilities/removeRecipe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:like_button/like_button.dart';
import '../Modals/recipe.dart';
import '../utilities/fetchRecipe.dart';
import '../utilities/logOut.dart';
import '../utilities/updateLikes.dart';
import 'FromFridgeItemsPicker.dart';
import 'Login.dart';
import 'Preferences.dart';

var Type;
var userType;

// Selection for the shared recipe-detail page, set before navigation.
List<String> recipeMenu = [];
int recipeIndex = 0;


class MyRecipePage extends StatefulWidget {
  const MyRecipePage({super.key, required this.title});

  final String title;

  @override
  State<MyRecipePage> createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<MyRecipePage> {

  late Future<Recipe> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchRecipe(recipeMenu, recipeIndex);
  }
  @override
  Widget build(BuildContext context) {

    const TextStyle styleTitle =
    TextStyle(fontSize: 28);

    const TextStyle styleHeader=
    TextStyle(fontSize: 24);

    const TextStyle styleInfo =
    TextStyle(fontSize: 20);

    const TextStyle styleMeasures =
    TextStyle(fontSize: 16);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text(
                  'Username',
                  style: TextStyle(
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
                    MaterialPageRoute(builder: (context) => const MyPreferencesPage(title: 'Preferences')),
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
                    MaterialPageRoute(builder: (context) => const FromFridgeItemPicker(title: 'Home')),
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
        body:
        FutureBuilder<Recipe>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        padding: const EdgeInsets.fromLTRB(00.0, 10.0, 00.0, 10.0),
                        alignment: Alignment.center,
                        child:
                          Text(snapshot.data!.title,
                          style: styleTitle,
                          )
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.network(
                              snapshot.data!.image,
                              height: 280,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const SizedBox(
                                height: 200,
                                child: Center(
                                  child: Icon(Icons.restaurant, size: 100),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                      child:
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:Row(
                        children: [
                          Column(
                            children:[
                              const Text("Calories",
                                style:styleInfo
                              ),
                              const Text("Kcal",
                                  style:styleMeasures
                              ),
                              const SizedBox(height: 12),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10.0,00.0,10.0,00.0),
                                padding: const EdgeInsets.fromLTRB(40.0,40.0,40.0,40.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 4.0, color: Colors.red),
                                  ),
                                ),
                                child:Text(snapshot.data!.calories.toString(),
                                     textAlign: TextAlign.right,
                                ),
                              ),
                            ]
                          ),
                          const SizedBox(width: 24),
                          Column(
                              children:[
                                const Text("Protein",
                                    style:styleInfo
                                ),
                                const Text("g",
                                    style:styleMeasures
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(10.0,00.0,10.0,00.0),
                                  padding: const EdgeInsets.fromLTRB(40.0,40.0,40.0,40.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: 4.0, color: Colors.green),
                                    ),
                                  ),
                                  child:Text(snapshot.data!.protein.toString(),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ]
                          ),
                          const SizedBox(width: 24),
                          Column(
                              children:<Widget>[
                                const Text("Fat",
                                    style:styleInfo
                                ),
                                const Text("g",
                                    style:styleMeasures
                                ),
                                const SizedBox(height: 8),

                                Container(
                                  margin: const EdgeInsets.fromLTRB(10.0,00.0,10.0,00.0),
                                  padding: const EdgeInsets.fromLTRB(40.0,40.0,40.0,40.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: 4.0, color: Colors.orange),
                                    ),
                                  ),
                                  child:Text(snapshot.data!.fat.toString(),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ]
                          ),
                        ],
                      ),

                      ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                      margin: const EdgeInsets.fromLTRB(40.0,00.0,36.0,00.0),
                      padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,20.0),
                      child:
                      Text("Time:${snapshot.data!.time}min",
                      textAlign: TextAlign.right,
                      style: styleMeasures,)
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.fromLTRB(40.0,00.0,20.0,00.0),
                        padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0),
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                              GestureDetector(
                                child:
                                  LikeButton(
                                    size: 20,
                                    circleColor:
                                    const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                                    bubblesColor: const BubblesColor(
                                      dotPrimaryColor: Color(0xff33b5e5),
                                      dotSecondaryColor: Color(0xff0099cc),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        Icons.favorite,
                                        color: isLiked ? Colors.red : Colors.grey,
                                        size: 20,
                                      );
                                    },
                                    likeCount: likes,
                                    countBuilder: (int? count, bool isLiked, String text) {
                                      var color = isLiked ? Colors.red : Colors.grey;
                                      Widget result;
                                      if (count == 0) {
                                        result = Text(
                                          "love",
                                          style: TextStyle(color: color),
                                        );
                                      } else {
                                        result = Text(
                                          text,
                                          style: TextStyle(color: color),
                                        );
                                      }
                                      return result;
                                    },
                                      onTap:onLikeButtonTapped
                                  ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                  icon: const Icon(Icons.delete),
                                  tooltip: 'Delete',
                                  onPressed: () {
                                    removeRecipe();
                                  }
                              )
                            ]
                        ),
                      ),
                      const Text("Ingredients",
                        textAlign: TextAlign.center,
                        style: styleHeader,
                      ),
                      const SizedBox(height:12),
                      Container(
                        child:ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.ingredientName.length,
                            itemBuilder:(BuildContext context, int index){
                              return Text(snapshot.data!.ingredientName[index].ingredientDetails.toString(),
                              style: styleMeasures,
                              textAlign: TextAlign.center);
                            }
                        )
                      ),
                      const SizedBox(height:24),
                      Container(
                          alignment: Alignment.center,
                          child:
                          const Text("Instructions",
                            style: styleHeader,
                          )
                      ),
                      const SizedBox(height:12),
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
                      const SizedBox(height:20),
                      Container(
                          margin: const EdgeInsets.fromLTRB(4.0,00.0,4.0,00.0),
                          padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(232, 133, 22, 0.6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey ,
                                  blurRadius: 3.0,
                                  offset: Offset(1.0,1.0)
                              )
                            ],
                            gradient: LinearGradient(
                                colors: [
                                  Colors.red,
                                  Colors.redAccent
                                ]
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child:
                          Column(
                              children:[
                                const Text("Summary",
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                ),
                                const SizedBox(height:20),
                                Text(snapshot.data!.summary,
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ]
                          )
                      ),
                      Container(
                      margin: const EdgeInsets.fromLTRB(4.0,4.0,4.0,4.0),
                      padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,8.0),
                      decoration: const BoxDecoration(
                      color: Color.fromRGBO(232, 133, 22, 0.6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey ,
                          blurRadius: 3.0,
                          offset: Offset(1.0,1.0)
                        )
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple,
                          Colors.purple
                        ]
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                      ),
                      child:
                      Column(
                        children:[
                          const Text("Wine recommendations",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                          const SizedBox(height:20),
                          Text(snapshot.data!.winePairing,
                             style: const TextStyle(color: Colors.black, fontSize: 16),
                             textAlign: TextAlign.center,
                          ),
                        ]
                      )
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex:5,
                                  child:Container(
                                  margin: const EdgeInsets.fromLTRB(4.0,00.0,4.0,00.0),
                                  padding: const EdgeInsets.fromLTRB(8.0,30.0,8.0,28.0),
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(232, 133, 22, 0.6),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey ,
                                          blurRadius: 3.0,
                                          offset: Offset(1.0,1.0)
                                      )
                                    ],
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.green,
                                          Colors.lightGreen
                                        ]
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                  ),
                                  child:
                                  Column(
                                      children:[
                                        const Text("Diets",
                                          style: TextStyle(color: Colors.white, fontSize: 24),
                                        ),
                                        const SizedBox(height:20),
                                        Container(
                                            child:ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: snapshot.data!.diets.length,
                                                itemBuilder:(BuildContext context, int index){
                                                  return Text('-${snapshot.data!.diets[index]}',
                                                      style: styleMeasures,
                                                      textAlign: TextAlign.center);
                                                }
                                            )
                                        ),
                                      ]
                                  )
                              ),
                          ),
                          Expanded(
                            flex:5,
                            child:Container(
                                margin: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                                padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 28.0),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(232, 133, 22, 0.6),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey ,
                                        blurRadius: 3.0,
                                        offset: Offset(1.0,1.0)
                                    )
                                  ],
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.indigoAccent,
                                        Colors.blueAccent
                                      ]
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                child:
                                Column(
                                    children:[
                                      const Text("Dish type:",
                                        style: TextStyle(color: Colors.white, fontSize: 24),
                                      ),
                                      const SizedBox(height:20),
                                      Container(
                                          child:ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.types.length,
                                              itemBuilder:(BuildContext context, int index){
                                                return Text('-${snapshot.data!.types[index]}',
                                                    style: styleMeasures,
                                                    textAlign: TextAlign.center);
                                              }
                                          )
                                      ),
                                    ]
                                )
                            ),
                          ),
                        ],
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
        )
    );
  }
}