import 'dart:convert';

import '../Modals/RecipeAlbum.dart';
import 'fetchMBRecipeAlbum.dart';
import 'getBreakfastMenuFromDB.dart';
import 'getBreakfastPreFromDB.dart';
import 'package:http/http.dart' as http;

var br_index;

Future<Recipe> fetchRecipeAlbum() async {
  final response = await http
      .get(Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=${breakfastMenu[br_index]}&number=1&apiKey=fea1e0484037450bb541f4e54a1fc370'));

  if (response.statusCode == 200) {
    final id_response = jsonDecode(response.body);
    var recipe_id = id_response['results'][0]['id'];
    final recipe_response = await http
        .get(Uri.parse('https://api.spoonacular.com/recipes/$recipe_id/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));

    final rep_2 = jsonDecode(recipe_response.body);
    return Recipe.fromJson(jsonDecode(recipe_response.body));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}