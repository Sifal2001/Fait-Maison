import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<int> dinnerPreFromDB = [];

getDinnerPreFromDB() async
{
  FirebaseFirestore db = FirebaseFirestore.instance;
  return db
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    dinnerPreFromDB = List<int>.from(value.get('dinnerPre') as List);
  });
}