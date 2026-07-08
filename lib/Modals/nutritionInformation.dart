class nutritionInfrormation {
  final String title;
  final num Carbohydrates;
  final num Calories;
  final num Protein;
  final num Fat;
  final num Calcium;
  final num Fiber;
  final num Sugar;
  final num VitaminD;
  final num VitaminA;

  const nutritionInfrormation({
    required this.title,
    required this.Carbohydrates,
    required this.Calories,
    required this.Protein,
    required this.Fat,
    required this.Calcium,
    required this.Fiber,
    required this.Sugar,
    required this.VitaminA,
    required this.VitaminD
  });

  factory nutritionInfrormation.fromJson(Map<String, dynamic> json) {
    return nutritionInfrormation(
      title: json['originalName'],
      Carbohydrates: json['nutrition']['nutrients'][28]['amount'],
      Calories: json['nutrition']['nutrients'][34]['amount'],
      Protein: json['nutrition']['nutrients'][37]['amount'],
      Fat: json['nutrition']['nutrients'][38]['amount'],
      Calcium: json['nutrition']['nutrients'][31]['amount'],
      Fiber: json['nutrition']['nutrients'][24]['amount'],
      Sugar: json['nutrition']['nutrients'][2]['amount'],
      VitaminD: json['nutrition']['nutrients'][9]['amount'],
      VitaminA: json['nutrition']['nutrients'][11]['amount'],
    );
  }
}