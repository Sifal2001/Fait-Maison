import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<int>?> getPref(String field) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return [];

  final snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = snapshot.data();
  if (data == null || data[field] == null) return null;
  return List<int>.from(data[field]);
}
