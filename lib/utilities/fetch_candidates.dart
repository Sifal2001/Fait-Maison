import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'fetchRecipe.dart';

const List<Map<String, dynamic>> _fakeCandidates = [
  {
    'id': 643150,
    'title': 'Fluffy frittata with spinach',
    'image': 'https://img.spoonacular.com/recipes/643150-312x231.jpg',
    'unusedIngredients': [],
    'missedIngredientCount': 3,
  },
  {
    'id': 649183,
    'title': 'Lamb and Fresh Goat Cheese Roulade',
    'image': 'https://img.spoonacular.com/recipes/649183-312x231.jpg',
    'unusedIngredients': [
      {'name': 'eggs'}
    ],
    'missedIngredientCount': 2,
  },
  {
    'id': 664011,
    'title': 'Turkey Burgers',
    'image': 'https://img.spoonacular.com/recipes/664011-312x231.jpg',
    'unusedIngredients': [],
    'missedIngredientCount': 8,
  },
];

Future<List<Map<String, dynamic>>> fetchCandidates(List<String> ingredients) async {
  if (useFakeData) {
    return _fakeCandidates; // your existing fixture
  }

  final apiKey = dotenv.env['SPOONACULAR_KEY'];

  final url = Uri.https('api.spoonacular.com', '/recipes/findByIngredients', {
    'ingredients': ingredients.join(','),
    'number': '100',
    'ranking': '1',
    'ignorePantry': 'true',
    'apiKey': apiKey,
  });

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(decoded);
  } else {
    throw Exception('findByIngredients failed: ${response.statusCode}');
  }
}

