import 'dart:math';

import 'package:document_analysis/document_analysis.dart';
import 'package:login/utilities/readCsv.dart';
import 'package:login/utilities/updateLikes.dart';

var ingredientsOfRecipeToAdd;

getSimilarRecipe() async{
  List<double> similarity = [];
  for (int i = 0; i< data.length;)
  {
    similarity.add(wordFrequencySimilarity(liked_recipe.join(' '), data[i].join(' '), distanceFunction: cosineDistance));
    print(similarity);
    i++;
  }
  var maxValue = similarity.reduce(max);
  var indexOfMaxValue = similarity.indexOf(maxValue);
  ingredientsOfRecipeToAdd = liked_recipe[indexOfMaxValue];
  print(ingredientsOfRecipeToAdd);
}