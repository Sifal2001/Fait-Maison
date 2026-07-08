import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/Login.dart';
import 'getBrRecipesForMenu.dart';

removeBreakfastMenu () async
{
  FirebaseFirestore.instance.collection('users').doc(uid).set(
    {'breakfastMenu': FieldValue.delete()},
    SetOptions(
      merge: true,
    ),
  );
}