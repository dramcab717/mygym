import 'package:flutter/material.dart';

class AddTrainingScreen extends StatelessWidget {
  const AddTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Formulario para añadir entrenamiento.',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
