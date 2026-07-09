import 'dart:convert';
import 'package:login/Modals/FirstRecipeFromFridge.dart';
import 'package:http/http.dart' as http;
import 'package:login/utilities/StringifyList.dart';

var dn_index;

Future<FirstRecipeFromFridge> fetchFRRecipeAlbum() async {
  final response = await http
      .get(Uri.parse('https://api.spoonacular.com/recipes/findByIngredients?ingredients=$stringList&number=2&apiKey=fea1e0484037450bb541f4e54a1fc370'));

  if (response.statusCode == 200) {
    final idResponse = jsonDecode(response.body);
    var recipeId = idResponse[0]['id'];
    final recipeResponse = await http
        .get(Uri.parse('https://api.spoonacular.com/recipes/$recipeId/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));

    return FirstRecipeFromFridge.fromJson(jsonDecode(recipeResponse.body));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}