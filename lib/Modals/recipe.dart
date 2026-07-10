class Recipe {
  final String title;
  final String image;
  final String summary;
  final num servings;
  final num score;
  final num healthScore;
  final num calories;
  final num protein;
  final num fat;
  final num time;
  final String instructions;
  final List<dynamic> diets;
  final List<dynamic> types;
  final String winePairing;
  final List <Ingredient> ingredientName;


  const Recipe({
    required this.title,
    required this.servings,
    required this.score,
    required this.healthScore,
    required this.calories,
    required this.time,
    required this.protein,
    required this.fat,
    required this.ingredientName,
    required this.diets,
    required this.types,
    required this.image,
    required this.summary,
    required this.instructions,
    required this.winePairing
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ,
      servings: json['servings'],
      score: json['spoonacularScore'],
      healthScore: json['healthScore'] ,
      calories: nutrientByName(json, 'Calories'),
      protein: nutrientByName(json, 'Protein') ,
      fat: nutrientByName(json, 'Fat'),
      time: json['readyInMinutes'],
      ingredientName: parseIngredients(json),
      diets: json['diets'],
      types: json['dishTypes'],
      winePairing: json['winePairing']?['pairingText'] ?? 'Not available',
      instructions: json['sourceUrl'],
      summary: json['summary'],
      image: json['image'],
    );

  }

  static num nutrientByName(Map<String, dynamic> json, String name) {
    final nutrients = json['nutrition']['nutrients'] as List;
    final match = nutrients.firstWhere(
          (n) => n['name'] == name,
      orElse: () => {'amount': 0},
    );
    return match['amount'];
  }

  static List<Ingredient> parseIngredients(ingrJson){
    var list = ingrJson['extendedIngredients'] as List;
    List<Ingredient> ingrList = list.map((data) => Ingredient.fromJson(data)).toList();
    return ingrList;

  }

}

class Ingredient {
  final String ingredientDetails;

  Ingredient({
    required this.ingredientDetails

  });

  factory Ingredient.fromJson(Map<String, dynamic> parsedjson){
    return Ingredient(
      ingredientDetails: parsedjson['original'],
    );
  }
}