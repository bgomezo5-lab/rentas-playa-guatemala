import 'package:flutter/material.dart';
// Importamos la nueva pantalla de selección que creamos en auth
import 'screens/auth/bienvenida_selection_screen.dart';

void main() {
  runApp(const RentasPlayaApp());
}

class RentasPlayaApp extends StatelessWidget {
  const RentasPlayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rentas Playa Guatemala',
      theme: ThemeData(
        useMaterial3: true,
        // Usamos la paleta de colores oficial que aprobaste
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00C9DB),
          primary: const Color(0xFF0056D2),
        ),
        fontFamily: 'SFProDisplay',
      ),
      // EL CAMBIO CLAVE: Ahora la app inicia preguntando el rol
      home: const BienvenidaSelectionScreen(),
    );
  }
}