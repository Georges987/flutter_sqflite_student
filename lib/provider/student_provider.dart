import 'package:applcation_test/models/etudiant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StuProvider {
  Database? base;

  Future<Database> get() async {
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
}
