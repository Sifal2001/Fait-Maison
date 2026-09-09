import 'package:cloud_firestore/cloud_firestore.dart';

String safeId(String dishName) => dishName.replaceAll('/', '-');

Future<Map<String, dynamic>?> getCachedRecipe(String dishName) async {
  final doc = await FirebaseFirestore.instance
      .collection('cachedRecipes')
      .doc(safeId(dishName))
      .get();

  if (doc.exists) {
    return doc.data();
  } else {
    return null;
  }
}

Future<void> saveCachedRecipe(String dishName, Map<String, dynamic> recipeJson) async {
  await FirebaseFirestore.instance
      .collection('cachedRecipes')
      .doc(safeId(dishName))
      .set(recipeJson);
}