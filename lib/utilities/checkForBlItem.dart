import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/BlackList.dart';
import '../screens/Login.dart';

checkForBlItemBr() async {
  var collection = FirebaseFirestore.instance.collection('users').doc(uid).collection('breakfast');
  var snapshot = await collection.where('ingredients', arrayContainsAny: blackList).get();
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }
}

checkForBlItemLn() async {
  var collection = FirebaseFirestore.instance.collection('users').doc(uid).collection('lunch');
  var snapshot = await collection.where('ingredients', arrayContainsAny: blackList).get();
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }
}

checkForBlItemDn() async {
  var collection = FirebaseFirestore.instance.collection('users').doc(uid).collection('dinner');
  var snapshot = await collection.where('ingredients', arrayContainsAny: blackList).get();
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }
}