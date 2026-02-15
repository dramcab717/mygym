import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Librería de gráficos
import '../db/database_helper.dart'; // Base de datos

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<FlSpot> _spots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await DatabaseHelper.instance.readAllTrainings();

    if (data.isEmpty) {
      setState(() => _isLoading = false);
      return;
    }

    // Ordenamos los datos por fecha
    List<Map<String, dynamic>> sortedData = List.from(data);
    sortedData.sort((a, b) => a['date'].compareTo(b['date']));

    List<FlSpot> tempSpots = [];

    // Creamos los puntos (X, Y)
    for (int i = 0; i < sortedData.length; i++) {
      double peso = (sortedData[i]['weight'] as num).toDouble();
      tempSpots.add(FlSpot(i.toDouble(), peso));
    }

    setState(() {
      _spots = tempSpots;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Mi Progreso'),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.redAccent),
        titleTextStyle: const TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : _spots.isEmpty
          ? _buildEmptyState()
          : _buildChart(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.show_chart, size: 80, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            "Aún no tienes datos",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            "Registra entrenamientos para ver tu gráfica",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(
        children: [
          const Text(
            "Evolución de Cargas (kg)",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),

          Expanded(
            child: LineChart(
              LineChartData(
                // 1. Cuadrícula de fondo
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      // Gris (158,158,158) con 0.2 de opacidad
                      color: const Color.fromRGBO(158, 158, 158, 0.2),
                      strokeWidth: 1,
                    );
                  },
                ),

                // 2. Títulos
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}kg',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // 3. Bordes
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    // Gris transparente
                    color: const Color.fromRGBO(158, 158, 158, 0.2),
                  ),
                ),

                minX: 0,
                maxX: (_spots.length - 1).toDouble(),
                minY: 0,

                // 4. DATOS
                lineBarsData: [
                  LineChartBarData(
                    spots: _spots,
                    isCurved: true,
                    color: Colors.redAccent,
                    barWidth: 4,
                    isStrokeCapRound: true,

                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: Colors.redAccent,
                        );
                      },
                    ),

                    belowBarData: BarAreaData(
                      show: true,
                      // Rojo (255, 82, 82) con 0.2 de opacidad
                      color: const Color.fromRGBO(255, 82, 82, 0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
