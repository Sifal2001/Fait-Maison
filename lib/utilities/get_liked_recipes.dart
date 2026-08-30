import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestoreHelpers.dart';

Future<List<List<String>>> getLikedRecipes() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return [];

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('likedRecipes')
      .get();

  final List<List<String>> recipes = [];
  for (final doc in snapshot.docs) {
    recipes.add(readListField<String>(doc, 'ingredients'));
  }
  return recipes;
}