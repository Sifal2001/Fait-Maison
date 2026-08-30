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
  // Fix A: pick ONE liked recipe, query with ITS ingredients (coherent).
  final recipes = await getLikedRecipes();
  if (recipes.isEmpty) return;                 // no likes yet, nothing to do

  final chosen = recipes[Random().nextInt(recipes.length)];  // random liked recipe
  print('chosen recipe ingredients: $chosen');

  final five = pickIngredients(chosen, max: 5);  // coherent + stoplisted + capped
  print('five: $five');

  final candidates = await fetchCandidates(five);
  print('candidates: ${candidates.length}');

  // --- everything below unchanged ---
  final scored = candidates.map((c) {
    return {'recipe': c, 'score': scoreCandidate(c, five.length)};
  }).toList();

  for (final entry in scored) {
    final recipe = entry['recipe'] as Map;
    print('${(entry['score'] as double).toStringAsFixed(3)}  ${recipe['title']}');
  }

  scored.sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

  final best = scored.take(3).toList();

  final ids = best.map((e) => (e['recipe'] as Map)['id'] as int).toList();
  final detailed = await fetchDetails(ids);

  for (final recipe in detailed) {
    final meal = mapMealType(recipe['dishTypes']);
    if (meal == null) continue;
    await addToQueue(recipe, meal);
  }
}