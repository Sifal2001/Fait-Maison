class ThDRecipe {
  final String title;
  final String image;
  final num servings;
  final String summary;
  final num score;
  final num healthScore;
  final num calories;
  final num protein;
  final num fat;
  final num time;
  final List<dynamic> diets;
  final List<dynamic> types;
  final String instructions;
  final List <Ingredients> ingredient_name;

  const ThDRecipe({
    required this.title,
    required this.image,
    required this.servings,
    required this.summary,
    required this.score,
    required this.healthScore,
    required this.calories,
    required this.time,
    required this.protein,
    required this.fat,
    required this.instructions,
    required this.ingredient_name,
    required this.diets,
    required this.types
  });

  factory ThDRecipe.fromJson(Map<String, dynamic> json) {
    return ThDRecipe(
      title: json['title'],
      image: json['image'],
      servings: json['servings'],
      summary: json['summary'],
      score: json['spoonacularScore'],
      healthScore: json['healthScore'],
      calories: json['nutrition']['nutrients'][0]['amount'],
      protein: json['nutrition']['nutrients'][9]['amount'],
      fat: json['nutrition']['nutrients'][1]['amount'],
      time: json['readyInMinutes'],
      instructions: json['sourceUrl'],
      ingredient_name: parseImages(json),
      diets: json['diets'],
      types: json['dishTypes'],
    );

  }
  static List<Ingredients> parseImages(ingrJson){
    var list = ingrJson['extendedIngredients'] as List;
    List<Ingredients> ingr_list = list.map((data) => Ingredients.fromJson(data)).toList();
    return ingr_list;

  }
}

class Ingredients {
  final String ingredient_details;

  Ingredients({
    required this.ingredient_details

  });

  factory Ingredients.fromJson(Map<String, dynamic> parsedjson){
    return Ingredients(
      ingredient_details: parsedjson['original'],
    );
  }
}