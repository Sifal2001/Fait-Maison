import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<String> dinnerMenu = [];

getDinnerMenuFromDB() async {
  final snapshot =
  await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = snapshot.data();
  if (data != null && data['dinnerMenu'] != null) {
    dinnerMenu = List<String>.from(data['dinnerMenu'] as List);
  }
}