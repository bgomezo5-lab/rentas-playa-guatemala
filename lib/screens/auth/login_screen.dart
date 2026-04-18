import 'package:flutter/material.dart';
import 'registro_propietario_screen.dart';
import '../propietario/panel_propietario.dart';
import '../inquilino/home_inquilino_screen.dart';

class LoginScreen extends StatefulWidget {
  final String rol;
  const LoginScreen({super.key, required this.rol});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --- COLORES ---
  static const Color colorTurquesa = Color(0xFF00C9DB);
  static const Color colorMarProfundo = Color(0xFF0056D2);

  // --- CONTROLADORES (CORREGIDOS AQUÍ) ---
  // Nota: No llevan 'const' antes del constructor
  final TextEditingController _userController = TextEditingController(text: "socio@rentasplaya.com");
  final TextEditingController _passController = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colorTurquesa, Color(0xFFF7E7CE)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  children: [
                    const Icon(Icons.beach_access_rounded, color: Colors.white, size: 80),
                    const SizedBox(height: 10),
                    const Text("RENTAS PLAYA",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 3)),
                    Text(
                      widget.rol == "propietario" ? "Panel de Socios" : "Encuentra tu paraíso",
                      style: const TextStyle(color: Colors.white70, fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 40),

                    // --- TARJETA DE LOGIN ---
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
                      ),
                      child: Column(
                        children: [
                          const Text("¡Hola de nuevo!",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                          const SizedBox(height: 25),
                          _inputCompacto(
                              controller: _userController, // Pasamos el controlador
                              icono: Icons.alternate_email_rounded,
                              label: "Correo o Usuario"
                          ),
                          const SizedBox(height: 15),
                          _inputCompacto(
                              controller: _passController, // Pasamos el controlador
                              icono: Icons.lock_open_rounded,
                              label: "Contraseña",
                              obscure: true
                          ),
                          const SizedBox(height: 20),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorMarProfundo,
                              minimumSize: const Size(double.infinity, 55),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () => _manejarLogin(),
                            child: const Text("INICIAR SESIÓN",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                    Text(
                      widget.rol == "propietario"
                          ? "¿Aún no eres socio?"
                          : "¿No tienes cuenta para rentar?",
                      style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),

                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        if (widget.rol == "propietario") {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistroPropietarioScreen()));
                        }
                      },
                      child: const Text("REGÍSTRATE AQUÍ",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),

                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cambiar de perfil", style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- LÓGICA DE LOGIN ---
  void _manejarLogin() {
    String user = _userController.text.trim();
    String pass = _passController.text.trim();

    if (widget.rol == "propietario") {
      if (user == "socio@rentasplaya.com" && pass == "123456") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PanelPropietario()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Credenciales incorrectas")));
      }
    } else {
      // Si entra como inquilino
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeInquilinoScreen()));
    }
  }

  // --- WIDGET DE INPUT REUTILIZABLE ---
  Widget _inputCompacto({required TextEditingController controller, required IconData icono, required String label, bool obscure = false}) {
    return TextField(
      controller: controller, // Vinculamos el controlador
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icono, color: colorTurquesa),
        filled: true,
        fillColor: colorTurquesa.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }
}