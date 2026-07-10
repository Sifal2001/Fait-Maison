import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';
import 'fetchRecipe.dart';

List<String> lunchMenu = useFakeData ? [fakeDishName] : [];

getLunchMenuFromDB() async {
  if (useFakeData) {
    lunchMenu = [fakeDishName];
    return;
  }
  final snapshot =
  await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = snapshot.data();
  if (data != null && data['lunchMenu'] != null) {
    lunchMenu = List<String>.from(data['lunchMenu'] as List);
  }
}