import 'package:flutter/material.dart';

class TrainingsScreen extends StatelessWidget {
  const TrainingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Entrenamientos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _trainingCard('Pecho y tríceps', '12/01/2026'),
          _trainingCard('Espalda', '15/01/2026'),
          _trainingCard('Piernas', '18/01/2026'),
        ],
      ),
    );
  }

  Widget _trainingCard(String title, String date) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.fitness_center, color: Colors.redAccent),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(date, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}
