import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> isRecipeLiked(String recipeName) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if(uid == null) return false;

  final snapshot = await FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .collection('likedRecipes')
    .doc(recipeName)
    .get();

  return snapshot.exists;
}