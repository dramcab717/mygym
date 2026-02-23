import 'package:flutter/material.dart';

// Usamos StatelessWidget porque es una pantalla estática (no cambian los datos)
class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold
    return Scaffold(
      backgroundColor: Colors.black, // Fondo oscuro para mantener el estilo
      appBar: AppBar(
        title: const Text(
          'Créditos',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0, // Quitamos la sombra de la barra superior
      ),
      // Centramos todo el contenido en medio de la pantalla
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // La columna ocupa solo el espacio de sus textos
          children: [
            // Título 1
            Text(
              'Programación de Móviles:',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Espacio en blanco
            // Texto 1
            Text(
              'Daniel Ramírez Cabello.',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            SizedBox(height: 40),

            // Título 2
            Text(
              'Profesor guía:',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Texto 2
            Text(
              'Francis.',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),

            SizedBox(height: 40),

            // Copyright
            Text(
              '© 2026 MyGym App',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
