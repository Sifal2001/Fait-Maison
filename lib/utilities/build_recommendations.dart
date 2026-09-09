import 'package:login/screens/black_list.dart';
import 'package:login/utilities/score_candidate.dart';
import 'add_recipe_to_queue.dart';
import 'pick_ingredients.dart';
import 'fetch_candidates.dart';
import 'map_meal_type.dart';
import 'fetch_details.dart';

Future<void> buildRecommendations(List<String> ingredients, int likedRecipeId) async {
  //pick 5 ingredients from liked recipe
  final five = pickIngredients(ingredients, max: 5);
  print('five: $five');

  // fetch candidates
  final candidates = await fetchCandidates(five);
  print('candidates: ${candidates.length}');

  //score candidates
  final scored = candidates.map((c) {
    return {'recipe': c, 'score': scoreCandidate(c, five)};
  }).toList();
  // sort by score
  scored.sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

  for (final entry in scored) {
    final c = entry['recipe'] as Map;
    print('${(entry['score'] as double).toStringAsFixed(3)}  ${c['title']}');
  }

  final blackSet = blackList.toSet();

  //filter out candidates and pick the top 3 to add to queues
  int queued = 0;
  for (final entry in scored) {
    if (queued >= 3) break;

    final c = entry['recipe'] as Map;

    //skip the candidate if it is the same as the liked recipe
    if (c['id'] == likedRecipeId) continue;

    final ing = [
      ...(c['usedIngredients'] as List),
      ...(c['missedIngredients'] as List)
    ].map((i) => (i['name'] as String).toLowerCase()).toList();

    if (ing.any((i) => blackSet.contains(i))) {
      print('SKIP (blacklist): ${c['title']}');
      continue;
    }

    if (ing.any((i) => blackSet.contains(i))) {
      print('blacklisted: ${c['title']}');
      continue;
    }

    final detailList = await fetchDetails([c['id'] as int]);
    final detail = detailList.first;

    // skip 3: no mappable meal type
    final meal = mapMealType(detail['dishTypes']);
    if (meal == null) {
      print('SKIP (no meal type): ${c['title']} — dishTypes: ${detail['dishTypes']}');
      continue;
    }
/*    final meal = mapMealType(detail['dishTypes']);
    if (meal == null) continue;*/

    await addToQueue(detail, meal);

    print('${(entry['score'] as double).toStringAsFixed(3)}  ${c['title']}');

    queued++;
  }
}