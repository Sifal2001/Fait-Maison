import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/utilities/getDnRecipesForMenu.dart';
import 'package:login/utilities/getLnRecipesForMenu.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:login/screens/Preferences.dart';
import '../utilities/AddBlackList.dart';
import '../utilities/addRecipes.dart';
import '../utilities/checkForBlItem.dart';
import '../utilities/getBrRecipesForMenu.dart';
import '../utilities/getItemsForBlackList.dart';
import 'package:google_fonts/google_fonts.dart';

var _selectedVeggies;
var _selectedFruits ;

List<String> blackList = [];

class BlackList extends StatefulWidget {
  const BlackList({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.flutter pub add multi_select_flutter

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<BlackList> createState() => _BlackList();
}

class _BlackList extends State<BlackList> {
  @override
  void initState() {
    super.initState();
    addRecipes();
    addLunchRecipes();
    addDinnerRecipes();
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
        fixedSize: const Size(80, 60),
        alignment: Alignment.center);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
      Container(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent
      margin: const EdgeInsets.fromLTRB(0,8,0,8),
      padding: const EdgeInsets.fromLTRB(0,40,0,40),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(232, 133, 22, 0.6),
        boxShadow: [
          BoxShadow(
              color: Colors.grey ,
              blurRadius: 2.0,
              offset: Offset(1.0,1.0)
          )
        ],
        gradient: LinearGradient(
            colors: [
              Colors.lightBlue,
              Colors.blueAccent
            ]
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
        child:Text(
          "Select ingredients you hate to see on your plate, we'll make sure you never get recipes that contains them",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20)),
        ),
      ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              alignment: Alignment.centerLeft,
              child:Text(
                'Vegetables',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 28)),
              )
          ),
          MultiSelectDialogField(
            items: veggies.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              _selectedVeggies = values.cast<String>();
              blackList = blackList + _selectedVeggies;
            },
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color:Colors.red, width: 1)
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'Fruits',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 28)
                ),
              ),
          ),
          MultiSelectDialogField(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color:Colors.red, width: 1)
              ),
            ),
            items: fruits.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              _selectedFruits = values.cast<String>().toList();
              blackList = blackList + _selectedFruits;
            },
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              alignment: Alignment.centerLeft,
              child:Text(
                'Meat, poultry and fish',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 28)),
              )
          ),
          MultiSelectDialogField(
            items: veggies.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              _selectedVeggies = values.cast<String>();
              blackList = blackList + _selectedVeggies;
            },
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color:Colors.red, width: 1)
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            alignment: Alignment.centerLeft,
            child: Text(
              'grains',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 28)
              ),
            ),
          ),
          MultiSelectDialogField(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color:Colors.red, width: 1)
              ),
            ),
            items: fruits.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              _selectedFruits = values.cast<String>().toList();
              blackList = blackList + _selectedFruits;
            },
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              alignment: Alignment.centerLeft,
              child:Text(
                'Dairy and alternatives',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 28)),
              )
          ),
          MultiSelectDialogField(
            items: veggies.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              _selectedVeggies = values.cast<String>();
              blackList = blackList + _selectedVeggies;
            },
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color:Colors.red, width: 1)
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            alignment: Alignment.centerLeft,
            child: Text(
              'Oils and fats',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 28)
              ),
            ),
          ),
          MultiSelectDialogField(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color:Colors.red, width: 1)
              ),
            ),
            items: fruits.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              _selectedFruits = values.cast<String>().toList();
              blackList = blackList + _selectedFruits;
            },
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          ),
          ElevatedButton(
            style: style,
            onPressed: () async{
              addBlackList();
              print(blackList);
              checkForBlItemBr();
              checkForBlItemLn();
              checkForBlItemDn();
              await getBrRecepiesForMenu();
              await getLnRecepiesForMenu();
              await getDnRecepiesForMenu();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyPreferencesPage(
                    title: "Preferences")),
              );
            },
            child: Text("Next"),
          ),
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