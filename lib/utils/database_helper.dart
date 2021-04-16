import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_tutorial/models/note.dart';

class DatabaseHelper {
  //Constructor
  static DatabaseHelper _databaseHelper;
  static Database _database;
// All variable
  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  //build object when it run
  DatabaseHelper._createInstance();
  //Check whether database helper is null or not
  factory DatabaseHelper(){
    if ( _databaseHelper==null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  //Check whether database is null or not
  Future <Database> get database async{
    if ( _database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }
//Create directory
  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path+ 'notes.db';

    var notesDatabase = await openDatabase(path, version: 1,onCreate: _createDb);

    return notesDatabase;
  }
//Create Database
  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colTitle TEXT,$colDescription TEXT,$colPriority INTEGER,$colDate TEXT)');
  }
  // retrieve data in list view
  Future<List<Map<String, dynamic>>> getNoteMapList() async{
    Database db = await this.database;
    return await db.query(noteTable, orderBy: '$colPriority ASC');
  }

  Future<int> insertNote(Note note) async{
    Database db = await this.database;
    return await db.insert(noteTable, note.toMap());
  }

  Future<int> updateNote(Note note) async{
    Database db = await this.database;
    return await db.update(noteTable, note.toMap(),where: '$colId = ?',whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async{
    Database db = await this.database;
    return await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
  }

  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT(*) FROM $noteTable');
    return Sqflite.firstIntValue(x);
  }

  Future<List<Note>> getNoteList() async{
    var noteMapList = await getNoteMapList();

    int count = noteMapList.length;
    List<Note> noteList = List<Note>();

    for (int i = 0;i<count;i++){
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}