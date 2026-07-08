import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';


List <String> breakfastMenu = [];

getBreakfastMenuFromDB() async
{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  return _db
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    breakfastMenu = List<String>.from(value.get('breakfastMenu') as List);
  });
}