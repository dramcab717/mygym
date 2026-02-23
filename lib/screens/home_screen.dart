import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../main_navigation.dart';

// Usamos StatelessWidget porque esta pantalla es estática y ahorra memoria
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Cierra sesión y vuelve a la pantalla de Login
  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  // Navega directamente a la pestaña de Ejercicios
  void _goToExercises(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigation(initialIndex: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Estructura principal de la pantalla
    return Scaffold(
      backgroundColor: Colors.black, // Fondo oscuro sólido
      appBar: AppBar(
        title: const Text('INICIO', style: TextStyle(color: Colors.redAccent)),
        backgroundColor: Colors.black,
        actions: [
          // Botón de salir en la esquina superior derecha
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      // Contenido centrado con márgenes a los lados
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centra los elementos verticalmente
            children: [
              // Imagen de portada o logo
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  15,
                ), // Redondea un poco las esquinas de la foto
                child: Image.asset(
                  'assets/images/logo.jpg',
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 40), // Espacio en blanco
              // Texto de bienvenida principal
              const Text(
                "¡Bienvenido a My Gym!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),

              // Texto secundario descriptivo
              const Text(
                "Registra tus marcas, descubre nuevos ejercicios y supera tus límites cada día.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),
              // Botón grande para empezar el entrenamiento
              SizedBox(
                width: double.infinity, // Hace que el botón ocupe todo el ancho
                height: 55,
                child: ElevatedButton(
                  onPressed: () => _goToExercises(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.black, // Color del texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Bordes del botón
                    ),
                  ),
                  child: const Text(
                    'EMPEZAR A ENTRENAR',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
