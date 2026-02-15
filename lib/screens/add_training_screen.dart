import 'package:flutter/material.dart';
import '../db/database_helper.dart'; // Importamos la base de datos

class AddTrainingScreen extends StatefulWidget {
  const AddTrainingScreen({super.key});

  @override
  State<AddTrainingScreen> createState() => _AddTrainingScreenState();
}

class _AddTrainingScreenState extends State<AddTrainingScreen> {
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Función corregida para guardar en SQLite
  void _saveTraining() async {
    final String exercise = _exerciseController.text.trim();
    final int sets = int.tryParse(_setsController.text) ?? 0;
    final int reps = int.tryParse(_repsController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    // Validamos que los datos sean correctos
    if (exercise.isEmpty || sets <= 0 || reps <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rellena todos los campos correctamente'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Creamos el objeto para guardar
    final newTraining = {
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'date': DateTime.now().toIso8601String(), // Guardamos la fecha actual
    };

    // GUARDAMOS EN LA BASE DE DATOS
    await DatabaseHelper.instance.createTraining(newTraining);

    // Comprobamos si la pantalla sigue abierta antes de usar el contexto
    if (!mounted) return;

    // Volvemos a la pantalla anterior devolviendo 'true' (significa "hemos guardado algo")
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Añadir entrenamiento',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.redAccent), // Flecha roja
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Nuevo Entrenamiento',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            _buildTextField(
              controller: _exerciseController,
              label: 'Ejercicio',
              icon: Icons.fitness_center,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _setsController,
              label: 'Series',
              icon: Icons.repeat,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _repsController,
              label: 'Repeticiones',
              icon: Icons.confirmation_number,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _weightController,
              label: 'Peso (kg)',
              icon: Icons.scale,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _saveTraining,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'GUARDAR ENTRENAMIENTO',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white), // Texto blanco al escribir
      cursorColor: Colors.redAccent,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.redAccent),
        prefixIcon: Icon(icon, color: Colors.redAccent),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
