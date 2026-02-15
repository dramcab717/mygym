import 'package:flutter/material.dart';
import 'add_training_screen.dart';
import '../db/database_helper.dart'; // Asegúrate de que esta ruta es correcta

class TrainingsScreen extends StatefulWidget {
  const TrainingsScreen({super.key});

  @override
  State<TrainingsScreen> createState() => _TrainingsScreenState();
}

class _TrainingsScreenState extends State<TrainingsScreen> {
  List<Map<String, dynamic>> _trainings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshTrainings(); // Cargar datos al iniciar la pantalla
  }

  // Función para leer la base de datos y actualizar la lista
  Future<void> _refreshTrainings() async {
    setState(() => _isLoading = true);
    final data = await DatabaseHelper.instance.readAllTrainings();
    setState(() {
      _trainings = data;
      _isLoading = false;
    });
  }

  // Navegar a la pantalla de añadir y recargar al volver
  Future<void> _goToAddTraining() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddTrainingScreen()),
    );
    // Al volver de la pantalla de añadir, recargamos la lista
    _refreshTrainings();
  }

  // Borrar un entrenamiento específico
  void _deleteTraining(int id) async {
    await DatabaseHelper.instance.deleteTraining(id);
    _refreshTrainings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Mis entrenamientos'),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: _goToAddTraining,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : _trainings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.fitness_center, size: 60, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'No hay entrenamientos guardados',
                    style: TextStyle(color: Colors.redAccent, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pulsa el botón + para empezar',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _trainings.length,
              itemBuilder: (context, index) {
                final t = _trainings[index];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.fitness_center,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      t['exercise'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      '${t['sets']} series x ${t['reps']} reps @ ${t['weight']} kg',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTraining(t['id']),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
