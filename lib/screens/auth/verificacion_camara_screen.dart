import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class VerificacionCamaraScreen extends StatefulWidget {
  final String tipo; // "DPI Frontal", "DPI Reverso" o "Selfie"
  const VerificacionCamaraScreen({super.key, required this.tipo});

  @override
  State<VerificacionCamaraScreen> createState() => _VerificacionCamaraScreenState();
}

class _VerificacionCamaraScreenState extends State<VerificacionCamaraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initCam();
  }

  Future<void> _initCam() async {
    final cameras = await availableCameras();
    // Para el selfie, intentamos usar la cámara frontal (si existe)
    final camera = (widget.tipo == "Selfie" && cameras.length > 1) ? cameras[1] : cameras[0];

    _controller = CameraController(camera, ResolutionPreset.medium, enableAudio: false);
    _initializeControllerFuture = _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Capturar ${widget.tipo}")),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && _controller != null) {
            return Stack(
              alignment: Alignment.center,
              children: [
                CameraPreview(_controller!),
                // GUÍA VISUAL DINÁMICA
                if (widget.tipo.contains("DPI"))
                  Container( // Cuadro para DPI
                    width: 300, height: 190,
                    decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3), borderRadius: BorderRadius.circular(15)),
                  )
                else
                  Container( // Círculo para Selfie
                    width: 250, height: 350,
                    decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3), shape: BoxShape.circle),
                  ),
                Positioned(bottom: 100, child: Text("Enmarque su ${widget.tipo}", style: const TextStyle(color: Colors.white, backgroundColor: Colors.black45))),
              ],
            );
          } return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _controller!.takePicture();
          if (mounted) Navigator.pop(context); // Regresa al menú de pasos
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}