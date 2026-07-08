import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/Login.dart';
import 'getBrRecipesForMenu.dart';

removeDinnerMenu () async
{
  FirebaseFirestore.instance.collection('users').doc(uid).set(
    {'dinnerMenu': FieldValue.delete()},
    SetOptions(
      merge: true,
    ),
  );
}