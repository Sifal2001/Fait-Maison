import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';
import 'fetchRecipe.dart';

List<String> breakfastMenu = useFakeData ? List.filled(7, fakeDishName) : [];

getBreakfastMenuFromDB() async {
  if (useFakeData) {
    breakfastMenu = List.filled(7, fakeDishName);
    return;
  }
  final snapshot =
  await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = snapshot.data();
  if (data != null && data['breakfastMenu'] != null) {
    breakfastMenu = List<String>.from(data['breakfastMenu'] as List);
  }
}