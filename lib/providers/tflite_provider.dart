import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tflite_service.dart';

final tfliteServiceProvider = FutureProvider<TfliteService>((ref) async {
  final service = TfliteService();
  await service.init();
  return service;
});