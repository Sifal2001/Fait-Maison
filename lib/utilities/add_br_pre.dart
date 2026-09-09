import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/login.dart';
import '../screens/preferences.dart';

addBreakfastPre() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .set({
    'breakfastPre': breakfastPre,
  }, SetOptions(merge: true));
}