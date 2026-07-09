import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';
import '../screens/Preferences.dart';

addBreakfastPre() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set({
    'breakfastPre': breakfastPre,
  }, SetOptions(merge: true));
}