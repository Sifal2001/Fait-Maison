import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:login/Modals/recipe.dart';
import 'firestoreHelpers.dart';
import 'getLikes.dart';

Future<bool> onLikeButtonTapped(bool isLiked) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return isLiked;

  final recipeDoc = await FirebaseFirestore.instance
      .collection(collection_path)
      .doc(doc_path)
      .get();


  final List<String> ingredients = readListField<String>(
      recipeDoc, 'ingredients');

  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('likedRecipes')
      .doc(doc_path)
      .set({
        'ingredients': ingredients,
        'likedAt': FieldValue.serverTimestamp(),
        'type': Type,
  });

  return !isLiked;
}
