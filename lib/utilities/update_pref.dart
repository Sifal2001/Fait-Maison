import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> updatePref(String field, List<int> values) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set({field: values}, SetOptions(merge: true));
}
