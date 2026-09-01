import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<String> dnMenu_r = [];
List<String> dinner_r = [];

Future<void> getDnRecepiesForMenu() async {
  dnMenu_r.clear();
  dinner_r.clear();

  final querySnapshot = await FirebaseFirestore.instance
      .collection('users').doc(uid).collection('dinner').get();
  for (final doc in querySnapshot.docs) {
    dinner_r.add(doc['title']);
  }

  final count = dinner_r.length < 7 ? dinner_r.length : 7;
  final random = Random();
  for (int i = 0; i < count; i++) {
    final n = random.nextInt(dinner_r.length);
    dnMenu_r.add(dinner_r[n]);
    dinner_r.removeAt(n);
  }
  print(dnMenu_r);
}