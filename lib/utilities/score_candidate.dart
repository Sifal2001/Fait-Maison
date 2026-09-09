import 'ingredient_weights.dart';

double scoreCandidate(Map candidate, List<String> queryIngredients) {
  // allocate a default weight for unrecognized ingredients
  const double defaultWeight = 4.0;

  // weight of one ingredient name (map value, or default)
  double weightOf(String name) => ingredientWeights[name] ?? defaultWeight;

  // matched = the candidate's usedIngredients (overlap with query), names lowercased
  final matched = (candidate['usedIngredients'] as List)
      .map((i) => (i['name'] as String).toLowerCase())
      .toList();

  // candidate's missed ingredients (in the recipe, not in the query), names lowercased
  final missed = (candidate['missedIngredients'] as List)
      .map((i) => (i['name'] as String).toLowerCase())
      .toList();

  // NUMERATOR: sum of weights of matched ingredients
  final double matchedWeight = matched.fold(0.0, (sum, name) => sum + weightOf(name));

  // DENOMINATOR (union): query ingredients + the candidate's missed ingredients
  final unionNames = [...queryIngredients, ...missed];

  final double unionWeight = unionNames.fold(0.0, (sum, name) => sum + weightOf(name));

  // avoid divide-by-zero
  if (unionWeight == 0) return 0;

  return matchedWeight / unionWeight;
}
