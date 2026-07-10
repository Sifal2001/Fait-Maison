import 'package:cloud_firestore/cloud_firestore.dart';

/// Reads [field] from [snap] as a `List<T>`, returning an empty list when the
/// document doesn't exist, the field is missing, or the value isn't a list.
/// This prevents `value.get(field)` from throwing on absent docs/fields.
List<T> readListField<T>(DocumentSnapshot<Map<String, dynamic>> snap, String field) {
  final data = snap.data();
  if (data == null || data[field] is! List) return [];
  return List<T>.from(data[field] as List);
}
