import 'package:flutter/material.dart';
import 'package:login/screens/home.dart';
import 'package:login/utilities/update_pref.dart';
import '../utilities/get_username.dart';
import '../utilities/get_pref.dart';
import '../utilities/log_out.dart';
import 'from_fridge_item_picker.dart';
import 'login.dart';
import 'preferences.dart';

class MyPreferencesLoggedPage extends StatefulWidget {
  const MyPreferencesLoggedPage({super.key, required this.title});

  final String title;

  @override
  State<MyPreferencesLoggedPage> createState() =>
      _MyPreferencesLoggedPageState();
}

class _MyPreferencesLoggedPageState extends State<MyPreferencesLoggedPage> {
  static const days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  static const meals = ['Breakfast', 'Lunch', 'Dinner'];
  static const timeOptions = [20, 30, 45, 60];

  Map<String, List<int>> prefs = {
    'Breakfast': List.filled(7, 20),
    'Lunch': List.filled(7, 30),
    'Dinner': List.filled(7, 45),
  };

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final b = await getPref('breakfastPre');
    final l = await getPref('lunchPre');
    final d = await getPref('dinnerPre');
    setState(() {
      if (b != null && b.length == 7) prefs['Breakfast'] = b;
      if (l != null && l.length == 7) prefs['Lunch'] = l;
      if (d != null && d.length == 7) prefs['Dinner'] = d;
    });
  }

  final ButtonStyle style =
      ElevatedButton.styleFrom(backgroundColor: Colors.green);

  final TextStyle style_title = const TextStyle(fontSize: 28);

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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyPreferencesPage(title: 'Preferences')),
                  );
                },
                leading: const Icon(Icons.pending),
                title: const Text('Preferences'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FromFridgeItemPicker(title: 'Home')),
                  );
                },
                leading: const Icon(Icons.room_service),
                title: const Text('From fridge'),
              ),
              ListTile(
                onTap: () {
                  {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ScanAndLearn(camera: firstCamera,)),
                    // );
                  }
                },
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
        body: ListView(
          children: [
            for (int day = 0; day < 7; day++) ...[
              Center(
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Text(
                        days[day],
                        style: style_title,
                      ))),
              for (final meal in meals)
                Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(flex: 7, child: Text(meal)),
                        const SizedBox(
                          width: 40,
                        ),
                        Flexible(
                          flex: 2,
                          child: DropdownButton<int>(
                            value: prefs[meal]![day],
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.red),
                            underline: Container(
                              height: 2,
                              color: Colors.red,
                            ),
                            onChanged: (int? newValue) {
                              setState(() {
                                prefs[meal]![day] = newValue!;
                              });
                            },
                            items: timeOptions
                                .map((v) => DropdownMenuItem<int>(
                                    value: v, child: Text(v.toString())))
                                .toList(),
                          ),
                        ),
                      ],
                    )),
            ],
            ElevatedButton(
                style: style,
                onPressed: () async {
                  await updatePref('breakfastPre', prefs['Breakfast']!);
                  await updatePref('lunchPre', prefs['Lunch']!);
                  await updatePref('dinnerPre', prefs['Dinner']!);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preferences updated')),
                    );
                  }
                },
                child: const Text("Save")),
          ],
        ));
  }
}
