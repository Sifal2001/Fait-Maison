import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// breakfast menu notifier
class BreakfastMenuNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final menu = List<String>.from(doc.data()?['breakfastMenu'] ?? []);
    state = menu;
  }

  Future<void> reload() => _load();
}

// lunch menu notifier
class LunchMenuNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final menu = List<String>.from(doc.data()?['lunchMenu'] ?? []);
    state = menu;
  }

  Future<void> reload() => _load();
}

// dinner menu notifier
class DinnerMenuNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final menu = List<String>.from(doc.data()?['dinnerMenu'] ?? []);
    state = menu;
  }

  Future<void> reload() => _load();
}

// menu providers
final breakfastMenuNotifierProvider =
    NotifierProvider<BreakfastMenuNotifier, List<String>>(
        BreakfastMenuNotifier.new);

final lunchMenuNotifierProvider =
    NotifierProvider<LunchMenuNotifier, List<String>>(LunchMenuNotifier.new);

final dinnerMenuNotifierProvider =
    NotifierProvider<DinnerMenuNotifier, List<String>>(DinnerMenuNotifier.new);
