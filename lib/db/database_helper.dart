import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await (String filePath) async {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(path, version: 1, onCreate: _createDB);
    }('mygym.db');
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    // Aquí definimos la tabla donde se guardan los entrenos
    await db.execute('''
    CREATE TABLE trainings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      exercise TEXT NOT NULL,
      sets INTEGER NOT NULL,
      reps INTEGER NOT NULL,
      weight REAL NOT NULL,
      date TEXT NOT NULL
    )
    ''');
  }

  // --- FUNCIONES PARA USAR LA BASE DE DATOS ---

  // 1. Guardar un entrenamiento
  Future<int> createTraining(Map<String, dynamic> training) async {
    final db = await instance.database;
    return await db.insert('trainings', training);
  }

  // 2. Leer todos los entrenamientos
  Future<List<Map<String, dynamic>>> readAllTrainings() async {
    final db = await instance.database;
    // Los ordenamos por fecha (el más nuevo primero)
    return await db.query('trainings', orderBy: 'date DESC');
  }

  // 3. Borrar un entrenamiento
  Future<int> deleteTraining(int id) async {
    final db = await instance.database;
    return await db.delete('trainings', where: 'id = ?', whereArgs: [id]);
  }
}
