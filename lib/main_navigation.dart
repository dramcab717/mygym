import 'package:flutter/material.dart';

// Importamos tus pantallas
import 'screens/home_screen.dart';
import 'screens/trainings_screen.dart';
import 'screens/exercises_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/credits_screen.dart';

class MainNavigation extends StatefulWidget {
  // Tema 4: Paso de parámetros (página 25 del PDF 4)
  final int initialIndex;

  // Por defecto es 0 (Home), pero si le pasamos otro número, arrancará ahí
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Lista de pantallas (Ordenadas como en la barra de abajo)
  final List<Widget> _screens = [
    const HomeScreen(), // Índice 0
    const TrainingsScreen(), // Índice 1
    const ExercisesScreen(), // Índice 2 (Aquí queremos llegar)
    const StatsScreen(), // Índice 3
    const CreditsScreen(), // Índice 4
  ];

  @override
  void initState() {
    super.initState();
    // Al iniciar, le decimos que el índice sea el que hemos pasado por parámetro
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
