import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/Login.dart';

var name;

getUserName() async
{
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get()
      .then((value) {
    name = value.get('name');
  });
  return name;
}