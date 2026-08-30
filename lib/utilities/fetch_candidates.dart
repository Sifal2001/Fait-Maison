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
    return _fakeCandidates;
  }
  return [];
}

