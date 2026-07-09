import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/utilities/getLnRecipesForMenu.dart';
import '../screens/Login.dart';

addLunchMenu ()
{
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update({
    'lunchMenu': FieldValue.arrayUnion(lnMenu_r ),
  });
}