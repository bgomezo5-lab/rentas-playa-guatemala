import 'package:flutter/material.dart';

class RegistroPropiedadScreen extends StatefulWidget {
  const RegistroPropiedadScreen({super.key});

  @override
  State<RegistroPropiedadScreen> createState() => _RegistroPropiedadScreenState();
}

class _RegistroPropiedadScreenState extends State<RegistroPropiedadScreen> {
  final Color colorMar = const Color(0xFF00C9DB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar mi Chalet"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Información General", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _input("Nombre del Chalet (Ej: Villa Los Sueños)", Icons.house),
            const SizedBox(height: 10),
            _input("Ubicación Exacta (Ej: Monterrico, Km 15)", Icons.location_on),
            const SizedBox(height: 10),
            _input("Precio por noche (Q)", Icons.payments, tipo: TextInputType.number),

            const SizedBox(height: 30),
            const Text("Detalles para el Cliente", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // FILA DE AMENIDADES RAPIDAS
            Row(
              children: [
                Expanded(child: _input("Habitaciones", Icons.bed, tipo: TextInputType.number)),
                const SizedBox(width: 10),
                Expanded(child: _input("Capacidad Personas", Icons.people, tipo: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 15),

            const Text("Descripción del lugar"),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Cuéntale al cliente sobre la piscina, la playa, si aceptan mascotas...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),
            const Text("Fotos de la Propiedad", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // BOTÓN SUBIR FOTOS (SIMULADO)
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade50,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                  Text("Subir fotos del Chalet", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0056D2),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                // Aquí se guardaría en la base de datos
                Navigator.pop(context);
              },
              child: const Text("PUBLICAR CHALET", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(String label, IconData icono, {TextInputType tipo = TextInputType.text}) {
    return TextField(
      keyboardType: tipo,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icono, color: colorMar),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}