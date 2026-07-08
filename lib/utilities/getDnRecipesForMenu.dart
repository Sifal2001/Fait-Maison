import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<String> dnMenu_r = [];

getDnRecepiesForMenu() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('dinner')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      dinner_r.add(doc['name']);
      print(dinner_r);
    });
    for (int i = 0; i < 7;) {
      Random random = Random();
      print(dinner_r.length);
      int randomNumber = random.nextInt(dinner_r.length);
      dnMenu_r.add(dinner_r[randomNumber]);
      dinner_r.remove(dinner_r[randomNumber]);
      i++;
      print(dnMenu_r);
    }
  }).then((value) => print(dnMenu_r));
}


List<String> dinner_r = [];