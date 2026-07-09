import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<String> breakfastMenu = [];

getBreakfastMenuFromDB() async {
  final snapshot =
  await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = snapshot.data();
  if (data != null && data['breakfastMenu'] != null) {
    breakfastMenu = List<String>.from(data['breakfastMenu'] as List);
  }
}