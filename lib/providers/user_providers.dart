import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/Modals/user.dart';
import 'auth_provider.dart';

final userProvider = FutureProvider<UserModel?>((ref) async {
  final uid = ref.watch(uidProvider);
  if (uid == null) return null;

  final snapshot = await FirebaseFirestore.instance
      .collection('users').doc(uid).get();

  if (!snapshot.exists) return null;
  return UserModel.fromMap(snapshot.data());
});