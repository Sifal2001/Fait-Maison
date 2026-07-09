import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/utilities/getDinnerMenuFromDB.dart';
import '../Modals/MDRecipe.dart';




Future<MDRecipe> fetchMDRecipeAlbum() async {
  print(dinnerMenu[2]);
  final response = await http
      .get(Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=${dinnerMenu[0]}&number=1&apiKey=fea1e0484037450bb541f4e54a1fc370'));
  final rep = jsonDecode(response.body);
  var recipeId = rep['results'][0]['id'];
  if (response.statusCode == 200) {
    final response_2 = await http
        .get(Uri.parse('https://api.spoonacular.com/recipes/$recipeId/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));

    return MDRecipe.fromJson(jsonDecode(response_2.body));

  } else {
    throw Exception('Failed to load');
  }
}