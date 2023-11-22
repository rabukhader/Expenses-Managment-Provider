import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<void> insertData(List<Expense> data) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var item in data) {
        await txn.insert('Expense', item.toJson());
      }
    });
  }

  Future<List<Expense>> getData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Expense');
    return List.generate(maps.length, (index) {
      return Expense.fromJson(maps[index]);
    });
  }
}