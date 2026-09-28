import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/providers/auth_provider.dart';

// breakfast menu notifier
class BreakfastMenuNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    final uid = ref.watch(uidProvider);
    if (uid != null) _load(uid);
    return [];
  }

  Future<void> _load(String uid) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    state = List<String>.from(doc.data()?['breakfastMenu'] ?? []);
  }

  Future<void> reload() async {
    final uid = ref.read(uidProvider);
    if (uid != null) await _load(uid);
  }
}

// lunch menu notifier
class LunchMenuNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    final uid = ref.watch(uidProvider);
    if (uid != null) _load(uid);
    return [];
  }

  Future<void> _load(String uid) async {
    final uid = ref.read(uidProvider);
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final menu = List<String>.from(doc.data()?['lunchMenu'] ?? []);
    state = menu;
  }

  Future<void> reload() async {
    final uid = ref.read(uidProvider);
    if (uid != null) await _load(uid);
  }
}

// dinner menu notifier
class DinnerMenuNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    final uid = ref.watch(uidProvider);
    if (uid != null) _load(uid);
    return [];
  }

  Future<void> _load(String uid) async {
    final uid = ref.read(uidProvider);
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final menu = List<String>.from(doc.data()?['dinnerMenu'] ?? []);
    state = menu;
  }

  Future<void> reload() async {
    final uid = ref.read(uidProvider);
    if (uid != null) await _load(uid);
  }
}

// menu providers
final breakfastMenuNotifierProvider =
    NotifierProvider<BreakfastMenuNotifier, List<String>>(
        BreakfastMenuNotifier.new);

final lunchMenuNotifierProvider =
    NotifierProvider<LunchMenuNotifier, List<String>>(LunchMenuNotifier.new);

final dinnerMenuNotifierProvider =
    NotifierProvider<DinnerMenuNotifier, List<String>>(DinnerMenuNotifier.new);
