import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_provider.dart';

final breakfastPrefProvider = FutureProvider<List<int>>((ref) async {
  final uid = ref.watch(uidProvider);
  if (uid == null) return [];

  final doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = doc.data();
  if (data == null || data['breakfastPre'] == null) return [];
  return List<int>.from(data['breakfastPre']);
});

final lunchPrefProvider = FutureProvider<List<int>>((ref) async {
  final uid = ref.watch(uidProvider);
  if (uid == null) return [];

  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = doc.data();
  if (data == null || data['lunchPre'] == null) return [];
  return List<int>.from(data['lunchPre']);
});

final dinnerPrefProvider = FutureProvider<List<int>>((ref) async {
  final uid = ref.watch(uidProvider);
  if (uid == null) return [];

  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  final data = doc.data();
  if (data == null || data['dinnerPre'] == null) return [];
  return List<int>.from(data['dinnerPre']);
});