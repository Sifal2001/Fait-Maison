import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';
import '../screens/Preferences.dart';

addLunchPre() async
{
  FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .set({
    'lunchPre': lunchPre
  },SetOptions(merge: true)).then((value){
  });
}