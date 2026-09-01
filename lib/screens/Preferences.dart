import 'package:flutter/material.dart';
import 'package:login/screens/Home.dart';
import 'package:login/utilities/addDinnerMenu.dart';
import 'package:login/utilities/addLunchMenu.dart';
import 'package:login/utilities/getDinnerMenuFromDB.dart';
import 'package:login/utilities/getDinnerPreFromDB.dart';
import 'package:login/utilities/getLunchMenuFromDB.dart';
import 'package:login/utilities/getLunchPreFromDB.dart';
import '../utilities/addBreakfastMenu.dart';
import '../utilities/addBreakfastPre.dart';
import '../utilities/addDinnerPre.dart';
import '../utilities/addLunchPre.dart';
import '../utilities/generate_menu.dart';
import '../utilities/getBreakfastMenuFromDB.dart';
import '../utilities/getBreakfastPrefFromDB.dart';


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
  @override
  void initState() {
    super.initState();
  }

  final ButtonStyle style =
  ElevatedButton.styleFrom(
      backgroundColor: Colors.green);

  int MBValue = 15;
  int MLValue = 30;
  int MDValue = 30;
  int TBValue = 15;
  int TLValue = 30;
  int TDValue = 30;
  int WBValue = 15;
  int WLValue = 30;
  int WDValue = 30;
  int ThBValue = 15;
  int ThLValue = 30;
  int ThDValue = 30;
  int FBValue = 15;
  int FLValue = 30;
  int FDValue = 30;
  int SBValue = 15;
  int SLValue = 30;
  int SDValue = 30;
  int SuBValue = 15;
  int SuLValue = 30;
  int SuDValue = 30;

  final TextStyle style_title =
  const TextStyle(fontSize: 28);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Text('Monday',
                      style: style_title,
                    )
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Brakfast")
                    ),
                    const SizedBox(width: 200,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: MBValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              MBValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Lunch")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: MLValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              MLValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Dinner")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: MDValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              MDValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Text('Tuesday',
                      style: style_title,
                    )
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Brakfast")
                    ),
                    const SizedBox(width: 200,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: TBValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              TBValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Lunch")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: TLValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              TLValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Dinner")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: TDValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              TDValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Text('Wednesday',
                      style: style_title,
                    )
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Brakfast")
                    ),
                    const SizedBox(width: 200,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: WBValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              WBValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Lunch")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: WLValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              WLValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Dinner")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: WDValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              WDValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Text('Thursday',
                      style: style_title,
                    )
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Brakfast")
                    ),
                    const SizedBox(width: 200,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: ThBValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              ThBValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Lunch")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: ThLValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              ThLValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Dinner")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: ThDValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              ThDValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Text('Friday',
                      style: style_title,
                    )
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Brakfast")
                    ),
                    const SizedBox(width: 200,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: FBValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              FBValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Lunch")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: FLValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              FLValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Dinner")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: FDValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              FDValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Text('Saturday',
                      style: style_title,
                    )
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Brakfast")
                    ),
                    const SizedBox(width: 200,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: SBValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              SBValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Lunch")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: SLValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              SLValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Dinner")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: SDValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              SDValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: Text('Sunday',
                      style: style_title,
                    )
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Brakfast")
                    ),
                    const SizedBox(width: 200,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: SuBValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              SuBValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Lunch")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: SuLValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              SuLValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Flexible(
                        flex: 7,
                        child: Text("Dinner")
                    ),
                    const SizedBox(width: 218,),
                    Flexible(
                        flex: 3,
                        child: DropdownButton<int>(
                          value: SuDValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (int? newValue) {
                            setState(() {
                              SuDValue = newValue!;
                            });
                          },
                          items: <int>[10, 15, 30, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                    )
                  ],
                )
            ),
            ElevatedButton(
                style: style,
                onPressed: () async {
                  breakfastPre.clear();
                  lunchPre.clear();
                  dinnerPre.clear();
                  breakfastPre.add(MBValue);
                  breakfastPre.add(TBValue);
                  breakfastPre.add(WBValue);
                  breakfastPre.add(ThBValue);
                  breakfastPre.add(FBValue);
                  breakfastPre.add(SBValue);
                  breakfastPre.add(SuBValue);
                  lunchPre.add(MLValue);
                  lunchPre.add(TLValue);
                  lunchPre.add(WLValue);
                  lunchPre.add(ThLValue);
                  lunchPre.add(FLValue);
                  lunchPre.add(SLValue);
                  lunchPre.add(SuLValue);
                  dinnerPre.add(MDValue);
                  dinnerPre.add(TDValue);
                  dinnerPre.add(WDValue);
                  dinnerPre.add(ThDValue);
                  dinnerPre.add(FDValue);
                  dinnerPre.add(SDValue);
                  dinnerPre.add(SuDValue);
                  await addBreakfastPre();
                  await addLunchPre();
                  await addDinnerPre();
                },
                child: const Text("Save")
            ),
            ElevatedButton(
                onPressed:() async
                {
                  await getBreakfastPreFromDB();
                  await getLunchPreFromDB();
                  await getDinnerPreFromDB();

                  await generateMenu('queue_breakfast', 'breakfastMenu');
                  await generateMenu('queue_lunch', 'lunchMenu');
                  await generateMenu('queue_dinner', 'dinnerMenu');

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(
                        title: "Home")),
                  );
                },
                child: const Text("next"))
          ],
        )

    );
  }
}
