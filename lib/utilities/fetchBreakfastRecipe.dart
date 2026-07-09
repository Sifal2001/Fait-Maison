import 'dart:convert';

import '../Modals/RecipeAlbum.dart';
import 'fetchMBRecipeAlbum.dart';
import 'getBreakfastMenuFromDB.dart';
import 'package:http/http.dart' as http;

var br_index;

Future<Recipe> fetchRecipeAlbum() async {

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
      'winePairing': null,
      'diets': ['vegetarian'],
      'dishTypes': ['breakfast'],
    });
  }

  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?query=${breakfastMenu[br_index]}&number=1&apiKey=fea1e0484037450bb541f4e54a1fc370'));

  if (response.statusCode == 200) {
    final id_response = jsonDecode(response.body);
    var recipe_id = id_response['results'][0]['id'];
    final recipe_response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/$recipe_id/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));

    final rep_2 = jsonDecode(recipe_response.body);
    return Recipe.fromJson(jsonDecode(recipe_response.body));
  } else {
    throw Exception('Failed to load');
  }
}