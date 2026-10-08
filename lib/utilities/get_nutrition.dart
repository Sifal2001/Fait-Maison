import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Nutrition {
  final String title;
  final double calories, protein, fat, carbohydrates, calcium,
      fiber, sugar, vitaminD, vitaminA,
      saturatedFat, netCarbs, sodium, potassium,
      cholesterol, iron, vitaminC, magnesium;

  Nutrition({
    required this.title,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
    required this.calcium,
    required this.fiber,
    required this.sugar,
    required this.vitaminD,
    required this.vitaminA,
    required this.saturatedFat,
    required this.netCarbs,
    required this.sodium,
    required this.potassium,
    required this.cholesterol,
    required this.iron,
    required this.vitaminC,
    required this.magnesium,
  });
}

Future<Nutrition?> fetchNutrition(String spoonacularName) async {
  final key = dotenv.env['SPOONACULAR_KEY']!;

  // call 1: name → id
  final searchUri = Uri.https('api.spoonacular.com',
      '/food/ingredients/search', {
        'query': spoonacularName,
        'number': '1',
        'apiKey': key,
      });
  final searchRes = await http.get(searchUri);
  if (searchRes.statusCode != 200) return null;

  final searchJson = jsonDecode(searchRes.body);
  final results = searchJson['results'] as List;
  if (results.isEmpty) return null;
  final id = results[0]['id'];

  // call 2: id → nutrition
  final infoUri = Uri.https('api.spoonacular.com',
      '/food/ingredients/$id/information', {
        'amount': '100',
        'unit': 'grams',
        'apiKey': key,
      });
  final infoRes = await http.get(infoUri);
  if (infoRes.statusCode != 200) return null;

  final infoJson = jsonDecode(infoRes.body);
  final nutrients = infoJson['nutrition']['nutrients'] as List;

  // find nutrient by name, return amount (0 if missing)
  double amountOf(String name) {
    final match = nutrients.firstWhere(
          (n) => n['name'] == name,
      orElse: () => null,
    );
    return match == null ? 0 : (match['amount'] as num).toDouble();
  }

  return Nutrition(
    title: spoonacularName,
    calories: amountOf('Calories'),
    protein: amountOf('Protein'),
    fat: amountOf('Fat'),
    saturatedFat: amountOf('Saturated Fat'),
    carbohydrates: amountOf('Carbohydrates'),
    netCarbs: amountOf('Net Carbohydrates'),
    calcium: amountOf('Calcium'),
    fiber: amountOf('Fiber'),
    sugar: amountOf('Sugar'),
    vitaminD: amountOf('Vitamin D'),
    vitaminA: amountOf('Vitamin A'),
    vitaminC: amountOf('Vitamin C'),
    sodium: amountOf('Sodium'),
    potassium: amountOf('Potassium'),
    cholesterol: amountOf('Cholesterol'),
    iron: amountOf('Iron'),
    magnesium: amountOf('Magnesium'),
  );
}