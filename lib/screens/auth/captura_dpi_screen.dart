import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'verificacion_camara_screen.dart';

class CapturaDPIScreen extends StatefulWidget {
  const CapturaDPIScreen({super.key});

  @override
  State<CapturaDPIScreen> createState() => _CapturaDPIScreenState();
}

class _CapturaDPIScreenState extends State<CapturaDPIScreen> {
  XFile? _fotoFrontal;
  XFile? _fotoReverso;
  bool _selfieHecha = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool esFrontal) async {
    try {
      // ImageSource.gallery abre el explorador de archivos en Web
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          if (esFrontal) _fotoFrontal = image;
          else _fotoReverso = image;
        });
      }
    } catch (e) {
      print("Error seleccionando imagen: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Documentación")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _itemPaso("DPI Frontal", _fotoFrontal != null, () => _pickImage(true), true),
            const SizedBox(height: 10),
            _itemPaso("DPI Reverso", _fotoReverso != null, () => _pickImage(false), _fotoFrontal != null),
            const SizedBox(height: 10),
            _itemPaso("Selfie Final", _selfieHecha, () async {
              await Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const VerificacionCamaraScreen(tipo: "Selfie")
              ));
              setState(() => _selfieHecha = true);
            }, _fotoReverso != null),

            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: (_fotoFrontal != null && _fotoReverso != null && _selfieHecha) ? Colors.green : Colors.grey
              ),
              onPressed: (_fotoFrontal != null && _fotoReverso != null && _selfieHecha)
                  ? () => Navigator.of(context).popUntil((route) => route.isFirst)
                  : null,
              child: const Text("FINALIZAR TODO", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemPaso(String texto, bool ok, VoidCallback accion, bool habilitado) {
    return ListTile(
      onTap: habilitado ? accion : null,
      leading: Icon(ok ? Icons.check_circle : Icons.upload_file, color: ok ? Colors.green : (habilitado ? Colors.blue : Colors.grey)),
      title: Text(texto, style: TextStyle(color: habilitado ? Colors.black : Colors.grey)),
      tileColor: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}