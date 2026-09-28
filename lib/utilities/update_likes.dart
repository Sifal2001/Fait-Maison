import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Modals/recipe.dart';

Future<bool> onLikeButtonTapped(bool isLiked, Recipe recipe) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return isLiked;

  final ingredients =
  recipe.ingredientName.map((i) => i.name.toLowerCase()).toList();

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('likedRecipes')
      .doc(recipe.title)
      .set({
        'id': recipe.id,
        'title': recipe.title,
        'ingredients': ingredients,
        'likedAt': FieldValue.serverTimestamp(),
  });

  return !isLiked;
}
