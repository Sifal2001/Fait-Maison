import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addToQueue(Map<String, dynamic> recipe, String mealType) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final collectionName = 'queue_$mealType';

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(collectionName)
      .doc(recipe['id'].toString())
      .set({
        'id': recipe['id'],
        'title': recipe['title'],
        'image': recipe['image'],
        'addedAt': FieldValue.serverTimestamp(),
        'type': mealType,
  });
}