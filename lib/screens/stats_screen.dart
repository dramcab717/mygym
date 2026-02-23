import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<Map<String, dynamic>> _myRecords = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final data = await DatabaseHelper.instance.readAllTrainings();
    setState(() {
      _myRecords = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Muro de Marcas',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : _myRecords.isEmpty
          ? const Center(
              child: Text(
                'Aún no hay entrenamientos registrados.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          //Usamos GridView
          : GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                crossAxisSpacing: 15, // Espacio horizontal entre tarjetas
                mainAxisSpacing: 15, // Espacio vertical
                childAspectRatio: 1.0, // Que sean cuadrados perfectos
              ),
              itemCount: _myRecords.length,
              itemBuilder: (context, index) {
                final record = _myRecords[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(15),
                    // Le ponemos un borde finito rojo a los cuadrados
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icono de trofeo
                      const Icon(
                        Icons.emoji_events,
                        color: Colors.amber,
                        size: 40,
                      ),
                      const SizedBox(height: 10),

                      // Nombre del ejercicio
                      Text(
                        record['exercise'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),

                      // Los kilos
                      Text(
                        '${record['weight']} kg',
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Las series y reps
                      Text(
                        '${record['sets']} series x ${record['reps']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
