import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/Modals/MBRecipe.dart';
import 'getBreakfastMenuFromDB.dart';


Future<MBRecipe> fetchMBRecipeAlbum() async {
final response = await http
    .get(Uri.parse('https://api.spoonacular.com/recipes/complexSearch?query=${breakfastMenu[0]}&number=1&apiKey=fea1e0484037450bb541f4e54a1fc370'));
final rep = jsonDecode(response.body);
var recipe_id = rep['results'][0]['id'];
print(recipe_id);

if (response.statusCode == 200) {
  final response_2 = await http
      .get(Uri.parse('https://api.spoonacular.com/recipes/$recipe_id/information?includeNutrition=true&apiKey=fea1e0484037450bb541f4e54a1fc370'));

  final rep_2 = jsonDecode(response_2.body);

  return MBRecipe.fromJson(rep_2);

} else {
  // If the server did not return a 200 OK response,
  // then throw an exception.
  throw Exception('Failed to load');
}
}



