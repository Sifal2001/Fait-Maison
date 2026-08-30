import 'dart:math';

List<String> pickIngredients(List<String> allIngredients, {int max = 5}) {
  const stoplist = {
    'water', 'ice', 'ice cubes', 'cold water', 'warm water', 'hot water',
    'salt', 'sea salt', 'kosher salt', 'pepper', 'black pepper', 'ground pepper',
  };
  final filtered = allIngredients.where((i) => !stoplist.contains(i.toLowerCase()));
  final unique = filtered.toSet().toList();
  unique.shuffle();
  return unique.take(max).toList();
}