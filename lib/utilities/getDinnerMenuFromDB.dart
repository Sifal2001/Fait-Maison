import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';
import 'fetchRecipe.dart';

List<String> dinnerMenu = useFakeData ? List.filled(7, fakeDishName) : [];

getDinnerMenuFromDB() async {
  if (useFakeData) {
    dinnerMenu = List.filled(7, fakeDishName);
    return;
  }
  final snapshot =
  await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = snapshot.data();
  if (data != null && data['dinnerMenu'] != null) {
    dinnerMenu = List<String>.from(data['dinnerMenu'] as List);
  }
}