import 'package:flutter/material.dart';

class RegistroInquilinoScreen extends StatelessWidget {
  const RegistroInquilinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de Viajero")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: "Nombre Completo")),
            const SizedBox(height: 15),
            const TextField(decoration: InputDecoration(labelText: "Correo")),
            const SizedBox(height: 15),
            const TextField(decoration: InputDecoration(labelText: "WhatsApp")),
            const SizedBox(height: 15),
            const TextField(obscureText: true, decoration: InputDecoration(labelText: "Contraseña")),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CREAR MI CUENTA"),
            )
          ],
        ),
      ),
    );
  }
}