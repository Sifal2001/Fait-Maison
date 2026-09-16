import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_helpers.dart';

Future<(bool, List<String>, int)> onLikeButtonTapped(
    bool isLiked, String recipeName, String collectionPath) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return (isLiked, <String>[], 0);

  final recipeDoc = await FirebaseFirestore.instance
      .collection(collectionPath).doc(recipeName).get();

  final int likedId = recipeDoc.get('id');
  final List<String> ingredients = readListField<String>(recipeDoc, 'ingredients');
  final String title = recipeDoc.get('title');

  await FirebaseFirestore.instance
      .collection('users').doc(uid).collection('likedRecipes')
      .doc(recipeName)
      .set({
    'id': likedId,
    'title': title,
    'ingredients': ingredients,
    'likedAt': FieldValue.serverTimestamp(),
  });

  return (!isLiked, ingredients, likedId);
}
