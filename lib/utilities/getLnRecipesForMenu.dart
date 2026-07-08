import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<String> lnMenu_r = [];

getLnRecepiesForMenu() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('lunch')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      lunch_r.add(doc['name']);
    });
    for (int i = 0; i < 7;) {
      Random random = Random();
      int randomNumber = random.nextInt(lunch_r.length);
      lnMenu_r.add(lunch_r[randomNumber]);
      lunch_r.remove(lunch_r[randomNumber]);
      i++;
    }
  }).then((value) => print(lnMenu_r));
}


List<String> lunch_r = [];