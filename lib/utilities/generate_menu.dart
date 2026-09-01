import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> generateMenu(String queueCollection, String menuField) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
  final queue = userDoc.collection(queueCollection);

  //read entire queue
  final snapshot = await queue.get();
  final docs = snapshot.docs.toList();

  //shuffle and take 7 recipes
  docs.shuffle();
  final chosen = docs.take(7).toList();

  final titles = chosen.map((d) => d.data()['title'] as String).toList();

  await userDoc.update({menuField: titles});

  //delete from queue
  for (final d in chosen) {
    await d.reference.delete();
  }
}