import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ingredientPickerProvider =
    FutureProvider<Map<String, List<String>>>((ref) async {
  final raw = await rootBundle.loadString('assets/ingredient_categories.json');
  final decoded = jsonDecode(raw) as Map<String, dynamic>;
  return decoded.map((key, value) => MapEntry(key, List<String>.from(value)));
});
