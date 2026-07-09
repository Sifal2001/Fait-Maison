import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/Modals/MBRecipe.dart';
import 'getBreakfastMenuFromDB.dart';

const bool useFakeData = true;

Future<MBRecipe> fetchMBRecipeAlbum() async {
  // ---- TEST MODE: return fake data, no API call ----
  if (useFakeData) {
    return MBRecipe.fromJson({
      'title': 'Test Omelette',
      'servings': 2,
      'spoonacularScore': 57.7,
      'healthScore': 14,
      'readyInMinutes': 10,
      // nutrients must have index 0, 1, and 9 present:
      'nutrition': {
        'nutrients': [
          {'name': 'Calories', 'amount': 298.4}, // [0] calories
          {'name': 'Fat', 'amount': 1.1},        // [1] fat
          {'name': 'x', 'amount': 0},             // [2]
          {'name': 'x', 'amount': 0},             // [3]
          {'name': 'x', 'amount': 0},             // [4]
          {'name': 'x', 'amount': 0},             // [5]
          {'name': 'x', 'amount': 0},             // [6]
          {'name': 'x', 'amount': 0},             // [7]
          {'name': 'x', 'amount': 0},             // [8]
          {'name': 'Protein', 'amount': 12.0},   // [9] protein
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

  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?query=${breakfastMenu[0]}&number=1&apiKey=fea1e0484037450bb541f4e54a1fc370'));
  final rep = jsonDecode(response.body);
  var recipe_id = rep['results'][0]['id'];
  print(recipe_id);

  if (response.statusCode == 200) {
    final response_2 = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/$recipe_id/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));
    final rep_2 = jsonDecode(response_2.body);
    return MBRecipe.fromJson(rep_2);
  } else {
    throw Exception('Failed to load');
  }
}