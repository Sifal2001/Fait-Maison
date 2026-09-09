import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/utilities/recipe_cache.dart';
import '../screens/black_list.dart'; // for blackList

Future<void> seedQueueFromPool(String poolCollection, String queueCollection) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  // read the whole master pool
  final pool = await FirebaseFirestore.instance.collection(poolCollection).get();

  final queue = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(queueCollection);

  final blackSet = blackList.toSet();

  for (final doc in pool.docs) {
    final data = doc.data();
    final title = data['title'] as String;
    final id = data['id'];
    final ingredients = List<String>.from(data['ingredients'] ?? []);
    final readyInMinutes = data['readyInMinutes'] ?? 999;

    final hasBlacklisted = ingredients.any((i) => blackSet.contains(i));
    if (hasBlacklisted) continue;

    await queue.doc(safeId(title)).set({
      'id': id,
      'title': title,
      'ingredients': ingredients,
      'readyInMinutes': readyInMinutes,
      'source': 'seed',
    });
  }
}