import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<String> lunchMenu = [];

getLunchMenuFromDB() async {
  final snapshot =
  await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = snapshot.data();
  if (data != null && data['lunchMenu'] != null) {
    lunchMenu = List<String>.from(data['lunchMenu'] as List);
  }
}