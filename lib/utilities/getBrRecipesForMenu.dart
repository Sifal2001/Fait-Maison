import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<String> brMenu_r = [];

getBrRecepiesForMenu() async {
      await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('breakfast')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Breakfast_r.add(doc['name']);
    });
    for (int i = 0; i < 3;) {
      Random random = Random();
      print(Breakfast_r.length);
      int randomNumber = random.nextInt(Breakfast_r.length);
      brMenu_r.add(Breakfast_r[randomNumber]);
      Breakfast_r.remove(Breakfast_r[randomNumber]);
      i++;
    }
  }).then((value) => print(brMenu_r));
}


List<String> Breakfast_r = [];