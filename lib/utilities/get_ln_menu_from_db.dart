import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/login.dart';
import 'fetch_recipe.dart';

List<String> lunchMenu = useFakeData ? List.filled(7, fakeDishName) : [];

getLunchMenuFromDB() async {
  if (useFakeData) {
    lunchMenu = List.filled(7, fakeDishName);
    return;
  }
  final snapshot =
  await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = snapshot.data();
  if (data != null && data['lunchMenu'] != null) {
    lunchMenu = List<String>.from(data['lunchMenu'] as List);
  }
}