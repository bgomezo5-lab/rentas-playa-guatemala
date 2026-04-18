class AuthService {
  // 'static' hace que esta lista sea ÚNICA para toda la app
  static List<Map<String, dynamic>> usuariosDB = [
    {
      "user": "admin",
      "pass": "12345678",
      "nombre": "Byron",
      "verificado": true
    }
  ];

  static Map<String, dynamic>? login(String user, String pass) {
    try {
      // Buscamos en la lista estática
      return usuariosDB.firstWhere(
              (u) => u['user'] == user && u['pass'] == pass
      );
    } catch (e) {
      return null; // Si no lo encuentra, devuelve null
    }
  }

  static void registrar(Map<String, dynamic> nuevo) {
    usuariosDB.add(nuevo);
  }
}