import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/screens/Preferences.dart';

import '../screens/Login.dart';

removeBreakfastPre () async
{
  FirebaseFirestore.instance.collection('users').doc(uid).set(
    {'breakfastPre': FieldValue.delete()},
    SetOptions(
      merge: true,
    ),
  );

}
updateBreakfastPre() async {
  FirebaseFirestore.instance.collection('users')
    .doc(uid)
    .set({
  'breakfastPre': breakfastPre
},SetOptions(merge: true)).then((value){
});
}