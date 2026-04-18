import 'package:flutter/material.dart';

class ReservaPagoScreen extends StatefulWidget {
  final String nombreChalet;
  final double precioTotal;

  const ReservaPagoScreen({
    super.key,
    required this.nombreChalet,
    required this.precioTotal
  });

  @override
  State<ReservaPagoScreen> createState() => _ReservaPagoScreenState();
}

class _ReservaPagoScreenState extends State<ReservaPagoScreen> {
  // --- VARIABLES DE ESTADO ---
  String _metodoSeleccionado = "tarjeta"; // tarjeta o transferencia
  String _tipoTarjeta = "desconocido"; // visa, mastercard o desconocido

  // Datos para Transferencia
  String? _bancoSeleccionado;
  final List<String> _bancosGuate = [
    "Banco Industrial", "Banrural", "G&T Continental",
    "BAC Credomatic", "BAM", "Interbanco", "Bantrab"
  ];

  // Colores de tu marca
  final Color colorMar = const Color(0xFF00C9DB);
  final Color colorAzul = const Color(0xFF0056D2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizar Reserva", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RESUMEN RAPIDO
            _cardResumen(),
            const SizedBox(height: 30),

            const Text("Selecciona tu método de pago:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // SELECTOR DE METODO (TARJETA / TRANSFERENCIA)
            _selectorMetodo(),
            const SizedBox(height: 25),

            // FORMULARIO DINÁMICO
            _metodoSeleccionado == "tarjeta"
                ? _formularioTarjeta()
                : _formularioTransferencia(),

            const SizedBox(height: 40),

            // BOTÓN FINAL DE PAGO
            _botonPagar(),
          ],
        ),
      ),
    );
  }

  // --- COMPONENTES ---

  Widget _cardResumen() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorMar.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorMar.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.nombreChalet, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Text("Total a reservar:", style: TextStyle(color: Colors.blueGrey)),
            ],
          ),
          Text("Q ${widget.precioTotal}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorAzul)),
        ],
      ),
    );
  }

  Widget _selectorMetodo() {
    return Row(
      children: [
        _opcionMetodo("Tarjeta", Icons.credit_card, "tarjeta"),
        const SizedBox(width: 15),
        _opcionMetodo("Transferencia", Icons.account_balance, "transferencia"),
      ],
    );
  }

  Widget _opcionMetodo(String texto, IconData icono, String valor) {
    bool seleccionado = _metodoSeleccionado == valor;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _metodoSeleccionado = valor),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: seleccionado ? colorAzul : Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Icon(icono, color: seleccionado ? Colors.white : Colors.grey),
              Text(texto, style: TextStyle(color: seleccionado ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formularioTarjeta() {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Número de Tarjeta",
            prefixIcon: const Icon(Icons.credit_card),
            // AQUÍ ESTÁ LA MAGIA DEL LOGO
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getIconoTarjeta(),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onChanged: (val) {
            setState(() {
              if (val.startsWith('4')) _tipoTarjeta = "visa";
              else if (val.startsWith('5')) _tipoTarjeta = "mastercard";
              else _tipoTarjeta = "desconocido";
            });
          },
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: _inputSimple("Vencimiento (MM/AA)")),
            const SizedBox(width: 10),
            Expanded(child: _inputSimple("CVV", ocultar: true)),
          ],
        ),
        const SizedBox(height: 15),
        _inputSimple("Nombre del titular"),
      ],
    );
  }

  Widget _formularioTransferencia() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: "Selecciona tu Banco",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          items: _bancosGuate.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
          onChanged: (val) => setState(() => _bancoSeleccionado = val),
        ),
        const SizedBox(height: 15),
        _inputSimple("Monto transferido (Q)"),
        const SizedBox(height: 15),
        _inputSimple("Fecha y Hora (Ej: 03/04 14:20)"),
        const SizedBox(height: 20),

        // BOTÓN SUBIR COMPROBANTE
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade50,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload_outlined, color: Colors.grey, size: 30),
              Text("Subir foto del comprobante", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getIconoTarjeta() {
    if (_tipoTarjeta == "visa") return const Icon(Icons.credit_card, color: Colors.blue);
    if (_tipoTarjeta == "mastercard") return const Icon(Icons.credit_card, color: Colors.orange);
    return const Icon(Icons.help_outline, color: Colors.grey);
  }

  Widget _inputSimple(String label, {bool ocultar = false}) {
    return TextField(
      obscureText: ocultar,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }

  Widget _botonPagar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorAzul,
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
      ),
      onPressed: () {
        // Lógica de éxito o enviar a revisión del propietario
        _mostrarExito();
      },
      child: const Text("CONFIRMAR Y PAGAR",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  void _mostrarExito() {
    showDialog(
        context: context,
        builder: (c) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
          content: const Text("Tu solicitud de reserva ha sido enviada. El propietario confirmará en unos minutos.", textAlign: TextAlign.center),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("ENTENDIDO"))],
        )
    );
  }
}