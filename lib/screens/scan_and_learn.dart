import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/camera_provider.dart';

class ScanAndLearn extends ConsumerStatefulWidget {
  const ScanAndLearn({super.key, required String title});

  @override
  ConsumerState<ScanAndLearn> createState() => _ScanAndLearnState();
}

class _ScanAndLearnState extends ConsumerState<ScanAndLearn> {
  CameraController? _controller;
  bool _initializing = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    try {
      final cameras = await ref.read(camerasProvider.future);
      final cam = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
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

    // stop controller from holding the camera forever
    if (!mounted) {
      controller.dispose();
      return;
    }

    setState(() {
      _controller = controller;
      _initializing = false;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan and learn')),
      body: _error != null
          ? Center(child: Text(_error!))
          : (_initializing || _controller == null)
              ? const Center(child: CircularProgressIndicator())
              : CameraPreview(_controller!),
    );
  }
}
