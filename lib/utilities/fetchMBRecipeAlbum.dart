import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/Modals/MBRecipe.dart';
import 'getBreakfastMenuFromDB.dart';
import 'recipeCache.dart';

const bool useFakeData = true;

Future<MBRecipe> fetchMBRecipeAlbum() async {
  // ---- TEST MODE: unchanged ----
  if (useFakeData) {
    return MBRecipe.fromJson({
      'title': 'Test Omelette',
      'servings': 2,
      'spoonacularScore': 57.7,
      'healthScore': 14,
      'readyInMinutes': 10,
      'nutrition': {
        'nutrients': [
          {'name': 'Calories', 'amount': 298.4},
          {'name': 'Fat', 'amount': 1.1},
          {'name': 'x', 'amount': 0},
          {'name': 'x', 'amount': 0},
          {'name': 'x', 'amount': 0},
          {'name': 'x', 'amount': 0},
          {'name': 'x', 'amount': 0},
          {'name': 'x', 'amount': 0},
          {'name': 'x', 'amount': 0},
          {'name': 'Protein', 'amount': 12.0},
        ],
      },
      'extendedIngredients': [
        {'original': '2 eggs', 'name': 'eggs'},
        {'original': '1 cup spinach', 'name': 'spinach'},
      ],
      'diets': ['vegetarian'],
      'dishTypes': ['breakfast'],
    });
  }

  final dishName = breakfastMenu[0];

  final cached = await getCachedRecipe(dishName);
  if (cached != null) {
    print('CACHE HIT: $dishName');
    return MBRecipe.fromJson(cached);
  }

  print('CACHE MISS: $dishName');
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?query=$dishName&number=1&apiKey=fea1e0484037450bb541f4e54a1fc370'));
  final rep = jsonDecode(response.body);
  var recipe_id = rep['results'][0]['id'];

  if (response.statusCode == 200) {
    final response_2 = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/$recipe_id/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));
    final rep_2 = jsonDecode(response_2.body);

    await saveCachedRecipe(dishName, rep_2);

    return MBRecipe.fromJson(rep_2);
  } else {
    throw Exception('Failed to load');
  }
}