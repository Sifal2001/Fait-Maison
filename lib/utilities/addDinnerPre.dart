import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';
import '../screens/Preferences.dart';

addDinnerPre() async
{
  FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .set({
    'dinnerPre': dinnerPre
  },SetOptions(merge: true)).then((value){
  });
}