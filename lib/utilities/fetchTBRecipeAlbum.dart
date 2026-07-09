import 'dart:convert';
import '../Modals/TBRecipe.dart';
import 'getBreakfastMenuFromDB.dart';
import 'package:http/http.dart' as http;

Future<TBRecipe> fetchTBRecipeAlbum() async {
  final response = await http
      .get(Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=${breakfastMenu[1]}&number=1&apiKey=fea1e0484037450bb541f4e54a1fc370'));

  if (response.statusCode == 200) {
    final idResponse = jsonDecode(response.body);
    var recipeId = idResponse['results'][0]['id'];
    final recipeResponse = await http
        .get(Uri.parse('https://api.spoonacular.com/recipes/$recipeId/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));

    return TBRecipe.fromJson(jsonDecode(recipeResponse.body));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}