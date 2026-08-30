import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/black_list.dart';
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