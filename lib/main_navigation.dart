import 'package:flutter/material.dart';
import '../screens/screens.dart'; // Importamos todas las pantallas de golpe

class MainNavigation extends StatefulWidget {
  // Parámetro para elegir en qué pestaña arranca la app
  final int initialIndex;

  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Lista con las pantallas en el orden exacto del menú inferior
  final List<Widget> _screens = const [
    HomeScreen(), // Índice 0
    TrainingsScreen(), // Índice 1
    ExercisesScreen(), // Índice 2
    StatsScreen(), // Índice 3
    CreditsScreen(), // Índice 4
  ];

  @override
  void initState() {
    super.initState();
    // Asignamos la pestaña inicial recibida al arrancar
    _selectedIndex = widget.initialIndex;
  }

  // Función que actualiza la pantalla al tocar un icono del menú
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Muestra la pantalla correspondiente al índice seleccionado
      body: _screens[_selectedIndex],

      // Barra de navegación nativa de Flutter
      bottomNavigationBar: BottomNavigationBar(
        type:
            BottomNavigationBarType.fixed, // Evita animaciones raras al pulsar
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Entrenos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Ejercicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progreso',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Créditos'),
        ],
      ),
    );
  }
}
