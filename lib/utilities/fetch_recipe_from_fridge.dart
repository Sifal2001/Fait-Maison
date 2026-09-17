import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<String>> fetchFridgeRecipes(String ingredients) async {
  final apiKey = dotenv.env['SPOONACULAR_KEY'];
  final url = Uri.https('api.spoonacular.com', '/recipes/findByIngredients', {
    'ingredients': ingredients,
    'number': '5',
    'ranking': '1',
    'ignorePantry': 'true',
    'apiKey': apiKey,
  });
  final response = await http.get(url);
  if (response.statusCode != 200)
    throw Exception('Failed to load fridge recipes');

  final decoded = jsonDecode(response.body) as List;
  return decoded.map((r) => r['title'] as String).toList();
}
