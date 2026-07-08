import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/utilities/getLnRecipesForMenu.dart';

import '../screens/Login.dart';

removeLunchMenu () async
{
  FirebaseFirestore.instance.collection('users').doc(uid).set(
    {'lunchMenu': FieldValue.delete()},
    SetOptions(
      merge: true,
    ),
  );
}