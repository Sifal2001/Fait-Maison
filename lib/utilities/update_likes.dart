import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Modals/recipe.dart';
import '../screens/show_recipe.dart';
import 'firestore_helpers.dart';
import 'get_likes.dart';

List<String> likedIngredients = [];
int likedRecipeId = 0;

Future<bool> onLikeButtonTapped(bool isLiked) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return isLiked;

  final recipeDoc = await FirebaseFirestore.instance
      .collection(collection_path)
      .doc(doc_path)
      .get();

  final likedId = recipeDoc.get('id');
  likedRecipeId = likedId;

  final List<String> ingredients = readListField<String>(recipeDoc, 'ingredients');
  likedIngredients = ingredients;

  final String title = recipeDoc.get('title');

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('likedRecipes')
      .doc(doc_path)
      .set({
        'id': likedId,
        'title': title,
        'ingredients': ingredients,
        'likedAt': FieldValue.serverTimestamp(),
  });

  return !isLiked;
}
