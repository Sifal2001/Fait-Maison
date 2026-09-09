import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/login.dart';
import '../screens/preferences.dart';

addLunchPre() async
{
  FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .set({
    'lunchPre': lunchPre
  },SetOptions(merge: true)).then((value){
  });
}