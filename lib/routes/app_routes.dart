import 'package:flutter/material.dart';
import '../screens/screens.dart';
import '../main_navigation.dart';

class AppRoutes {
  // Pantalla que arranca primero
  static const String initialRoute = 'splash';

  // Mapa global de rutas de la aplicación
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      'splash': (BuildContext context) => const SplashScreen(),
      'login': (BuildContext context) => const LoginScreen(),
      'home': (BuildContext context) => const HomeScreen(),
      'main_nav': (BuildContext context) => const MainNavigation(),
      'exercises': (BuildContext context) => const ExercisesScreen(),
      'stats': (BuildContext context) => const StatsScreen(),
    };
  }
}
