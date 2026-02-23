import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class AddTrainingScreen extends StatefulWidget {
  const AddTrainingScreen({super.key});

  @override
  State<AddTrainingScreen> createState() => _AddTrainingScreenState();
}

class _AddTrainingScreenState extends State<AddTrainingScreen> {
  // Controladores para capturar los datos del formulario
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Valida y guarda el registro en la base de datos local SQLite
  void _saveTraining() async {
    final String exercise = _exerciseController.text.trim();
    final int sets = int.tryParse(_setsController.text) ?? 0;
    final int reps = int.tryParse(_repsController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    // Validación de campos obligatorios
    if (exercise.isEmpty || sets <= 0 || reps <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, rellena todos los campos correctamente.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Construcción del mapa de datos para SQLite
    final newTraining = {
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'date': DateTime.now().toIso8601String(), // Timestamp automático
    };

    // Inserción asíncrona en la base de datos
    await DatabaseHelper.instance.createTraining(newTraining);

    // Prevención de fugas de memoria si el usuario cierra la pantalla antes de terminar
    if (!mounted) return;

    // Retorna a la pantalla anterior enviando 'true' para forzar la recarga de la lista
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Añadir Entrenamiento',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.redAccent,
        ), // Color de la flecha de retroceso
      ),
      // SingleChildScrollView evita errores de desbordamiento al abrir el teclado
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

            // Uso de un método modular para generar los TextFields dinámicamente
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

            // Botón de guardado
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

  // Método modular para construir TextFields personalizados
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
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
