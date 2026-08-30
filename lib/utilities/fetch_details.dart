import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'fetchRecipe.dart';

Future<List<Map<String, dynamic>>> fetchDetails(List<int> ids) async {
  if (useFakeData) {
    return [
      {'id': 643150, 'title': 'Fluffy frittata', 'dishTypes': ['breakfast', 'brunch']},
      {'id': 664011, 'title': 'Turkey Burgers', 'dishTypes': ['lunch', 'main course']},
      {'id': 646549, 'title': 'Ravioli', 'dishTypes': ['dessert']},
    ];
  }

  final apiKey = dotenv.env['SPOONACULAR_KEY'];
  final idString = ids.join(',');

  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/informationBulk?ids=$idString&apiKey=$apiKey'));

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(decoded);
  } else {
    throw Exception('Failed to load recipe details');
  }
}