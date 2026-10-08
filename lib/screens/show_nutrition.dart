import 'package:flutter/material.dart';
import '../utilities/get_nutrition.dart';

class ShowNutrition extends StatelessWidget {
  const ShowNutrition({super.key, required this.nutrition});

  final Nutrition nutrition;

  Widget _row(String label, num value, String unit) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 2.0, color: Colors.red)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text('${value.toStringAsFixed(1)} $unit',
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nutritional information')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(nutrition.title,
                  style: const TextStyle(fontSize: 28)),
            ),
          ),
          const Center(
            child: Text('(per 100 g)', style: TextStyle(fontSize: 12)),
          ),
          _row('Calories', nutrition.calories, 'kcal'),
          _row('Carbohydrates', nutrition.carbohydrates, 'g'),
          _row('Net Carbs', nutrition.netCarbs, 'g'),
          _row('Protein', nutrition.protein, 'g'),
          _row('Fat', nutrition.fat, 'g'),
          _row('Saturated Fat', nutrition.saturatedFat, 'g'),
          _row('Fiber', nutrition.fiber, 'g'),
          _row('Sugar', nutrition.sugar, 'g'),
          _row('Calcium', nutrition.calcium, 'mg'),
          _row('Vitamin A', nutrition.vitaminA, 'IU'),
          _row('Vitamin C', nutrition.vitaminC, 'mg'),
          _row('Vitamin D', nutrition.vitaminD, 'µg'),
          _row('Sodium', nutrition.sodium, 'mg'),
          _row('Potassium', nutrition.potassium, 'mg'),
          _row('Cholesterol', nutrition.cholesterol, 'mg'),
          _row('Iron', nutrition.iron, 'mg'),
          _row('Magnesium', nutrition.magnesium, 'mg'),
        ],
      ),
    );
  }
}