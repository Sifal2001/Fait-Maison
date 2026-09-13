import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// allow users to swap individual recipes, similar pattern to generateMenu
Future<String?> swapMeal(
    String queueCollection, String menuField, int dayIndex, int cap) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return null;

  final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
  final queue = userDoc.collection(queueCollection);

  // read the queue
  final snapshot = await queue.get();

  final available = snapshot.docs;

  if (available.isEmpty) return null;

  final fits = available
      .where((d) => (d.data()['readyInMinutes'] ?? 999) <= cap)
      .toList();

  final pool = fits.isNotEmpty ? fits : available.toList();

  final picked = pool[Random().nextInt(pool.length)];

  final newTitle = picked.data()['title'] as String;

  // read current array, replace the one slot, write it back
  final userSnap = await userDoc.get();
  final menu = List<String>.from(userSnap.data()?[menuField] ?? []);
  if (dayIndex >= menu.length) return null;
  menu[dayIndex] = newTitle;
  await userDoc.update({menuField: menu});

  // remove the chosen replacement from the queue
  await picked.reference.delete();

  return newTitle;
}
