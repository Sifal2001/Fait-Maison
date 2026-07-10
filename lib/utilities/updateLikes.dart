import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/utilities/readCsv.dart';
import 'addSimilarRecipeToDB.dart';
import 'firestoreHelpers.dart';
import 'getLikes.dart';
import 'getSimilarRecipe.dart';

List <String> liked_recipe = [];

Future<bool> onLikeButtonTapped(bool isLiked) async{

  await FirebaseFirestore.instance
  .collection(collection_path)
  .doc(doc_path)
  .update({'love': FieldValue.increment(1)});

  await FirebaseFirestore.instance
  .collection(collection_path)
  .doc(doc_path)
  .get()
  .then((value){
    liked_recipe = readListField<String>(value, 'ingredients');
  });

  await loadAsset();
  await getSimilarRecipe();
  addSimilarRecipeToDB();

  return !isLiked;
}
