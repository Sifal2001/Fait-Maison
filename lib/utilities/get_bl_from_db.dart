import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/login.dart';
import 'firestore_helpers.dart';

var userBlackList;

getBlackList() async
{
  FirebaseFirestore db = FirebaseFirestore.instance;
  return db
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    userBlackList = readListField<String>(value, 'blackList');
  });
}