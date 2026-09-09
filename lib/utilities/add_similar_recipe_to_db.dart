/*
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/login.dart';
import '../screens/show_recipe.dart';
import 'getSimilarRecipe.dart';

addSimilarRecipeToDB() async {
  var recipeToAdd = await FirebaseFirestore.instance
      .collection(Type)
      .where('ingredients', arrayContains: ingredientsOfRecipeToAdd)
      .get();

  for(var recipe_doc in recipeToAdd.docs.toList()) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection(userType)
        .add(recipe_doc.data())
        .then((value) => print('done'));
  }

}*/
