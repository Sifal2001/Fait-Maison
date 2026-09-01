import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// one-off seeder: pulls popular recipes from Spoonacular and writes them to the database
Future<void> seedPool(String mealType, String poolCollection, {int offset = 0}) async {
  final apiKey = dotenv.env['SPOONACULAR_KEY'];

  final url = Uri.https('api.spoonacular.com', '/recipes/complexSearch', {
    'type': mealType,
    'sort': 'popularity',
    'number': '30',
    'offset': offset.toString(),
    'fillIngredients': 'true',
    'apiKey': apiKey,
  });

  final response = await http.get(url);
  if (response.statusCode != 200) {
    print('seedPool failed: ${response.statusCode} ${response.body}');
    return;
  }

  String safeId(String name) {
    return name
        .replaceAll('/', '-')
        .replaceAll('\\', '-')
        .trim();
  }

  final decoded = jsonDecode(response.body);
  final results = decoded['results'] as List;

  final pool = FirebaseFirestore.instance.collection(poolCollection);

  int written = 0;
  for (final r in results) {
    final title = r['title'] as String;

    final missed = (r['missedIngredients'] as List?) ?? [];
    final used = (r['usedIngredients'] as List?) ?? [];
    final ingredients = [...missed, ...used]
        .map((i) => (i['name'] as String).toLowerCase())
        .toList();

    await pool.doc(safeId(title)).set({
      'id': r['id'],
      'title': title,
      'ingredients': ingredients,
      'love': 15,
    });
    written++;
  }

  print('seedPool: wrote $written recipes to $poolCollection (offset $offset)');
}