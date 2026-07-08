import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List <String> dinnerMenu = [];

getDinnerMenuFromDB() async
{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  return _db
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    dinnerMenu = List<String>.from(value.get('dinnerMenu') as List);
  });
}