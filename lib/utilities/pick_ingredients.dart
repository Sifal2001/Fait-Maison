import 'dart:math';

List<String> pickIngredients(List<String> allIngredients, {int max = 5}) {
  final ingredientSet = allIngredients.toSet().toList();
  ingredientSet.shuffle(Random());

  return ingredientSet.take(max).toList();
}