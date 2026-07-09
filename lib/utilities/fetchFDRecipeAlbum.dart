import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/utilities/getDinnerMenuFromDB.dart';
import '../Modals/FDRecipe.dart';


Future<FDRecipe> fetchFDRecipeAlbum() async {
  final response = await http
      .get(Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=${dinnerMenu[4]}&number=1&apiKey=fea1e0484037450bb541f4e54a1fc370'));

  if (response.statusCode == 200) {
    final rep = jsonDecode(response.body);
    var recipeId = rep['results'][0]['id'];
    final response_2 = await http
        .get(Uri.parse('https://api.spoonacular.com/recipes/$recipeId/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));

    return FDRecipe.fromJson(jsonDecode(response_2.body));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}