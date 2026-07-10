import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/Modals/recipe.dart';
import 'recipeCache.dart';

const bool useFakeData = true;

Future<Recipe> fetchRecipe(List<String> menu, int index) async {
  // ---- TEST MODE: no API calls ----
  if (useFakeData) {
    return Recipe.fromJson({
      'title': 'Test Recipe Detail',
      'image': 'https://via.placeholder.com/556x370',
      'servings': 2,
      'summary': 'This is a fake recipe used for testing without API calls.',
      'spoonacularScore': 57.7,
      'healthScore': 14,
      'readyInMinutes': 10,
      'sourceUrl': 'https://example.com',
      'nutrition': {
        'nutrients': [
          {'name': 'Calories', 'amount': 298.4},
          {'name': 'Fat', 'amount': 1.1},
          {'name': 'Protein', 'amount': 12.0},
        ],
      },
      'extendedIngredients': [
        {'original': '2 eggs', 'name': 'eggs'},
        {'original': '1 cup spinach', 'name': 'spinach'},
      ],
      'winePairing': null,
      'diets': ['vegetarian'],
      'dishTypes': ['breakfast'],
    });
  }

  final dishName = menu[index];

  final cached = await getCachedRecipe(dishName);
  if (cached != null) {
    print('CACHE HIT: $dishName');
    return Recipe.fromJson(cached);
  }

  print('CACHE MISS: $dishName');
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?query=$dishName&number=1&apiKey=fea1e0484037450bb541f4e54a1fc370'));
  final rep = jsonDecode(response.body);
  var recipeId = rep['results'][0]['id'];

  if (response.statusCode == 200) {
    final response_2 = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/$recipeId/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));
    final rep_2 = jsonDecode(response_2.body);

    await saveCachedRecipe(dishName, rep_2);

    return Recipe.fromJson(rep_2);
  } else {
    throw Exception('Failed to load');
  }
}
