import 'dart:io';

import 'package:applcation_test/models/etudiant.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class StuProvider {
  Database? base;

  Future<Database> get() async {
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      databaseFactory = databaseFactoryFfi;
    }

    base ??= await openDatabase(
      join(await getDatabasesPath(), 'students.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY, matricule TEXT, nom TEXT, prenom TEXT, sexe TEXT, birth INTEGER, telephone TEXT)',
        );
      },
      version: 1,
    );
    return base!;
  }

  Future<void> insert(Student student) async {
    final Database db = await get();
    await db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> students() async {
    final Database db = await get();
    final List<Map<String, dynamic>> maps = await db.query('students');
    return List.generate(maps.length, (i) {
      return Student(
        maps[i]['id'] as int,
        maps[i]['matricule'] as String,
        maps[i]['nom'] as String,
        maps[i]['prenom'] as String,
        maps[i]['sexe'] as String,
        DateTime.fromMillisecondsSinceEpoch(maps[i]['birth'] as int),
        maps[i]['telephone'] as String,
      );
    });
  }

  Future<void> update(Student student) async {
    final Database db = await get();
    await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<void> delete(int id) async {
    final Database db = await get();
    await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final Database db = await get();
    await db.delete('students');
  }

  Future<void> close() async {
    final Database db = await get();
    await db.close();
  }

  Future<void> insertFalseData() async {
    final Database db = await get();
    for (var i = 0; i < 60; i++) {
      await db.insert(
      'students',
      Student(
        i,
        "18A00000",
        "Nom $i",
        "Prenom $i",
        "Masculin",
        DateTime.now(),
        "0000000$i",
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    }
    
  }
}
