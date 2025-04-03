import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static const _dbName = "MyDB_hellory.db";
  static const _dbVersion = 1;
  static const tblUser = "tbl_users";

  // Table User Columns
  static const col_user__id           = "__id";
  static const col_user_id            = "user_id";
  static const col_user_fname         = "first_name";
  static const col_user_lname         = "last_name";
  static const col_user_number        = "mobile_number";
  static const col_user_email         = "email";
  static const col_user_admin         = "is_admin";
  static const col_user_info_required = "info_required";
  static const col_user_credit        = "credit";
  static const col_user_gender        = "gender";
  static const col_user_profile       = "profile";
  static const col_user_credit_per_rs = "per_rs_credit";
  static const col_user_token         = "authToken";
  static const col_user_gmailid       = "google_id";
  static const col_user_loginvia      = "login_via";


  late Database _db;

  // Open database
  Future<void> init() async {
    final documentDir = await getApplicationDocumentsDirectory();
    final path = join(documentDir.path, _dbName);

    _db = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreateUser
    );
  }

  // Create User Table
  Future _onCreateUser(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tblUser (
            $col_user__id INTEGER PRIMARY KEY,
            $col_user_id TEXT NULL,
            $col_user_fname TEXT NULL,
            $col_user_lname TEXT NULL,
            $col_user_number TEXT NULL,
            $col_user_email TEXT NULL,
            $col_user_admin INTEGER NULL,
            $col_user_info_required INTEGER NULL,
            $col_user_credit INTEGER NULL,
            $col_user_gender TEXT NULL,
            $col_user_profile TEXT NULL,
            $col_user_credit_per_rs INTEGER NULL,
            $col_user_token TEXT NOT NULL,
            $col_user_gmailid TEXT NULL,
            $col_user_loginvia TEXT NOT NULL
          )
          ''');
  }

  // Insert Method
  Future<int> insert(Map<String, dynamic> row, tableName) async {
    return await _db.insert(tableName, row);
  }

  // Get single row
  Future<Map<String, dynamic>?> query(tableName, where, args) async {
    List<Map<String, dynamic>> list = await _db.query(tableName, where: where, whereArgs: args);
    return list.single;
  }

  // Get all rows
  Future<List<Map<String, dynamic>>> queryAllRows(tableName) async {
    return await _db.query(tableName);
  }

  // Get Row Count
  Future<int> queryRowCount(tableName) async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $tableName');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // Update Data
  Future<int> update(Map<String, dynamic> row, tableName, whereCond) async {
    int id = row[whereCond];
    return await _db.update(tableName, row, where: '$whereCond = ?', whereArgs: [id]);
  }

  // Delete Data
  Future<int> delete(int id, tableName, whereCond) async {
    return await _db.delete(tableName, where: '$whereCond = ?', whereArgs: [id]);
  }

  // Delete All Data
  Future<int> deleteAll(tableName) async {
    return await _db.delete(tableName);
  }

  // Get Auth User Token
  Future<String> getToken(int id) async {
    var users = await _db.query(tblUser, where: '$col_user__id = ?', whereArgs: [id]);
    var userInfo = users.firstOrNull;
    if (userInfo!.isNotEmpty) {
      return userInfo[DBHelper.col_user_token].toString();
    } else {
      return "";
    }
  }

  // Function to login User
   Future<Map<String, dynamic>?>? getUser(tableName) async {
    var user = await _db.query(tableName, limit: 1);
    return user[0];
  }
}