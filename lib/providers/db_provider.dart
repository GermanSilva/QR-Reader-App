import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader_app/models/scan_model.dart';
export 'package:qr_reader_app/models/scan_model.dart';

class DBProvider {
  static Database? _dataBase;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_dataBase != null) return _dataBase!;

    _dataBase = await initDB();

    return _dataBase!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'scansDB.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
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

  // CREATE
  nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Verificar base de datos
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor)
        VALUES( $id, '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toMap());

    print(res);
    // este es el ID del ultimo registro
    return res;
  }

  // READ
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    print(res);
    return res.isNotEmpty ? ScanModel.fromMap(res.first) : null;
  }

  Future<List<ScanModel>?> getScanByTipo(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);

    print(res);
    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromMap(e)).toList()
        : null;
  }

  Future<List<ScanModel>?> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    print(res);
    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromMap(e)).toList()
        : null;
  }

  // UPDATE
  Future<int> updateScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.update('Scans', newScan.toMap(),
        where: 'id = ?', whereArgs: [newScan.id]);

    print('updateScan: $res');
    return res;
  }

  // DELETE
  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    print('deleteScanById: $res');
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');

    print('deleteAllScans: $res');
    return res;
  }
}
