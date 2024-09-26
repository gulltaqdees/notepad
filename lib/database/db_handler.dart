
import 'package:notepad/model/notes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DbHelper {
  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  _onCreate(Database db, int version) async {
    db.execute(
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, color TEXT NOT NULL)');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async{
    if(oldVersion<newVersion){
      db.execute('ALTER TABLE notes ADD COLUMN color TEXT NOT NULL DEFAULT "ffffff"');
    }
  }

  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
     await dbClient!.insert('notes', notesModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
     return notesModel;
  }

  Future<List<NotesModel>> getNotesList()async{
    var dbClient = await db;
    List<Map<String, Object?>> queryResult= await dbClient!.query('notes');
    return queryResult.map((e)=>NotesModel.fromMap(e)).toList();
  }

  Future<NotesModel> getNote(int id)async{
    var dbClient =  await db;
    List<Map<String,Object?>> queryResult = await dbClient!.query('notes',
    where: 'id=?',
    whereArgs: [id]);
    return NotesModel.fromMap(queryResult.first);
  }
  Future<int> deleteNotes(int id)async{
    var dbClient = await db;
    return dbClient!.delete('notes',where: 'id=?', whereArgs: [id]);
  }

  Future<int> updateNotes(NotesModel notesModel)async{
    var dbClient = await db;
    return dbClient!.update('notes', notesModel.toMap(),where: 'id=?', whereArgs: [notesModel.id]);
  }

  void deleteDatabaseFile()async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'notes.db');
    await deleteDatabase(path);
  }
}
