import 'package:login/screens/black_list.dart';
import 'package:login/utilities/scoreCandidate.dart';
import 'add_to_queue.dart';
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

Future<void> buildRecommendations(List<String> ingredients) async {
  //pick 5 ingredients from liked recipe
  final five = pickIngredients(ingredients, max: 5);
  print('five: $five');

  // fetch candidates
  final candidates = await fetchCandidates(five);
  print('candidates: ${candidates.length}');

  //score candidates
  final scored = candidates.map((c) {
    return {'recipe': c, 'score': scoreCandidate(c, five.length)};
  }).toList();
  // sort by score
  scored.sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

  final blackSet = blackList.toSet();

  int queued = 0;

  for (final entry in scored) {
    if (queued >= 3) break;

    final c = entry['recipe'] as Map;

    final ing = [
      ...(c['usedIngredients'] as List),
      ...(c['missedIngredients'] as List)
    ].map((i) => (i['name'] as String).toLowerCase()).toList();

    if (ing.any((i) => blackSet.contains(i))) {
      print('blacklisted: ${c['title']}');
      continue;
    }

    final detailList = await fetchDetails([c['id'] as int]);
    final detail = detailList.first;

    final meal = mapMealType(detail['dishTypes']);
    if (meal == null) continue;

    await addToQueue(detail, meal);

    print('${(entry['score'] as double).toStringAsFixed(3)}  ${c['title']}');

    queued++;
  }
}