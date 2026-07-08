import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

var userBlackList;

getBlackList() async
{
  FirebaseFirestore _db = FirebaseFirestore.instance;
  return _db
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    userBlackList = List<String>.from(value.get('blackList') as List);
  });
}