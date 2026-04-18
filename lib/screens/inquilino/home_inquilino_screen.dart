import 'package:flutter/material.dart';
import 'casa_detalle_screen.dart'; // Importante para la navegación

class HomeInquilinoScreen extends StatefulWidget {
  const HomeInquilinoScreen({super.key});

  @override
  State<HomeInquilinoScreen> createState() => _HomeInquilinoScreenState();
}

class _HomeInquilinoScreenState extends State<HomeInquilinoScreen> {
  // Colores oficiales de Rentas Playa
  final Color colorTurquesa = const Color(0xFF00C9DB);
  final Color colorAzul = const Color(0xFF0056D2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategorias(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const Text(
                    "Chalets destacados",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 15),

                  // CHALET 1: DISPONIBLE
                  _cardChalet(
                    nombre: "Chalet Las Olas",
                    ubicacion: "Monterrico, Santa Rosa",
                    precio: "1,200",
                    disponible: true,
                    imagenUrl: "https://images.unsplash.com/photo-1540541338287-41700207dee6",
                  ),

                  const SizedBox(height: 20),

                  // CHALET 2: ALQUILADO
                  _cardChalet(
                    nombre: "Villa Sol y Arena",
                    ubicacion: "Puerto San José",
                    precio: "1,500",
                    disponible: false,
                    imagenUrl: "https://images.unsplash.com/photo-1499793983690-e29da59ef1c2",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- COMPONENTES DE LA INTERFAZ ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hola viajero,", style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Text("¿A dónde vamos?", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                ],
              ),
              CircleAvatar(
                backgroundColor: colorTurquesa.withOpacity(0.1),
                child: Icon(Icons.person, color: colorAzul),
              )
            ],
          ),
          const SizedBox(height: 20),

          // --- BUSCADOR CORREGIDO CON SOMBRA ---
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar Chalets...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF00C9DB)),
                filled: true,
                fillColor: Colors.transparent, // Color manejado por el Container
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorias() {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          _itemCategoria("Playa", Icons.beach_access),
          _itemCategoria("Piscina", Icons.pool),
          _itemCategoria("Eventos", Icons.celebration),
          _itemCategoria("Lujo", Icons.star),
        ],
      ),
    );
  }

  Widget _itemCategoria(String nombre, IconData icono) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(icono, color: colorTurquesa),
          ),
          const SizedBox(height: 5),
          Text(nombre, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _cardChalet({
    required String nombre,
    required String ubicacion,
    required String precio,
    required String imagenUrl,
    required bool disponible
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DetalleChaletScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                  child: Image.network(imagenUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: disponible ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      disponible ? "DISPONIBLE" : "ALQUILADO",
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(nombre, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Q $precio", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: colorAzul)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      Text(ubicacion, style: const TextStyle(color: Colors.grey)),
                      const Spacer(),
                      const Text("/ noche", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      selectedItemColor: colorAzul,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Favoritos"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "Reservas"),
      ],
    );
  }
}