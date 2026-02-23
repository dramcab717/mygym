import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  List<dynamic> _allExercises = [];
  List<dynamic> _foundExercises = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  // Descarga el archivo JSON con los ejercicios desde el repositorio público de GitHub
  Future<void> _fetchExercises() async {
    final url = Uri.parse(
      'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/dist/exercises.json',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          _allExercises = data;
          _foundExercises = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error del servidor: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error de conexión. Revisa tu internet.';
        _isLoading = false;
      });
    }
  }

  // Filtra la lista de ejercicios según el texto introducido en el buscador
  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allExercises;
    } else {
      results = _allExercises
          .where(
            (exercise) => exercise['name'].toString().toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
          )
          .toList();
    }

    setState(() {
      _foundExercises = results;
    });
  }

  // Muestra una ventana emergente (Dialog) con las instrucciones detalladas del ejercicio
  void _showExerciseDetails(BuildContext context, dynamic exercise) {
    List<dynamic> rawInstructions = exercise['instructions'] ?? [];
    String instructions = rawInstructions.join('\n\n');

    String equipment = exercise['equipment'] ?? 'Libre';
    String level = exercise['level'] ?? 'Principiante';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.redAccent, width: 2),
          ),
          title: Text(
            exercise['name'].toString(),
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.fitness_center, size: 60, color: Colors.grey),
                const SizedBox(height: 15),
                Text(
                  'Nivel: $level | Material: $equipment',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  instructions.isEmpty
                      ? 'Sin instrucciones detalladas.'
                      : instructions,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'CERRAR',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Biblioteca de Ejercicios'),
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : _errorMessage.isNotEmpty
          ? Center(
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.redAccent),
              ),
            )
          : Column(
              children: [
                // Buscador
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Buscar ejercicio...',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.redAccent,
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(30, 30, 30, 1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                // Lista de resultados
                Expanded(
                  child: _foundExercises.isNotEmpty
                      ? ListView.builder(
                          itemCount: _foundExercises.length,
                          itemBuilder: (context, index) {
                            final ex = _foundExercises[index];
                            List<dynamic> muscles = ex['primaryMuscles'] ?? [];
                            String muscleName = muscles.isNotEmpty
                                ? muscles[0].toString()
                                : 'General';

                            return Card(
                              color: const Color.fromRGBO(30, 30, 30, 1),
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Text(
                                    ex['name'].toString()[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  ex['name'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  muscleName.toUpperCase(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.redAccent,
                                  size: 16,
                                ),
                                onTap: () => _showExerciseDetails(context, ex),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            'No se encontraron ejercicios',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
