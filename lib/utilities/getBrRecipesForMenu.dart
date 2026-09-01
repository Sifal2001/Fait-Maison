import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<String> brMenu_r = [];
List<String> Breakfast_r = [];

Future<void> getBrRecepiesForMenu() async {
  brMenu_r.clear();
  Breakfast_r.clear();

  final querySnapshot = await FirebaseFirestore.instance
      .collection('users').doc(uid).collection('breakfast').get();
  for (final doc in querySnapshot.docs) {
    Breakfast_r.add(doc['title']);
  }

  final count = Breakfast_r.length < 7 ? Breakfast_r.length : 7;
  final random = Random();
  for (int i = 0; i < count; i++) {
    final n = random.nextInt(Breakfast_r.length);
    brMenu_r.add(Breakfast_r[n]);
    Breakfast_r.removeAt(n);
  }
  print(brMenu_r);
}