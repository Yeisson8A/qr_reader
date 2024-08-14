import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    // Validar si ya se ha inicializado la base de datos, en cuyo caso se devuelve la instancia creada
    if (_database != null) return _database!;

    // En caso de no estar inicializada se crea
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    // Path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // Armamos la ruta con el nombre de la base de datos
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);
    // Crear base de datos
    return await openDatabase(
      path, // Ruta definida para la base de datos
      version: 1, // Se debe cambiar cada vez que se hagan cambios estructurales en la base de datos, de lo contrario no ejecutará la rutina de creación
      onOpen: (db) {}, // Ejecutar código al abrir la base de datos
      onCreate: (db, version) async { // Ejecutar código al momento de crear la base de datos
        // Crear tabla para almacenar scans
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    // Desestructurar valores a insertar
    final ScanModel(:id, :tipo, :valor) = nuevoScan;
    // Obtener instancia de la base de datos
    final db = await database;
    // Ejecutar inserción pasando SQL
    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor) VALUES ($id, $tipo, $valor)
    ''');
    // Id del registro insertado
    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    // Obtener instancia de la base de datos
    final db = await database;
    // Ejecutar inserción mediante un mapa del objeto a insertar
    final res = await db.insert('Scans', nuevoScan.toJson());
    // Id del registro insertado
    return res;
  }

  Future<ScanModel?> getScanPorId(int id) async {
    // Obtener instancia de la base de datos
    final db = await database;
    // Ejecutar consulta filtrando por id
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    // Regresar resultado
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    // Obtener instancia de la base de datos
    final db = await database;
    // Ejecutar consulta
    final res = await db.query('Scans');
    // Regresar resultado
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    // Obtener instancia de la base de datos
    final db = await database;
    // Ejecutar consulta filtrando por id
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    // Regresar resultado
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel scanActualizar) async {
    // Obtener instancia de la base de datos
    final db = await database;
    // Ejecutar actualización mediante un mapa del objeto a actualizar
    final res = await db.update('Scans', scanActualizar.toJson(), where: 'id = ?', whereArgs: [scanActualizar.id]);
    // Cantidad de registros actualizados
    return res;
  }

  Future<int> deleteScan(int id) async {
    // Obtener instancia de la base de datos
    final db = await database;
    // Ejecutar eliminación por id
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    // Cantidad de registros eliminados
    return res;
  }

  Future<int> deleteAllScans() async {
    // Obtener instancia de la base de datos
    final db = await database;
    // Ejecutar eliminación
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    // Cantidad de registros eliminados
    return res;
  }
}