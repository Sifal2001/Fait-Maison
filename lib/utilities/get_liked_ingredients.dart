import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firestoreHelpers.dart';

Future<List<String>> getLikedIngredients() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return [];

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('likedRecipes')
      .get();

  final List<String> ingredients = [];
  for (final doc in snapshot.docs) {
    ingredients.addAll(readListField<String>(doc, 'ingredients'));
  }
  return ingredients;
}