import 'package:login/utilities/scoreCandidate.dart';
import 'add_to_queue.dart';
import 'get_liked_ingredients.dart';
import 'pick_ingredients.dart';
import 'fetch_candidates.dart';
import 'map_meal_type.dart';
import 'fetch_details.dart';

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
  // get liked ingredients
  final liked = await getLikedIngredients();

  // pick 5
  final five = pickIngredients(liked, max: 5);

  // fetch candidates
  final candidates = await fetchCandidates(five);

  // score + sort + take best few
  final scored = candidates.map((c) {
    return {'recipe': c, 'score': scoreCandidate(c, 5)};
  }).toList();

  scored.sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

  final best = scored.take(3).toList();

  final ids = best.map((e) => (e['recipe'] as Map)['id'] as int).toList();
  final detailed = await fetchDetails(ids);

  // route each detailed recipe to a queue
  for (final recipe in detailed) {
    final meal = mapMealType(recipe['dishTypes']);
    if (meal == null) continue;
    await addToQueue(recipe, meal);
  }
}