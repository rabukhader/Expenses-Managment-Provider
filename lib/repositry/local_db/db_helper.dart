import 'package:expenses_managment_app_provider/repositry/firebase/end_point.dart';
import 'package:expenses_managment_app_provider/repositry/supabase/end_point_supabase.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/entities/expense_entity.dart';
import '../../view_model/manage_expense_view_model.dart';

class DBHelper extends EndPoint {
  static Database? localDatabase;
  static final DBHelper instance = DBHelper._();
  EndPointSupabase endPointSupabase = EndPointSupabase();

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

  @override
  Future fetchExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Expense');

    return {
      for (var item in maps) item['id'].toString(): Expense.fromMap(item)
    };
  }

  @override
  Future postExpense(expenseData) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var entry in expenseData.entries) {
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

  @override
  Future updateExpense(expenseId, updatedData) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.update('Expense', updatedData,
          where: 'id = ?', whereArgs: [expenseId]);
    });
  }

  @override
  Future<void> deleteExpense(expenseId) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('Expense', where: 'id = ?', whereArgs: [expenseId]);
    });
  }

  Future<void> syncLocalChangesWithApi() async {
    final localChanges = ManageExpensesViewModel().localChanges;
    if (localChanges.listOfLocalChanges.isEmpty) {
      return;
    }

    for (var localChange in localChanges.listOfLocalChanges) {
      if (localChange.changes.containsKey('deleted')) {
        await endPointSupabase.deleteExpense(localChange.id);
      } else if (localChange.changes.containsKey('edited')) {
        await endPointSupabase.updateExpense(
            localChange.id, localChange.changes['edited']);
      } else {
        await endPointSupabase.postExpense(localChange.changes);
      }
    }

    localChanges.listOfLocalChanges.clear();
  }

  Future<void> clearData() async {
    final db = await database;
    await db.delete('Expense');
  }

  Future<List<Expense>> searchExpenses(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.transaction((txn) => txn.query(
              'Expense',
              where: 'name LIKE ?',
              whereArgs: ['%$query%'],
            ));

    return List.generate(maps.length, (i) {
      return Expense(
        name: maps[i]['name'],
        total: maps[i]['total'],
        address: maps[i]['address'],
        dueDate: maps[i]['dueDate'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }
}
