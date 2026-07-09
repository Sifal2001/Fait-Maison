import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

List<int> breakfastPreFromDB = [];

getBreakfastPreFromDB() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users').doc(uid).get();
  final data = snapshot.data();
  if (data != null && data.containsKey('breakfastPre')) {
    breakfastPreFromDB = List<int>.from(data['breakfastPre'] as List);
  } else {
    breakfastPreFromDB = [];
  }
}