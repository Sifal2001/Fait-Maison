import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List <String> lunchMenu = [];

getLunchMenuFromDB() async
{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  return _db
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    lunchMenu = List<String>.from(value.get('lunchMenu') as List);
  });
}