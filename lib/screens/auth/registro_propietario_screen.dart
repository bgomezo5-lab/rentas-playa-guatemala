import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';
import 'captura_dpi_screen.dart';

class RegistroPropietarioScreen extends StatefulWidget {
  const RegistroPropietarioScreen({super.key});

  @override
  State<RegistroPropietarioScreen> createState() => _RegistroPropietarioScreenState();
}

class _RegistroPropietarioScreenState extends State<RegistroPropietarioScreen> {
  final _nombres = TextEditingController();
  final _apellidos = TextEditingController();
  final _direccion = TextEditingController();
  final _telefono = TextEditingController();
  final _correo = TextEditingController();
  final _pass = TextEditingController();

  String? _paisSeleccionado = "Guatemala";
  String? _deptoSeleccionado;
  String? _muniSeleccionado;

  final Color colorMar = const Color(0xFF00C9DB);
  final Color colorArena = const Color(0xFFF7E7CE);
  final Color colorBoton = const Color(0xFFFFB74D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colorMar.withOpacity(0.8), colorArena],
          ),
        ),
        child: SafeArea(
          // ESTO CENTRA EL FORMULARIO EN WEB
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500), // ANCHO MÁXIMO ESTÉTICO
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    _header(),
                    const SizedBox(height: 30),

                    // SECCIÓN 1: IDENTIDAD (AHORA MÁS COMPACTA)
                    _crearContenedorPaso(
                      icono: Icons.person_pin_circle_outlined,
                      titulo: "Información Personal",
                      hijos: [
                        Row( // NOMBRES Y APELLIDOS A LA PAR
                          children: [
                            Expanded(child: _crearInputPlayero(_nombres, "Nombres", Icons.person_outline)),
                            const SizedBox(width: 10),
                            Expanded(child: _crearInputPlayero(_apellidos, "Apellidos", Icons.person_outline)),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // SECCIÓN 2: UBICACIÓN
                    _crearContenedorPaso(
                      icono: Icons.holiday_village_outlined,
                      titulo: "Ubicación del Socio",
                      hijos: [
                        _crearDropdownPlayero("País", ["Guatemala"], _paisSeleccionado, (val) => setState(() => _paisSeleccionado = val)),
                        Row( // DEPTO Y MUNI A LA PAR
                          children: [
                            Expanded(child: _crearDropdownPlayero("Departamento", _guatemalaData.keys.toList(), _deptoSeleccionado, (val) {
                              setState(() { _deptoSeleccionado = val; _muniSeleccionado = null; });
                            })),
                            if (_deptoSeleccionado != null) ...[
                              const SizedBox(width: 10),
                              Expanded(child: _crearDropdownPlayero("Municipio", _guatemalaData[_deptoSeleccionado]!, _muniSeleccionado, (val) => setState(() => _muniSeleccionado = val))),
                            ]
                          ],
                        ),
                        _crearInputPlayero(_direccion, "Dirección Residencia", Icons.home_outlined),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // SECCIÓN 3: CONTACTO
                    _crearContenedorPaso(
                      icono: Icons.vibration_outlined,
                      titulo: "Seguridad",
                      hijos: [
                        _crearInputPlayero(_telefono, "Teléfono", Icons.phone_android_outlined),
                        _crearInputPlayero(_correo, "Correo", Icons.email_outlined),
                        _crearInputPlayero(_pass, "Contraseña", Icons.lock_outline, obscure: true),
                      ],
                    ),

                    const SizedBox(height: 30),
                    _botonContinuar(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- COMPONENTES PULIDOS ---

  Widget _header() {
    return Column(
      children: [
        const Icon(Icons.beach_access, size: 60, color: Colors.white),
        const SizedBox(height: 10),
        const Text("Únete a Rentas Playa",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _crearContenedorPaso({required IconData icono, required String titulo, required List<Widget> hijos}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icono, color: colorMar, size: 20),
              const SizedBox(width: 8),
              Text(titulo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          ...hijos,
        ],
      ),
    );
  }

  Widget _crearInputPlayero(TextEditingController cont, String label, IconData icon, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 50, // ALTURA MÁS COMPACTA
        child: TextField(
          controller: cont,
          obscureText: obscure,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: colorMar, size: 20),
            filled: true,
            fillColor: colorMar.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          ),
        ),
      ),
    );
  }

  Widget _crearDropdownPlayero(String label, List<String> opciones, String? valorActual, Function(String?) alCambiar) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 50,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: colorMar.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
          style: const TextStyle(fontSize: 14, color: Colors.black),
          value: valorActual,
          items: opciones.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
          onChanged: alCambiar,
        ),
      ),
    );
  }

  Widget _botonContinuar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorBoton,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      onPressed: _ejecutarRegistro,
      child: const Text("SIGUIENTE: VERIFICAR DPI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  // (Manten tu mapa de _guatemalaData y _ejecutarRegistro aquí abajo)
  final Map<String, List<String>> _guatemalaData = { /* ... tus datos ... */ };
  void _ejecutarRegistro() { /* ... tu lógica ... */ }
}