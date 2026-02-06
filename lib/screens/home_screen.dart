import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bienvenidos a MyGym',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.red.shade800,
          fontFamily: 'Roboto', 
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
