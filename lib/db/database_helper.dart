import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Patrón Singleton para asegurar una única instancia de la base de datos
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Getter asíncrono que devuelve la base de datos o la inicializa si no existe
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mygym.db');
    return _database!;
  }

  // Método privado para establecer la ruta e inicializar SQLite
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Creación de la estructura de la tabla principal
  Future _createDB(Database db, int version) async {
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

  // Inserta un nuevo registro de entrenamiento en la base de datos
  Future<int> createTraining(Map<String, dynamic> training) async {
    final db = await instance.database;
    return await db.insert('trainings', training);
  }

  // Recupera todos los registros ordenados por fecha (el más reciente primero)
  Future<List<Map<String, dynamic>>> readAllTrainings() async {
    final db = await instance.database;
    return await db.query('trainings', orderBy: 'date DESC');
  }

  // Elimina un registro específico mediante su identificador único (ID)
  Future<int> deleteTraining(int id) async {
    final db = await instance.database;
    return await db.delete('trainings', where: 'id = ?', whereArgs: [id]);
  }
}
