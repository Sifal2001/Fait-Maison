import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/BlackList.dart';
import '../screens/Login.dart';

addBlackList () async
{
  FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update({
    'blackList': FieldValue.arrayUnion(blackList)
  });
}