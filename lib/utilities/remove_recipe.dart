import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/screens/login.dart';
import 'package:login/screens/show_recipe.dart';
import 'package:login/utilities/get_likes.dart';


removeRecipe() async {
  var collection = FirebaseFirestore.instance.collection('users').doc(uid).collection(userType);
  var snapshot = await collection.where('name', isEqualTo: doc_path).get();
  await snapshot.docs.first.reference.delete()
      .then((value) => print('deleted'));
}