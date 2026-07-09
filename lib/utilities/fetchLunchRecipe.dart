import 'dart:convert';
import '../Modals/RecipeAlbum.dart';
import 'package:http/http.dart' as http;
import 'getLunchMenuFromDB.dart';
import 'getLunchPreFromDB.dart';

var ln_index;

Future<Recipe> fetchRecipeAlbum() async {
  final response = await http
      .get(Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=${lunchMenu[ln_index]}&number=1&maxReadyTime=${lunchPreFromDB[ln_index]}&apiKey=fea1e0484037450bb541f4e54a1fc370'));

  if (response.statusCode == 200) {
    final idResponse = jsonDecode(response.body);
    var recipeId = idResponse['results'][0]['id'];
    final recipeResponse = await http
        .get(Uri.parse('https://api.spoonacular.com/recipes/$recipeId/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));

    return Recipe.fromJson(jsonDecode(recipeResponse.body));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}