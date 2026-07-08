class FirstRecipeFromFridge{
  final String title;
  final num servings;
  final num score;
  final num healthScore;
  final String instructions;

  const FirstRecipeFromFridge({
    required this.title,
    required this.servings,
    required this.score,
    required this.healthScore,
    required this.instructions,
  });

  factory FirstRecipeFromFridge.fromJson(Map<String, dynamic> json) {
    return FirstRecipeFromFridge(
      title: json['title'],
      servings: json['servings'],
      score: json['spoonacularScore'],
      healthScore: json['healthScore'],
      instructions: json['sourceUrl'],
    );

  }
}
