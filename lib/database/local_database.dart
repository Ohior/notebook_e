import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/note_book.dart';

class LocalDatabase {
  static const String _TABLE_NAME = 'notebook';

  static Future<Database> getDatabase() async {
    Directory documentsDirectory =  await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, 'notebook.db');
    var database =
        await openDatabase(path, version: 1, onCreate: (Database database, int version) async{
         await _createDatabase(database);
         debugPrint('************************');
        });
    return database;
  }

  static Future<void> _createDatabase(Database database) async {
    String sql = """CREATE TABLE $_TABLE_NAME(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        detail Text,
        createdTime TEXT,
        imagePath TEXT, 
        updatedTime TEXT)""";
    await database.execute(sql);
  }

  static Future<int> insertNoteBook(NoteBook noteBook) async {
    final db = await getDatabase();
    return await db.insert(_TABLE_NAME, noteBook.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<NoteBook>> getAllNoteBook() async {
    final db = await getDatabase();
    List<Map<String, dynamic>> note =
        await db.query(_TABLE_NAME);
    return List.generate(
        note.length,
        (index) => NoteBook(
            id: note[index]['id'],
            title: note[index]['title'],
            detail: note[index]['detail'],
            imagePath: note[index]['imagePath'],
            createdTime: note[index]['createdTime'],
            updatedTime: note[index]['updatedTime']));
  }

  static Future<NoteBook> getNoteBook(NoteBook noteBook) async {
    final db = await getDatabase();
    List<Map<String, dynamic>> note = await db.query(_TABLE_NAME,
        where: 'id = ?', whereArgs: [noteBook.id], limit: 1);
    return List.generate(
        note.length,
        (index) => NoteBook(
            id: note[index]['id'],
            title: note[index]['title'],
            detail: note[index]['detail'],
            imagePath: note[index]['imagePath'],
            createdTime: note[index]['createdTime'],
            updatedTime: note[index]['updatedTime'])).first;
  }

  static Future<void> updateNoteBook(NoteBook noteBook) async {
    final db = await getDatabase();
    db.update(_TABLE_NAME, noteBook.toMap(),
        where: 'id = ?', whereArgs: [noteBook.id]);
  }

  static Future<void> deleteNoteBook(NoteBook noteBook)async{
    final db = await getDatabase();
    db.delete(_TABLE_NAME, where: 'id = ?', whereArgs: [noteBook.id]);
  }
}
