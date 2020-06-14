import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserData {
  final String name;
  final int age;
  final String gender;
  final int size;
  final int weight;

  UserData(this.name, this.age, this.gender, this.size, this.weight);

  Future<void> persist() async {
    final database = await _getDatabase();
    database.execute(
        "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, gender TEXT, size INTEGER, weight INTEGER)");
    database.insert("users", {
      "name": name,
      "age": age,
      "gender": gender,
      "size": size,
      "weight": weight
    });
  }

  static Future<Map<String, dynamic>> getData() async {
    final database = await _getDatabase();
    return (await database.query("users")).last;
  }

  static Future<Database> _getDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), "userdata.db"));
  }

  static Future<bool> isEmpty() async {
    final usertable = await (await _getDatabase()).rawQuery(
        "SELECT name FROM sqlite_master WHERE name='users' and type='table'");
    return usertable.length == 0;
  }
}
