import 'package:login/utilities/scoreCandidate.dart';
import 'add_to_queue.dart';
import 'pick_ingredients.dart';
import 'fetch_candidates.dart';
import 'map_meal_type.dart';
import 'fetch_details.dart';
import 'get_liked_recipes.dart';
import 'dart:math';

/*Future<List<Map<String, dynamic>>> fetchDetails(List<int> ids) async {
  return [
    {'id': 643150, 'title': 'Fluffy frittata', 'dishTypes': ['breakfast', 'brunch']},
    {'id': 664011, 'title': 'Turkey Burgers', 'dishTypes': ['lunch', 'main course']},
    {'id': 646549, 'title': 'Ravioli', 'dishTypes': ['dessert']},
  ];
}*/

/*Future<void> addToQueue(Map<String, dynamic> recipe, String mealType) async {
  print('QUEUE [$mealType]: ${recipe['title']}');
}*/

Future<void> buildRecommendations() async {
  // pick ONE liked recipe, query with ITS ingredients.
  final recipes = await getLikedRecipes();
  if (recipes.isEmpty) return;
  // random liked recipe
  final chosen = recipes[Random().nextInt(recipes.length)];
  print('chosen recipe ingredients: $chosen');

  // coherent + stoplisted + capped
  final five = pickIngredients(chosen, max: 5);
  print('five: $five');

  final candidates = await fetchCandidates(five);
  print('candidates: ${candidates.length}');

  final scored = candidates.map((c) {
    return {'recipe': c, 'score': scoreCandidate(c, five.length)};
  }).toList();

  scored.sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

  for (final entry in scored) {
    final recipe = entry['recipe'] as Map;
    print('${(entry['score'] as double).toStringAsFixed(3)}  ${recipe['title']}');
  }

  final best = scored.take(3).toList();

  final ids = best.map((e) => (e['recipe'] as Map)['id'] as int).toList();
  final detailed = await fetchDetails(ids);

  for (final recipe in detailed) {
    final meal = mapMealType(recipe['dishTypes']);
    if (meal == null) continue;
    await addToQueue(recipe, meal);
  }
}