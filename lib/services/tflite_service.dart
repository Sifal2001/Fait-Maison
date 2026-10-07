import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:image/image.dart' as img;

class TfliteService {
  Interpreter? _interpreter;
  List<String> _labels = [];

  bool get isReady => _interpreter != null;

  Future<void> init() async {
    _interpreter = await Interpreter.fromAsset('assets/model/model.tflite');

    final raw = await rootBundle.loadString('assets/classes/classes.txt');
    _labels = raw
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final inShape = _interpreter!.getInputTensor(0).shape;
    final outShape = _interpreter!.getOutputTensor(0).shape;
    print('input shape:  $inShape');
    print('output shape: $outShape');
    print('labels: ${_labels.length}');
    print('label[1]: ${_labels[1]}');
  }

  List<List<List<List<double>>>> _preprocess(img.Image src) {
    final resized = img.copyResize(src, width: 224, height: 224);

    return List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(
          224,
          (x) => List.generate(3, (c) {
            final p = resized.getPixel(x, y);
            // c==0 → red, 1 → green, 2 → blue; raw value, NO /255
            if (c == 0) return p.r.toDouble();
            if (c == 1) return p.g.toDouble();
            return p.b.toDouble();
          }),
        ),
      ),
    );
  }

// return (label, confidence) / null if not ready
  ({String label, double confidence})? classify(File file) {
    if (!isReady) return null;

    final bytes = file.readAsBytesSync();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return null;

    final input = _preprocess(decoded);
    final output = List.filled(1 * 36, 0.0).reshape([1, _labels.length]);

    _interpreter!.run(input, output);

    final probs = output[0] as List<double>;

    var bestIdx = 0;
    var bestVal = probs[0];
    for (var i = 1; i < probs.length; i++) {
      if (probs[i] > bestVal) {
        bestVal = probs[i];
        bestIdx = i;
      }
    }

    return (label: _labels[bestIdx], confidence: bestVal);
  }
  // Test on dummy image to test if preprocessing matches training standards
  Future<void> goldenTest() async {
    final data = await rootBundle.load('assets/images/banane.jpg');
    final bytes = data.buffer.asUint8List();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) { print('decode failed'); return; }

    final input = _preprocess(decoded);
    final output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);
    _interpreter!.run(input, output);

    final probs = output[0] as List<double>;
    var bestIdx = 0;
    var bestVal = probs[0];
    for (var i = 1; i < probs.length; i++) {
      if (probs[i] > bestVal) { bestVal = probs[i]; bestIdx = i; }
    }
    print('GOLDEN: ${_labels[bestIdx]} @ ${bestVal.toStringAsFixed(3)}');
  }
}
