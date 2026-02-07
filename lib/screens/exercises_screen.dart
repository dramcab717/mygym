import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Ejercicios')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ExerciseTile('Press banca', 'Pecho'),
          _ExerciseTile('Sentadilla', 'Piernas'),
          _ExerciseTile('Dominadas', 'Espalda'),
        ],
      ),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  final String name;
  final String muscle;

  const _ExerciseTile(this.name, this.muscle);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        leading: Icon(Icons.fitness_center, color: Colors.redAccent),
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Text(muscle, style: TextStyle(color: Colors.white70)),
      ),
    );
  }
}
