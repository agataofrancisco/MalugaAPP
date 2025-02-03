import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class MalugaDatabase {
  static final MalugaDatabase instance = MalugaDatabase._init();
  static Database? _database;

  MalugaDatabase._init();

  Future <Database?> get database async{
    if (_database != null) return _database!;
    _database = await _initDB('maluga.db');
    return _database;
  }

  //INICIALIZAÇÃO DO BANCO DE DADOS
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 3, onCreate: _createDB);
  }
  //CRIAÇÃO DAS TABELAS DO BANCO
  Future _createDB(Database db, int version) async{
    await db.execute(
      
      /*'''
      CREATE TABLE IF NOT EXISTS profile
      (
        name TEXT NOT NULL,
        location TEXT NOT NULL,
        id_number TEXT NOT NULL, 
        classification Double(10) NOT NULL
      );
      '''
      '''
      CREATE TABLE IF NOT EXISTS alugador
      (
        name TEXT NOT NULL,
        location TEXT NOT NULL,
        alugos INTEGER NOT NULL,
        id_number TEXT NOT NULL, 
        classification Double(10) NOT NULL
      );
      '''*/
      '''
      CREATE TABLE IF NOT EXISTS materials
      (
        id_material INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        quantity INT NOT NULL,
        status TEXT NOT NULL,
        price DECIMAL(10, 2) NOT NULL
      );
      '''
      '''
      CREATE TABLE IF NOT EXISTS alugos
      (
        id_alugo INTEGER PRIMARY KEY AUTOINCREMENT,
        id_material INTEGER NOT NULL,
        name_alugador TEXT NOT NULL,
        contact_alugador TEXT NOT NULL,
        name_material TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        date_alugo DATE NOT NULL,
        date_return DATE NOT NULL,
        total_alugo DOUBLE (10,2),
        FOREIGN KEY (id_material) REFERENCES materials(id_material)
        FOREIGN KEY (name_material) REFERENCES materials(name)
      );
      '''
    );
  }

  //FUNCTION TO INSERT DATA TO AN SPECIFIC TABLE
  Future <int> insert(String table, Map<String, dynamic> data) async{
    final db = await instance.database;
    print("INFORMAÇÕES ADICIONADAS");
    return await db!.insert(table, data);
  }

  //CLEAR A TABLE
  Future<void> clearTable(String table) async{
    final db= await instance.database;
    await db!.delete(table);
    print("TABELA $table Limpa com sucesso");
  }

  //GET ALL DATA FROM THE TABLE 
  Future<List<Map<String, dynamic>>> getAllMaterials(String table)  async {
    final db = await instance.database;
    return await db!.query(
      table,
      where: 'quantity > ?', // Filtra produtos com quantidade > 0
      whereArgs: [0],
      orderBy: 'name ASC', // Ordena por nome em ordem alfabética
    );
  }

  Future<List<Map<String, dynamic>>> getAllData(String table,String ordem) async {
    final db = await instance.database; 
    return await db!.query(table,orderBy: '$ordem DESC');
  }

  //PRINT ALL DATA IN TABLE
  Future<void> printTableData(String table) async {
    final data = await getAllData(table,'id_material');
    if (data.isEmpty) {
      print('A tabela $table está vazia.');
    } else {
      print('Dados da tabela $table:');
      for (var item in data) {
        print(item);
      }
    }
  }

  // Obter dados de uma tabela específica com base no ID
  Future<Map<String, dynamic>?> getData(String table, int id) async {
    final db = await instance.database;
    final maps = await db!.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? maps.first : null;
  }


}