import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/screens/preferences.dart';

import '../screens/login.dart';

Future<void> updatePref(String field, List<int> values) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set({field: values}, SetOptions(merge: true));
}
