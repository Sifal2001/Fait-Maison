import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Map<String, double> ingredientWeights = {};

Future<void> loadIngredientWeights() async {
  final raw = await rootBundle.loadString('assets/ingredient_weights.json');
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  ingredientWeights =
      decoded.map((key, value) => MapEntry(key, (value as num).toDouble()));
}
