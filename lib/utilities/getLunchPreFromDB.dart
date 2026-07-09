import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List <int> lunchPreFromDB = [];

getLunchPreFromDB() async
{
  FirebaseFirestore db = FirebaseFirestore.instance;
  return db
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    lunchPreFromDB = List<int>.from(value.get('lunchPre') as List);
  });
}