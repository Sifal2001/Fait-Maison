import 'dart:io';
import 'show_nutrition.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/camera_provider.dart';
import '../providers/tflite_provider.dart';
import '../utilities/get_nutrition.dart';
import '../utilities/spoonacular_map.dart';

class ScanAndLearn extends ConsumerStatefulWidget {
  const ScanAndLearn({super.key, required String title});

  @override
  ConsumerState<ScanAndLearn> createState() => _ScanAndLearnState();
}

class _ScanAndLearnState extends ConsumerState<ScanAndLearn>
    with WidgetsBindingObserver {
  CameraController? _controller;
  CameraDescription? _activeCamera;
  bool _initializing = true;
  String? _error;
  String? _result;
  bool _classifying = false;
  static const double _threshold = 0.6;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setup();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      final c = _controller;
      if (c != null) {
        c.dispose();
        _controller = null;
        if (mounted)
          setState(() {
            _initializing = true;
          });
      }
    } else if (state == AppLifecycleState.resumed) {
      final cam = _activeCamera;
      if (cam != null && _controller == null) {
        _startCamera(cam);
      }
    }
  }

  Future<void> _setup() async {
    try {
      final cameras = await ref.read(camerasProvider.future);
      final cam = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _activeCamera = cam;
      await _startCamera(cam);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _initializing = false;
      });
    }
  }

  Future<void> _startCamera(CameraDescription description) async {
    final controller = CameraController(
      description,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await controller.initialize();
    if (!mounted) {
      controller.dispose();
      return;
    }
    setState(() {
      _controller = controller;
      _initializing = false;
    });
  }

  Future<void> _captureAndClassify() async {
    final controller = _controller;
    if (controller == null || _classifying) return;

    final service = ref.read(tfliteServiceProvider).value;
    if (service == null) return; // model not ready

    setState(() {
      _classifying = true;
    });
    try {
      final shot = await controller.takePicture();
      final result = service.classify(File(shot.path));
      if (!mounted) return;

      if (result == null) {
        setState(() => _result = 'Not recognized');
      } else if (result.confidence < _threshold) {
        setState(() =>
        _result = 'Not recognized (${result.confidence.toStringAsFixed(2)})');
      } else {
        setState(() => _result =
        '${result.label}  ${(result.confidence * 100).toStringAsFixed(0)}%');

        final nut = await fetchNutrition(toSpoonacularName(result.label));
        if (!mounted) return;

        if (nut == null) {
          setState(() => _result = '${result.label} — nutrition unavailable');
        } else {
          setState(() => _result = null);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ShowNutrition(nutrition: nut)),
          );
        }
      }
    } catch (e) {
      if (mounted) setState(() => _result = 'Error: $e');
    } finally {
      if (mounted) setState(() => _classifying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan and learn')),
      body: _error != null
          ? Center(child: Text(_error!))
          : (_initializing || _controller == null)
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          CameraPreview(_controller!),
          if (_result != null)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  color: Colors.black54,
                  child: Text(
                    _result!,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _classifying ? null : _captureAndClassify,
        child: _classifying
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.camera_alt),
      ),
    );
  }
}
