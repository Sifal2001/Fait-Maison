import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';
import 'getBrRecipesForMenu.dart';

addBreakfastMenu ()
{
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update({
    'breakfastMenu': FieldValue.arrayUnion(brMenu_r),
  });
}