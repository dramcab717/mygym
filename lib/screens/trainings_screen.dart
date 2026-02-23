import 'package:flutter/material.dart';
import 'add_training_screen.dart';
import '../db/database_helper.dart';

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
    _refreshTrainings();
  }

  // Consulta a SQLite para obtener todos los entrenamientos guardados
  Future<void> _refreshTrainings() async {
    setState(() => _isLoading = true);
    final data = await DatabaseHelper.instance.readAllTrainings();
    setState(() {
      _trainings = data;
      _isLoading = false;
    });
  }

  // Navega al formulario y actualiza la lista automáticamente al volver
  Future<void> _goToAddTraining() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddTrainingScreen()),
    );
    _refreshTrainings();
  }

  // Elimina un registro de la base de datos por su ID
  void _deleteTraining(int id) async {
    await DatabaseHelper.instance.deleteTraining(id);
    _refreshTrainings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // AppBar adaptada a los colores del resto de la aplicación
      appBar: AppBar(
        title: const Text(
          'Mis Entrenamientos',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      // Botón flotante para añadir nuevos registros
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: _goToAddTraining,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      // Árbol de decisiones: Cargando -> Vacío -> Lista con datos
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : _trainings.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    // Botón de papelera para borrar el registro
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _deleteTraining(t['id']),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
