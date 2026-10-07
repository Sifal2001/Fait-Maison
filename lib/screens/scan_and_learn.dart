import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/camera_provider.dart';

class ScanAndLearn extends ConsumerStatefulWidget {
  const ScanAndLearn({super.key, required String title});

  @override
  ConsumerState<ScanAndLearn> createState() => _ScanAndLearnState();
}

class _ScanAndLearnState extends ConsumerState<ScanAndLearn> with WidgetsBindingObserver{
  CameraController? _controller;
  CameraDescription? _activeCamera;
  bool _initializing = true;
  String? _error;

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
        if (mounted) setState(() { _initializing = true; });
      }
    } else if (state == AppLifecycleState.resumed) {
      final cam = _activeCamera;
      if (cam != null && _controller == null) {
        _startCamera(cam);
      }
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
          : CameraPreview(_controller!),
    );
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
    if (!mounted) { controller.dispose(); return; }
    setState(() { _controller = controller; _initializing = false; });
  }
}
