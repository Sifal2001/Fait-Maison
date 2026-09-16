import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/providers/user_providers.dart';
import 'package:login/screens/login.dart';
import 'package:login/screens/app_background.dart';
import 'package:login/screens/preferences_logged.dart';
import 'package:login/utilities/generate_menu.dart';
import '../providers/menu_providers.dart';
import '../providers/pref_providers.dart';
import 'from_fridge_item_picker.dart';
import 'package:login/utilities/log_out.dart';

import 'meal_card.dart';

late var firstCamera;

void camera() async {
// Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  firstCamera = cameras.first;
// Get a specific camera from the list of available cameras.
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  static const _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  void initState() {
    super.initState();
    // camera();
  }

  @override
  Widget build(BuildContext context) {
    final breakfastMenu = ref.watch(breakfastMenuNotifierProvider);
    final lunchMenu = ref.watch(lunchMenuNotifierProvider);
    final dinnerMenu = ref.watch(dinnerMenuNotifierProvider);

    final breakfastPrefs = ref.watch(breakfastPrefProvider).value ?? [];
    final lunchPrefs = ref.watch(lunchPrefProvider).value ?? [];
    final dinnerPrefs = ref.watch(dinnerPrefProvider).value ?? [];

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
                  ref.watch(userProvider).when(
                        data: (user) => user?.name ?? 'User',
                        error: (_, __) => 'User',
                        loading: () => '...',
                      ),
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
                    final brPrefs = ref.read(breakfastPrefProvider).value ?? [];
                    final lnPrefs = ref.read(lunchPrefProvider).value ?? [];
                    final dnPrefs = ref.read(dinnerPrefProvider).value ?? [];

                    await generateMenu(
                        'queue_breakfast', 'breakfastMenu', brPrefs);
                    await generateMenu(
                        'queue_lunch', 'lunchMenu', lnPrefs);
                    await generateMenu(
                        'queue_dinner', 'dinnerMenu', dnPrefs);

                    ref.read(breakfastMenuNotifierProvider.notifier).reload();
                    ref.read(lunchMenuNotifierProvider.notifier).reload();
                    ref.read(dinnerMenuNotifierProvider.notifier).reload();

                    if (mounted) Navigator.pop(context);
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
          child: breakfastMenu.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: Text(
                                _days[index],
                                style: const TextStyle(
                                    fontSize: 42, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          MealCard(
                            menu: breakfastMenu,
                            index: index,
                            mealType: 'breakfast',
                            collectionPath: 'Breakfast_r',
                            cap: (index < breakfastPrefs.length)
                                ? breakfastPrefs[index]
                                : 60,
                          ),
                          MealCard(
                            menu: lunchMenu,
                            index: index,
                            mealType: 'lunch',
                            collectionPath: 'Lunch_r',
                            cap: (index < lunchPrefs.length)
                                ? lunchPrefs[index]
                                : 60,
                          ),
                          MealCard(
                            menu: dinnerMenu,
                            index: index,
                            mealType: 'dinner',
                            collectionPath: 'Dinner_r',
                            cap: (index < dinnerPrefs.length)
                                ? dinnerPrefs[index]
                                : 60,
                          ),
                        ]);
                  }),
        ));
  }
}
