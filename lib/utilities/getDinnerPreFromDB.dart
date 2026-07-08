import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<int> dinnerPreFromDB = [];

getDinnerPreFromDB() async
{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  return _db
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    dinnerPreFromDB = List<int>.from(value.get('dinnerPre') as List);
  });
}