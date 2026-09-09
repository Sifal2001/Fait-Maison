import 'package:flutter/material.dart';
import 'package:login/screens/home.dart';
import 'package:login/utilities/get_dn_pre_from_db.dart';
import 'package:login/utilities/get_ln_pre_from_db.dart';
import '../utilities/add_br_pre.dart';
import '../utilities/add_dn_pre.dart';
import '../utilities/add_ln_pre.dart';
import '../utilities/generate_menu.dart';
import '../utilities/get_br_pref_from_db.dart';
import '../utilities/seed_queue_from_pool.dart';

List<int> breakfastPre = [];
List<int> lunchPre = [];
List<int> dinnerPre = [];

class MyPreferencesPage extends StatefulWidget {
  const MyPreferencesPage({super.key, required this.title});

  final String title;

  @override
  State<MyPreferencesPage> createState() => _MyPreferencesPageState();
}

class _MyPreferencesPageState extends State<MyPreferencesPage> {
  bool _saved = false;
  // store the user's preferences for prep time
  static const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
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
        body: ListView(
          children: [
            for(int day = 0; day < 7; day++) ...[
            Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Text(
                      days[day],
                      style: style_title,
                    )
                )
            ),
            for(final meal in meals)
              Container(
                  margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(flex: 7, child: Text(meal)),
                      const SizedBox(width: 200,),
                      Flexible(
                          flex: 3,
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
                            items: timeOptions.map((v) =>
                              DropdownMenuItem<int>(value: v, child: Text(v.toString()))).
                            toList(),
                          ),
                      ),
                    ],
                  )
              ),
            ],
            ElevatedButton(
                style: style,
                onPressed: () async {
                  breakfastPre.clear();
                  lunchPre.clear();
                  dinnerPre.clear();

                  breakfastPre = prefs['Breakfast']!;
                  lunchPre = prefs['Lunch']!;
                  dinnerPre = prefs['Dinner']!;

                  await addBreakfastPre();
                  await addLunchPre();
                  await addDinnerPre();

                  setState(() => _saved = true);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preferences saved')));
                },
                child: const Text("Save")),
            ElevatedButton(
                onPressed: _saved
                    ? () async {
                        await getBreakfastPreFromDB();
                        await getLunchPreFromDB();
                        await getDinnerPreFromDB();

                        await seedQueueFromPool('Breakfast_r', 'queue_breakfast');
                        await seedQueueFromPool('Lunch_r', 'queue_lunch');
                        await seedQueueFromPool('Dinner_r', 'queue_dinner');

                        await generateMenu('queue_breakfast', 'breakfastMenu', breakfastPre);
                        await generateMenu('queue_lunch', 'lunchMenu', lunchPre);
                        await generateMenu('queue_dinner', 'dinnerMenu', dinnerPre);
                        if(!mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MyHomePage(title: "Home")),
                        );
                      }
                    : null,
                child: const Text("Next"))
          ],
        )
    );
  }
}
