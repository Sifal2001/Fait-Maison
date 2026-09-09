import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/Preferences.dart';
import 'package:login/screens/login.dart';
import 'package:login/screens/app_background.dart';
import 'package:login/screens/preferences_logged.dart';
import 'package:login/utilities/generate_menu.dart';
import 'package:login/utilities/get_br_menu_from_db.dart';
import 'package:login/utilities/get_br_pref_from_db.dart';
import 'package:login/utilities/get_dn_menu_from_db.dart';
import 'package:login/utilities/get_ln_menu_from_db.dart';
import 'package:login/utilities/get_ln_pre_from_db.dart';
import 'package:login/utilities/seeder.dart';
import '../utilities/get_dn_pre_from_db.dart';
import '../utilities/get_username.dart';
import 'from_fridge_item_picker.dart';
import 'package:login/utilities/log_out.dart';
import 'package:login/modals/day_menu.dart';

import 'meal_card.dart';

late var firstCamera;


void camera() async {
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
  int _menuVersion = 0;

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
    setState(() {
      weeklyMenu = buildWeeklyMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      backgroundColor: Colors.redAccent,
      fixedSize: const Size(128, 40),
      alignment: Alignment.center,
    );
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
                onTap: () async {
                  //await seedPool('breakfast', 'Breakfast_r');
                  //await seedPool('main course', 'Lunch_r');
                  //await seedPool('main course', 'Dinner_r', offset: 50);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyPreferencesLoggedPage(
                            title: 'Preferences')),
                  );
                },
                leading: const Icon(Icons.pending),
                title: const Text('Preferences'),
              ),
              ListTile(
                onTap: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Generate a new menu'),
                      content: const Text(
                        'This will generate a new weekly menu. Are you sure you want to continue?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Generate'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed != true) return;

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const AlertDialog(
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 20),
                          Text('Generating menu...'),
                        ],
                      ),
                    ),
                  );

                  try {
                    await getBreakfastPreFromDB();
                    await getLunchPreFromDB();
                    await getDinnerPreFromDB();
                    await generateMenu('queue_breakfast', 'breakfastMenu', breakfastPreFromDB);
                    await generateMenu('queue_lunch', 'lunchMenu', lunchPreFromDB);
                    await generateMenu('queue_dinner', 'dinnerMenu', dinnerPreFromDB);
                    await _loadWeek();

                    if (mounted) {
                      Navigator.pop(context);
                      setState(() => _menuVersion++);
                    }
                  } catch (e) {
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not generate menu: $e')),
                      );
                    }
                  }
                },
                leading: const Icon(Icons.refresh),
                title: const Text('Generate menu'),
              ),
              ListTile(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FromFridgeItemPicker(title: 'FromFridge')),
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
              ListTile(
                onTap: () {
                  signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyLoginPage(title: 'Login')),
                  );
                },
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
              ),
            ],
          ),
        ),
        body: AppBackground(
          child: weeklyMenu == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  key: ValueKey(_menuVersion),
                  itemCount: weeklyMenu!.days.length,
                  itemBuilder: (context, index) {
                    final dayMenu = weeklyMenu!.days[index];
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 16.0, 0.0, 0.0),
                              child: Text(
                                dayMenu.day,
                                style: const TextStyle(
                                    fontSize: 42, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          MealCard(
                              menu: breakfastMenu,
                              index: index,
                              userType: 'breakfast',
                              collectionPath: 'Breakfast_r'),
                          MealCard(
                              menu: lunchMenu,
                              index: index,
                              userType: 'lunch',
                              collectionPath: 'Lunch_r'),
                          MealCard(
                              menu: dinnerMenu,
                              index: index,
                              userType: 'dinner',
                              collectionPath: 'Dinner_r'),

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
                        ]);
                  }),
        ));
  }
}
