import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Modals/user.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final uidProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).value?.uid;
});

final userProvider = FutureProvider<UserModel?>((ref) async {
  final uid = ref.watch(
      uidProvider);
  if (uid == null) return null;
});