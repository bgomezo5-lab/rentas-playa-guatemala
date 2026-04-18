import 'package:flutter/material.dart';

class DetalleChaletScreen extends StatefulWidget {
  const DetalleChaletScreen({super.key});

  @override
  State<DetalleChaletScreen> createState() => _DetalleChaletScreenState();
}

class _DetalleChaletScreenState extends State<DetalleChaletScreen> {
  // Variables de lógica
  bool estaAlquilado = false;
  String metodoPago = "Tarjeta"; // "Transferencia" o "Tarjeta"

  final List<String> bancosGuate = ["Banco Industrial", "Banrural", "G&T Continental", "BAC Credomatic", "BAM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Chalet", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF00C9DB),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. IMAGEN Y ESTADO
            _buildGaleria(),

            // 2. INFORMACIÓN BÁSICA
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderInfo("Chalet Las Olas", "Monterrico, Santa Rosa"),
                  const SizedBox(height: 20),
                  _buildPreciosSection(),
                  const SizedBox(height: 30),

                  // 3. SECCIÓN DE PAGO (SOLO SI NO ESTÁ ALQUILADO)
                  estaAlquilado
                      ? _buildAvisoAlquilado()
                      : _buildSeccionReserva(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- COMPONENTES PROFESIONALES ---

  Widget _buildHeaderInfo(String nombre, String ubicacion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nombre, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Color(0xFF00C9DB)),
                Text(ubicacion, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: estaAlquilado ? Colors.red[100] : Colors.green[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            estaAlquilado ? "ALQUILADO" : "DISPONIBLE",
            style: TextStyle(color: estaAlquilado ? Colors.red : Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildPreciosSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          _rowPrecio("Precio por día:", "Q 1,200.00"),
          const Divider(),
          _rowPrecio("Combo Fin de Semana:", "Q 2,100.00"),
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.message_outlined, size: 18),
            label: const Text("Preguntar por otro combo al dueño"),
          )
        ],
      ),
    );
  }

  Widget _buildSeccionReserva() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0056D2),
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: () => _mostrarModalPago(context),
          child: const Text("PRERESERVAR AHORA", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // MODAL DE PAGO (Súper Profesional)
  void _mostrarModalPago(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            const Text("Finalizar Reserva", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // SELECTOR DE MÉTODO (Tarjeta / Transferencia)
            // ... Aquí iría el resto de los inputs de tarjeta y bancos que pediste
          ],
        ),
      ),
    );
  }

  Widget _rowPrecio(String label, String precio) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(precio, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0056D2))),
      ],
    );
  }

  Widget _buildGaleria() { /* Placeholder para fotos */ return Container(height: 250, color: Colors.grey[200], child: const Icon(Icons.image, size: 50)); }
  Widget _buildAvisoAlquilado() { return const Center(child: Text("Lo sentimos, este chalet ya está reservado.", style: TextStyle(color: Colors.red))); }
}