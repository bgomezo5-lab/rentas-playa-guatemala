import 'package:flutter/material.dart';
import 'home_inquilino_screen.dart';
import 'registro_inquilino_screen.dart';

class LoginInquilinoScreen extends StatelessWidget {
  const LoginInquilinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00C9DB), Color(0xFFF7E7CE)],
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.beach_access, size: 80, color: Colors.white),
            const Text("RENTAS PLAYA", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
            const Text("Acceso Viajeros", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  const TextField(decoration: InputDecoration(labelText: "Correo", prefixIcon: Icon(Icons.email_outlined))),
                  const SizedBox(height: 15),
                  const TextField(obscureText: true, decoration: InputDecoration(labelText: "Contraseña", prefixIcon: Icon(Icons.lock_outline))),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0056D2), minimumSize: const Size(double.infinity, 50)),
                    onPressed: () {
                      // Login directo al Home del Inquilino
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeInquilinoScreen()));
                    },
                    child: const Text("ENTRAR", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistroInquilinoScreen()));
              },
              child: const Text("¿No tienes cuenta? Regístrate aquí", style: TextStyle(color: Color(0xFF0056D2), fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}