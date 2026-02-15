import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login_screen.dart';
import '../main_navigation.dart'; // Necesario para navegar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _quote = "Cargando...";
  String _author = "";

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  // Tema 7: Carga de datos de red (API)
  Future<void> _fetchQuote() async {
    try {
      final url = Uri.parse('https://dummyjson.com/quotes/random');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _quote = data['quote'];
          _author = data['author'];
        });
      } else {
        setState(() {
          _quote = "Sin dolor no hay ganancia.";
          _author = "Anónimo";
        });
      }
    } catch (e) {
      setState(() {
        _quote = "Error de conexión.";
        _author = "";
      });
    }
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _goToExercises() {
    // Tema 4: Navegación pasando parámetros
    // Vamos a MainNavigation y le decimos que empiece en el índice 2 (Ejercicios)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigation(initialIndex: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('MY GYM'),
        backgroundColor: Colors.black, // Color sólido, más básico
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Colors.redAccent),
          ),
        ],
      ),
      // Tema 3: Stack para poner fondo + texto encima
      body: Stack(
        children: [
          // 1. Imagen de fondo (Tema 1: Insertar imagen)
          Positioned.fill(
            child: Image.asset(
              'assets/images/fitness-train-male-strong-power.jpg',
              fit: BoxFit.cover,
              // Usamos Color.fromRGBO para oscurecer (Forma clásica)
              color: const Color.fromRGBO(0, 0, 0, 0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),

          // 2. Contenido
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Caja de la frase (Tema 2: Container y decoración)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      border: Border.all(color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "FRASE DEL DÍA",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '"$_quote"',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "- $_author",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  const Text(
                    'No es motivación.\nEs disciplina.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // BOTÓN ESTÁNDAR (Tema 2 - ElevatedButton pag 43)
                  SizedBox(
                    width: double.infinity, // Que ocupe el ancho
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          _goToExercises, // Llama a la función de navegar
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent, // Color de fondo
                        foregroundColor: Colors.black, // Color del texto
                      ),
                      child: const Text(
                        'EMPEZAR A ENTRENAR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
