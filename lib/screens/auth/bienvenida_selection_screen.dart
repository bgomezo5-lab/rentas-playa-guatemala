import 'package:flutter/material.dart';
// IMPORTACIONES CORREGIDAS SEGÚN TU NUEVA ESTRUCTURA
import '../inquilino/login_inquilino_screen.dart'; // Nueva ubicación
import 'login_screen.dart'; // Login que se quedó para Propietarios

class BienvenidaSelectionScreen extends StatelessWidget {
  const BienvenidaSelectionScreen({super.key});

  // --- COLORES OFICIALES ---
  static const Color colorTurquesa = Color(0xFF00C9DB);
  static const Color colorMarProfundo = Color(0xFF0056D2);
  static const Color colorArena = Color(0xFFF7E7CE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colorTurquesa, colorArena],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Icon(Icons.wb_sunny_rounded, size: 70, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                "¿Qué buscas hoy?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const Text(
                "Selecciona tu perfil para continuar",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),

              const Spacer(),

              // --- OPCIÓN INQUILINO (CLIENTE) ---
              _cardOpcion(
                context,
                titulo: "Quiero Rentar",
                subtitulo: "Busco la casa de mis sueños",
                icono: Icons.beach_access_rounded,
                colorIcono: colorTurquesa,
                onTap: () {
                  // AHORA APUNTA A SU PROPIO DIRECTORIO
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginInquilinoScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              // --- OPCIÓN PROPIETARIO (SOCIO) ---
              _cardOpcion(
                context,
                titulo: "Soy Propietario",
                subtitulo: "Quiero listar mis propiedades",
                icono: Icons.home_work_rounded,
                colorIcono: colorMarProfundo,
                onTap: () {
                  // MANTIENE EL LOGIN DE SOCIOS EN AUTH
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(rol: "propietario"),
                    ),
                  );
                },
              ),

              const Spacer(flex: 2),

              const Text(
                "Rentas Playa Guatemala v1.0",
                style: TextStyle(color: Colors.blueGrey, fontSize: 12),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardOpcion(BuildContext context,
      {required String titulo,
        required String subtitulo,
        required IconData icono,
        required Color colorIcono,
        required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: colorIcono.withOpacity(0.1),
                child: Icon(icono, color: colorIcono, size: 30),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      subtitulo,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}