import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_provider.dart';

class BlacklistNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    ref.watch(uidProvider);
    _load();
    return [];
  }

  Future<void> _load() async {
    final uid = ref.read(uidProvider);
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    state = List<String>.from(doc.data()?['blackList'] ?? []);
  }

  // overwrite the blacklist
  Future<void> save(List<String> items) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'blackList': items}, SetOptions(merge: true));
    state = items;
  }
}

final blacklistProvider =
    NotifierProvider<BlacklistNotifier, List<String>>(BlacklistNotifier.new);
