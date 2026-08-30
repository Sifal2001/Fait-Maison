double scoreCandidate(Map<String, dynamic> candidate, int likedCount){

  final int unused = (candidate['unusedIngredients'] as List ?)?.length ?? 0;

  final int used = likedCount - unused;

  final int missed = (candidate['missedIngredientCount'] as int ?) ?? 0;

  final int union = likedCount + missed;
  return used / union;
}

void main() {
  final candidate = {
    'title': 'Lamb and Fresh Goat Cheese Roulade',
    'unusedIngredients': [
      {'name': 'eggs'}
    ],
    'missedIngredientCount': 2,
  };

  final score = scoreCandidate(candidate, 3);
  print('${candidate['title']}: $score');
}
