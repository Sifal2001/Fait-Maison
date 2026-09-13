import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> generateMenu(
    String queueCollection, String menuField, List<int> caps) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
  final queue = userDoc.collection(queueCollection);

  //read entire queue
  final snapshot = await queue.get();
  final available = snapshot.docs.toList();

  final List<String> chosenTitle = [];
  final List<DocumentReference> toDelete = [];

  for (int day = 0; day < 7; day++) {
    if (available.isEmpty) break;

    final cap = (day < caps.length) ? caps[day] : 60;
    //filter recipes for matching time preferences
    final fits = available
        .where((d) => (d.data()['readyInMinutes'] ?? 999) <= cap)
        .toList();
    for (final doc in fits) {
      print('matches with time criteria: ' + doc.data()['title']);
    }

    final pool = fits.isNotEmpty ? fits : available;
    for (final doc in pool) {
      print('final pool:' + doc.data()['title']);
    }

    final picked = pool[Random().nextInt(pool.length)];

    chosenTitle.add(picked.data()['title'] as String);
    toDelete.add(picked.reference);
    available.remove(picked); // avoid using it for another day
  }
  // save chosen recipe title to menu
  await userDoc.update({menuField: chosenTitle});
  // delete used recipes from the queue
  for (final ref in toDelete) {
    await ref.delete();
  }
}
