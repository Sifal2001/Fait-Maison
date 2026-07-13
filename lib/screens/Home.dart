import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/Login.dart';
import 'package:login/screens/preferencesLogged.dart';
import 'package:login/utilities/addBreakfastMenu.dart';
import 'package:login/utilities/addDinnerMenu.dart';
import 'package:login/utilities/getBreakfastMenuFromDB.dart';
import 'package:login/utilities/getDinnerMenuFromDB.dart';
import 'package:login/utilities/getDnRecipesForMenu.dart';
import 'package:login/utilities/getLnRecipesForMenu.dart';
import 'package:login/utilities/getLunchMenuFromDB.dart';
import '../utilities/RemoveBreakfastMenu.dart';
import '../utilities/addLunchMenu.dart';
import '../utilities/getBrRecipesForMenu.dart';
import '../utilities/getUsername.dart';
import 'FromFridgeItemsPicker.dart';
import 'package:login/utilities/logOut.dart';
import 'package:login/utilities/removeLunchMenu.dart';
import 'package:login/utilities/removeDinnerMenu.dart';
import 'package:login/modals/day_menu.dart';

import 'meal_card.dart';

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
  WeeklyMenu? weeklyMenu;

  @override
  void initState() {
    super.initState();
    // camera();
    getUserName().then((_) {
      if (mounted) setState(() {});
    });
    _loadWeek();
}

  Future<void> _loadWeek() async {
    await getBreakfastMenuFromDB();
    await getLunchMenuFromDB();
    await getDinnerMenuFromDB();
    setState((){
      weeklyMenu = buildWeeklyMenu();
  });
}

  @override
  Widget build(BuildContext context) {
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
      body: weeklyMenu == null
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: weeklyMenu!.days.length,
          itemBuilder: (context, index) {
            final dayMenu = weeklyMenu!.days[index];
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                      child: Text(
                        dayMenu.day,
                        style: const TextStyle(
                            fontSize: 42, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  MealCard(menu: breakfastMenu, index: index, userType: 'breakfast', collectionPath: 'Breakfast_r'),
                  MealCard(menu: lunchMenu,     index: index, userType: 'lunch',     collectionPath: 'Lunch_r'),
                  MealCard(menu: dinnerMenu,    index: index, userType: 'dinner',    collectionPath: 'Dinner_r'),
                  // ElevatedButton(
                  //     onPressed: () async
                  //     {
                  //       await removeBreakfastMenu();
                  //       await removeLunchMenu();
                  //       await removeDinnerMenu();
                  //       await getBrRecepiesForMenu();
                  //       await getLnRecepiesForMenu();
                  //       await getDnRecepiesForMenu();
                  //       await addBreakfastMenu();
                  //       await addLunchMenu();
                  //       await addDinnerMenu();
                  //       await getBreakfastMenuFromDB();
                  //       await getLunchMenuFromDB();
                  //       await getDinnerMenuFromDB();
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) =>
                  //         const MyHomePage(
                  //             title: "Home")),
                  //       );
                  //     },
                  //     child: const Text('generate'))
                ]
            );
          }
        )
    );
  }
}