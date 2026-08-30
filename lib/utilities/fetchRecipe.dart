import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login/Modals/recipe.dart';
import 'recipeCache.dart';

//toggle for fake data
const bool useFakeData = false;

const String fakeDishName = 'Test Recipe Detail';

Future<Recipe> fetchRecipe(List<String> menu, int index) async {
  if (useFakeData) {
    return Recipe.fromJson({
      'title': fakeDishName,
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
        {'original': '1 cupS spinach', 'name': 'spinach'},
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
  final apiKey = dotenv.env['SPOONACULAR_KEY'];
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?query=$dishName&number=1&apiKey=$apiKey'));
  final rep = jsonDecode(response.body);

  if (response.statusCode == 200) {
    var result = rep['results'];
    if (result == null || result.isEmpty) {
      throw Exception('Failed to load');
    }
    var recipeId = rep['results'][0]['id'];
    final response_2 = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/$recipeId/information?includeNutrition=true&apiKey=$apiKey'));
    final rep_2 = jsonDecode(response_2.body);

    await saveCachedRecipe(dishName, rep_2);
    return Recipe.fromJson(rep_2);
  } else {
    throw Exception('Failed to load');
  }
}
