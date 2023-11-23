import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../view_model/expense_view_model.dart';

class DBHelper {
  static Database? localDatabase;
  static final DBHelper instance = DBHelper._();

  DBHelper._();

  Future<Database> get database async {
    if (localDatabase != null) return localDatabase!;

    localDatabase = await initDB();
    return localDatabase!;
  }

  Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'Expense.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Expense (
            id TEXT PRIMARY KEY,
            name TEXT,
            total INTEGER,
            address TEXT,
            dueDate TEXT,
            imageUrl TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertData(Map<String, Expense> data) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var entry in data.entries) {
        final id = entry.key;
        final expense = entry.value;
        await txn.insert(
          'Expense',
          expense.toJson()..['id'] = id,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<Map<String, Expense>> getData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Expense');

    return {
      for (var item in maps) item['id'].toString(): Expense.fromJson(item)
    };
  }

  Future<void> updateExpense(String id, changes) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.update('Expense', changes, where: 'id = ?', whereArgs: [id]);
    });
  }

  Future<void> deleteExpense(String id) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('Expense', where: 'id = ?', whereArgs: [id]);
    });
  }

  Future<void> syncLocalChangesWithApi() async {
    final localChanges = ExpensesViewModel().localChanges;
    if (localChanges.isEmpty) {
      return;
    }

    for (var localChange in localChanges) {
      if (localChange.changes.containsKey('deleted')) {
        await api.deleteExpense(localChange.id);
      } else if (localChange.changes.containsKey('edited')) {
        await api.updateExpense(localChange.id, localChange.changes['edited']);
      } else {
        await api.postExpense(localChange.changes);
      }
    }

    localChanges.clear();
  }

  Future<void> clearData() async {
    final db = await database;
    await db.delete('Expense');
  }
}
