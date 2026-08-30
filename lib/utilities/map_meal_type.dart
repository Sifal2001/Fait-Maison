import 'dart:math';

String? mapMealType(List<dynamic> dishTypes) {
  const breakfast = {'breakfast', 'morning meal', 'brunch'};
  const pool = {'main course', 'main dish', 'lunch', 'dinner', 'soup', 'salad'};

  for (final type in dishTypes) {
    if (breakfast.contains(type)) return 'breakfast';
  }

  for (final type in dishTypes) {
    if(pool.contains(type)) {
    return Random().nextBool() ? 'lunch' : 'dinner';
    }
  }

  return null;
}

void main() {

  print(mapMealType(['breakfast', 'main course']));

  print(mapMealType(['main course', 'soup' ]));

  print(mapMealType(['dessert']));
}