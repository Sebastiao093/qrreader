import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {

  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async{
    if (_database != null) {
      return _database;
    }

    _database = await initDB();

    return _database;

  }

  Future<Database?> initDB() async{

    //Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'ScansDB.db' );

    print(path);

    //Crear base de datos
    return await openDatabase(
      path, 
      version: 1,
      onOpen: (Database db){

      },
      onCreate: (Database db, int version) async {

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

  Future<int> nuevoScanRaw( ScanModel newScan ) async{

    final id = newScan.id;
    final tipo = newScan.tipo;
    final valor = newScan.valor;

    //Verificar la base de datos
    final db = await database;


    final respuesta = await db!.rawInsert('''
        INSERT INTO Scans(id, tipo, valor)
           VALUES ($id, '$tipo', '$valor')
      ''');


    return respuesta;

  }

  Future<int> nuevoScan(ScanModel newScan) async{

    final db = await database;

    final respuesta = await db!.insert('Scans', newScan.toJson());

    print(respuesta);

    return respuesta;

  }

  Future<ScanModel?> getScanById( int id) async{
    final db = await database;

    final respuesta = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);

    return respuesta.isNotEmpty 
    ? ScanModel.fromJson( respuesta.first ) 
    : null;

  }

  Future<List<ScanModel>?> getAllScans() async{
    final db = await database;

    final respuesta = await db!.query('Scans');

    return respuesta.isNotEmpty 
    ? respuesta.map((s) => ScanModel.fromJson(s)).toList()
    : null;

  }

  Future<List<ScanModel>?> getScansPorTipo( String tipo) async{
    final db = await database;

    final respuesta = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo' 
    ''');

    return respuesta.isNotEmpty 
    ? respuesta.map((s) => ScanModel.fromJson(s)).toList()
    : [];

  }

  Future<int> updateScan( ScanModel newScan) async {
    final db = await database;

    final respuesta = await db!.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [ newScan.id]);

    return respuesta;
  }

  Future<int> deleteScan( int id) async{
    final db = await database;

    final respuesta = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return respuesta;

  }

  Future<int> deleteAllScans() async{
    final db = await database;

    final respuesta = await db!.delete('Scans');

    return respuesta;

  }

  Future<int> deleteAllScansWithRaw() async{
    final db = await database;

    final respuesta = await db!.rawDelete('''
      DELETE FROM Scans
    ''');

    return respuesta;

  }



  

  
}