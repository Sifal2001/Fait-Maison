import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';
import '../screens/Preferences.dart';

addBreakfastPre() async
{
  FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .set({
    'breakfastPref': breakfastPre,
    'LunchPref': lunchPre,
    'DinnerPref': dinnerPre
  },SetOptions(merge: true)).then((value){
  });
}