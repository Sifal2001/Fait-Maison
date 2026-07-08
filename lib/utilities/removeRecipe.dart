import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/screens/Login.dart';
import 'package:login/screens/showRecepie.dart';
import 'package:login/utilities/getLikes.dart';


removeRecipe() async {
  var collection = FirebaseFirestore.instance.collection('users').doc(uid).collection(userType);
  var snapshot = await collection.where('name', isEqualTo: doc_path).get();
  await snapshot.docs.first.reference.delete()
      .then((value) => print('deleted'));
}