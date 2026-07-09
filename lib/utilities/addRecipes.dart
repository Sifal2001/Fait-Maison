import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/Login.dart';

Future<void> _copySeed(String seedCollection, String userSubcollection) async {
  final userCol = FirebaseFirestore.instance
      .collection('users').doc(uid).collection(userSubcollection);

  final existing = await userCol.limit(1).get();
  if (existing.docs.isNotEmpty) return;

  final seed = await FirebaseFirestore.instance.collection(seedCollection).get();
  for (final doc in seed.docs) {
    await userCol.add(doc.data());
  }
}

Future<void> addBreakfastRecipes()  => _copySeed('Breakfast_r', 'breakfast');
Future<void> addLunchRecipes()  => _copySeed('Lunch_r', 'lunch');
Future<void> addDinnerRecipes() => _copySeed('Dinner_r', 'dinner');