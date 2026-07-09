import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<String> lnMenu_r = [];
List<String> lunch_r = [];

Future<void> getLnRecepiesForMenu() async {
  lnMenu_r.clear();
  lunch_r.clear();

  final querySnapshot = await FirebaseFirestore.instance
      .collection('users').doc(uid).collection('lunch').get();
  for (final doc in querySnapshot.docs) {
    lunch_r.add(doc['name']);
  }

  final count = lunch_r.length < 7 ? lunch_r.length : 7;
  final random = Random();
  for (int i = 0; i < count; i++) {
    final n = random.nextInt(lunch_r.length);
    lnMenu_r.add(lunch_r[n]);
    lunch_r.removeAt(n);
  }
  print(lnMenu_r);
}