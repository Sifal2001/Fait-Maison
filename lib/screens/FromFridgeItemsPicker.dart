import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/preferencesLogged.dart';
import 'package:login/screens/showFromFridgeRecipes.dart';
import 'package:login/utilities/getDnRecipesForMenu.dart';
import 'package:login/utilities/getLnRecipesForMenu.dart';
import 'package:login/utilities/getUsername.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:login/screens/Preferences.dart';
import '../utilities/AddBlackList.dart';
import '../utilities/StringifyList.dart';
import '../utilities/checkForBlItem.dart';
import '../utilities/getBrRecipesForMenu.dart';
import '../utilities/getItemsForBlackList.dart';
import '../utilities/logOut.dart';
import 'Home.dart';
import 'Login.dart';
import 'ScanAndLearn.dart';

var _selectedVeggiesFromFridge;
var _selectedFruitsFromFridge;
List<String> FromFridgeList = [];

class FromFridgeItemPicker extends StatefulWidget {
  const FromFridgeItemPicker({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FromFridgeItemPicker> createState() => _FromFridgeItemPicker();
}

class _FromFridgeItemPicker extends State<FromFridgeItemPicker> {
  @override
  void initState() {
    super.initState();
  }

  customBoxDecoration(isActive) {
    return BoxDecoration(
      color: isActive ? Color(0xff1763DD) : Colors.white,
      border: Border(
          left: BorderSide(color: Colors.black12, width: 1.0),
          bottom: BorderSide(color: Colors.black12, width: 1.0),
          top: BorderSide(color: Colors.black12, width: 1.0),
          right: BorderSide(color: Colors.black12, width: 1.0)),
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
        fixedSize: const Size(50, 20),
        alignment: Alignment.center);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                name,
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
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              onTap: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPreferencesLoggedPage(title: 'Preferences')),
                );
              },
              leading: Icon(Icons.pending),
              title: Text('Preferences'),
            ),
            ListTile(
              onTap: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FromFridgeItemPicker(title: 'Home')),
                );
              },
              leading: Icon(Icons.room_service),
              title: Text('From fridge'),
            ),
            ListTile(
              onTap: ()
              {
                {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ScanAndLearn(camera: firstCamera,)),
                  // );
                }
              },
              leading: Icon(Icons.camera_alt_rounded),
              title: Text('Scan and learn'),
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
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          Container(
              margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: const Text(
                'Vegetables',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              )
          ),
          MultiSelectDialogField(
            items: veggies.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              _selectedVeggiesFromFridge = values.cast<String>();
              FromFridgeList = FromFridgeList + _selectedVeggiesFromFridge;
            },
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10.0, 00.0, 10.0, 00.0),
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              child: const Text(
                'Fruits',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              )
          ),
          MultiSelectDialogField(
            items: fruits.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              _selectedFruitsFromFridge = values.cast<String>().toList();
              FromFridgeList = FromFridgeList + _selectedFruitsFromFridge;
            },
          ),
          ElevatedButton(
          style: style,
          onPressed: () {
            stringify();
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const showFromFridgeRecipes(
            title: "From Fridge")),
            );
            },
            child: Text('Find recipes'),
          )
        ],

      ),
    );
  }

  changeState(item) {
    setState(() {
      item['isActive'] = !item['isActive'];
      print(item['isActive']);
    });
  }
}
