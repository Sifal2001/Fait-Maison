import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/Login.dart';

String name = '';

Future<String> getUserName() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users').doc(uid).get();
  final data = snapshot.data();
  name = (data != null && data['name'] != null) ? data['name'].toString() : '';
  return name;
}