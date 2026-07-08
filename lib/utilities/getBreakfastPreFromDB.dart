import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<int> breakfastPreFromDB = [];

getBreakfastPreFromDB() async
{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  return _db
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    breakfastPreFromDB = List<int>.from(value.get('breakfastPre') as List);
  });
}