import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/utilities/getDnRecipesForMenu.dart';
import '../screens/Login.dart';

addDinnerMenu ()
{
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update({
    'dinnerMenu': FieldValue.arrayUnion(dnMenu_r),
  });
}