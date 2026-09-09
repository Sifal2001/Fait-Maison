import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/login.dart';
import '../screens/preferences.dart';

addDinnerPre() async
{
  FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .set({
    'dinnerPre': dinnerPre
  },SetOptions(merge: true)).then((value){
  });
}