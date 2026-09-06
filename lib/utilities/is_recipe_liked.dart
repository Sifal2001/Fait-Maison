import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'getLikes.dart';

Future<bool> isRecipeLiked() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if(uid == null) return false;

  final snapshot = await FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .collection('likedRecipes')
    .doc(doc_path)
    .get();

  return snapshot.exists;
}