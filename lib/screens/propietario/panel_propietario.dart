import 'package:flutter/material.dart';
import '../auth/bienvenida_selection_screen.dart';
import 'registro_propiedad_screen.dart'; // Importamos el nuevo formulario

class PanelPropietario extends StatelessWidget {
  const PanelPropietario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Mis Propiedades", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange[800],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Cerrar Sesión",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BienvenidaSelectionScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildResumenHeader(),
            const SizedBox(height: 100), // Espacio para cuando no hay casas
            const Icon(Icons.home_work_outlined, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              "Aún no tienes casas registradas",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Presiona el botón de abajo para empezar a ganar dinero con tu chalet.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
      // BOTÓN CONECTADO AL REGISTRO
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistroPropiedadScreen()),
          );
        },
        backgroundColor: Colors.orange[800],
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("AGREGAR CASA", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Widget para darle un toque más profesional al inicio del panel
  Widget _buildResumenHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.orange[800],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Panel de Control", style: TextStyle(color: Colors.white70, fontSize: 16)),
          Text("Bienvenido, Socio",
              style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}