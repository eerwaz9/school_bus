import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_ksa/lib/Model/InLocoParent.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:sqflite/sqflite.dart';

class DBProviderUser {
  DBProviderUser() {
    initDB();
  }

  //
  // void _onUpgrade(Database db, int oldVersion, int newVersion) {
  //   if (oldVersion < newVersion) {
  //     db.execute("ALTER TABLE ${UserTextTable.TABLE_USER_NAME} ADD COLUMN "
  //         " ${UserTextTable.ID_USER_API_TEXT}  INTEGER NULL;");
  //   }
  //
  //
  //   //PRINT("Done Update Table "+ UserTextTable.TABLE_USER_NAME);
  //
  // }
  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, DATABASE.DB_NAME);

    var database = await openDatabase(dbPath,
        version: DATABASE.DB_VERSION,
        onCreate: populateDb,
        onUpgrade: _onUpgrade);
    return database;
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();

    return _database;
  }

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE ${UserTextTable.TABLE_USER_NAME} ("
        "${UserTextTable.ID_USER_TEXT} INTEGER PRIMARY KEY,"
        "${UserTextTable.FULL_NAME_TEXT}  TEXT,"
        "${UserTextTable.USERNAME_TEXT}  TEXT,"
        "${UserTextTable.PASSWORD_TEXT}  TEXT,"
        "${UserTextTable.EMAILE_TEXT}  TEXT,"
        "${UserTextTable.KEY_VERIFY_TEXT}  TEXT,"
        "${UserTextTable.SEESION_TEXT}  TEXT,"
        "${UserTextTable.PHONE_NO_TEXT}  TEXT,"
        "${UserTextTable.KEY_ACTIVE_STATUS_TEXT}  BIT,"
        "${UserTextTable.DATE_UPDATE_TEXT}  TEXT,"
        "${UserTextTable.DATE_ADDED_TEXT}  TEXT,"
        "${UserTextTable.IMAGES_USER_TEXT}  TEXT,"
        "${UserTextTable.IMEI_device_TEXT}  TEXT,"
        "${UserTextTable.IS_VERIFY_TEXT}  BIT"
        ")");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    db.execute("ALTER TABLE ${UserTextTable.TABLE_USER_NAME} ADD COLUMN "
        " ${UserTextTable.ID_USER_API_TEXT}  INTEGER NULL;");

    //PRINT("Done Update Table "+ UserTextTable.TABLE_USER_NAME);
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE.DB_NAME);
    var todosDatabase = await openDatabase(path,
        version: DATABASE.DB_VERSION,
        onUpgrade: _onUpgrade,
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE ${DriverBusesTextTable.TABLE_DriverBuses_NAME} ("
          "${DriverBusesTextTable.ID_DriverBuses_TEXT} INTEGER PRIMARY KEY,"
          "${DriverBusesTextTable.ID_DriverBuses_API_TEXT} INTEGER NULL,"
          "${DriverBusesTextTable.School_TEXT}  TEXT,"
          "${DriverBusesTextTable.FULL_NAME_TEXT}  TEXT,"
          "${DriverBusesTextTable.USERNAME_TEXT}  TEXT,"
          "${DriverBusesTextTable.PASSWORD_TEXT}  TEXT,"
          "${DriverBusesTextTable.EMAILE_TEXT}  TEXT,"
          "${DriverBusesTextTable.KEY_VERIFY_TEXT}  TEXT,"
          "${DriverBusesTextTable.SEESION_TEXT}  TEXT,"
          "${DriverBusesTextTable.PHONE_NO_TEXT}  TEXT,"
          "${DriverBusesTextTable.KEY_ACTIVE_STATUS_TEXT}  BIT,"
          "${DriverBusesTextTable.DATE_UPDATE_TEXT}  TEXT,"
          "${DriverBusesTextTable.DATE_ADDED_TEXT}  TEXT,"
          "${DriverBusesTextTable.IMAGES_DriverBuses_TEXT}  TEXT,"
          "${DriverBusesTextTable.IMEI_device_TEXT}  TEXT,"
          "${DriverBusesTextTable.IS_VERIFY_TEXT}  BIT"
          ")");

      await db.execute("CREATE TABLE ${UserTextTable.TABLE_USER_NAME} ("
          "${UserTextTable.ID_USER_TEXT} INTEGER PRIMARY KEY,"
          "${UserTextTable.ID_USER_API_TEXT} INTEGER NULL,"
          "${UserTextTable.FULL_NAME_TEXT}  TEXT,"
          "${UserTextTable.USERNAME_TEXT}  TEXT,"
          "${UserTextTable.PASSWORD_TEXT}  TEXT,"
          "${UserTextTable.EMAILE_TEXT}  TEXT,"
          "${UserTextTable.KEY_VERIFY_TEXT}  TEXT,"
          "${UserTextTable.SEESION_TEXT}  TEXT,"
          "${UserTextTable.PHONE_NO_TEXT}  TEXT,"
          "${UserTextTable.KEY_ACTIVE_STATUS_TEXT}  BIT,"
          "${UserTextTable.DATE_UPDATE_TEXT}  TEXT,"
          "${UserTextTable.DATE_ADDED_TEXT}  TEXT,"
          "${UserTextTable.IMAGES_USER_TEXT}  TEXT,"
          "${UserTextTable.IMEI_device_TEXT}  TEXT,"
          "${UserTextTable.IS_VERIFY_TEXT}  BIT"
          ")");

      // await db.execute("ALTER  TABLE ${UserTextTable.TABLE_USER_NAME} ADD COLUMN "
      //     "${UserTextTable.ID_USER_API_TEXT} INTEGER NULL;");
      //
      // //PRINT("Done Update Table "+ UserTextTable.TABLE_USER_NAME);
    });

    return todosDatabase;
  }

  Future<List<Map>> fetchUserAccount() async {
    final db = await database;
    List<Map> list =
        await db.rawQuery('SELECT * FROM ${UserTextTable.TABLE_USER_NAME}');
    //PRINT(list);
    return list;
  }

  updateLastUser(InLocaParent newUser) async {
    final db = await database;
    var Table = await db.rawQuery(
        "SELECT * FROM ${UserTextTable.TABLE_USER_NAME} ORDER BY ${UserTextTable.ID_USER_TEXT} DESC LIMIT 1");
    var table = await db.rawQuery(
        "SELECT MAX(${UserTextTable.ID_USER_TEXT})+1 as ${UserTextTable.ID_USER_TEXT} FROM ${UserTextTable.TABLE_USER_NAME}");
    //PRINT("Data User Data User Data User Data User   ${table.map((c) => InLocaParent.fromMap(c)).toList()}");
    int id_d = Table.first["${UserTextTable.ID_USER_TEXT} "];
    var res = await db.update(
        "${UserTextTable.TABLE_USER_NAME} ", newUser.toMap(),
        where: "${UserTextTable.EMAILE_TEXT} = ?", whereArgs: [newUser.Email]);
    return res;
  }

  getIdLastUser() async {
    final db = await database;

    var Table = await db.rawQuery(
        "SELECT * FROM ${UserTextTable.TABLE_USER_NAME} ORDER BY ${UserTextTable.ID_USER_TEXT} DESC LIMIT 1");

    // //PRINT("Data User Data User Data User Data User   ${table.map((c) => InLocaParent.fromMap(c)).toList()}");
    int id_d = Table.first["${UserTextTable.ID_USER_TEXT} "];
    return id_d;
  }

  updateLastUserdddddddddd(InLocaParent newUser) async {
    final db = await database;

    var Table = await db.rawQuery(
        "SELECT * FROM ${UserTextTable.TABLE_USER_NAME} ORDER BY ${UserTextTable.ID_USER_TEXT} DESC LIMIT 1");

    var table = await db.rawQuery(
        "SELECT MAX(${UserTextTable.ID_USER_TEXT})+1 as ${UserTextTable.ID_USER_TEXT} FROM ${UserTextTable.TABLE_USER_NAME}");

    //PRINT("Data User Data User Data User Data User   ${table.map((c) => InLocaParent.fromMap(c)).toList()}");
    int id_d = Table.first["${UserTextTable.ID_USER_TEXT} "];

    //PRINT("IDDDDDDDDDDDDDDDDD USSSSSSSSSSSSSSSER  $id_d");
    var res = await db.update(
        "${UserTextTable.TABLE_USER_NAME} ", newUser.toMap(),
        where: "${UserTextTable.ID_USER_TEXT} = ?", whereArgs: [id_d]);
    return res;
  }

  GetIsVerifyForLastUser() async {
    final db = await database;

    var table = await db.rawQuery("SELECT MAX(${UserTextTable.ID_USER_TEXT}) "
        "as ${UserTextTable.ID_USER_TEXT} FROM ${UserTextTable.TABLE_USER_NAME}");

    int id_d = table.first["${UserTextTable.ID_USER_TEXT} "];
    //PRINT("IDDDDDDDDDDDDDDDDD USSSSSSSSSSSSSSSER  $id_d");

    return null;
  }

  getUserByEmile(String Emile) async {
    final db = await database;
    var res = await db.query("${UserTextTable.TABLE_USER_NAME} ",
        where: "${UserTextTable.EMAILE_TEXT} = ?", whereArgs: [Emile]);
    return res.isNotEmpty ? InLocaParent.fromMap(res.first) : Null;
  }

/*
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableEmployee'));
  }



  Future<Employee> getEmployee(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableEmployee,
        columns: [columnId, columnAge, columnName, columnCity, columnDepartment, columnDescription],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return new Employee.fromMap(result.first);
    }*/
/*

    return null;
  }
*/

  Future<int> updateInLocaParent(InLocaParent employee) async {
    var dbClient = await database;
    return await dbClient.update(
        UserTextTable.TABLE_USER_NAME, employee.toMap(),
        where: "${UserTextTable.ID_USER_TEXT} = ?", whereArgs: [employee.id]);
  }

  Future close() async {
    var dbClient = await database;
    return dbClient.close();
  }

  newUser(InLocaParent newUser) async {
    final db = await database;
    //get the biggest id in the table
    // var table = await db.rawQuery("SELECT MAX(${UserTextTable.ID_USER_TEXT})+1 as ${UserTextTable.ID_USER_TEXT} FROM ${UserTextTable.TABLE_USER_NAME}");
    // int id_d = table.first["${UserTextTable.ID_USER_TEXT} "];
    // //PRINT("Data User Data User Data User Data User 1  ${table.map((c) => InLocaParent.fromMap(c)).toList()}");

    //insert to the table using the new id

    DateTime dataNew = DateTime.now();
    var raw = await db.rawInsert(
        "INSERT Into ${UserTextTable.TABLE_USER_NAME}("
        "${UserTextTable.ID_USER_TEXT} ,"
        "${UserTextTable.ID_USER_API_TEXT} ,"
        "${UserTextTable.FULL_NAME_TEXT} ,"
        "${UserTextTable.EMAILE_TEXT} ,"
        "${UserTextTable.PASSWORD_TEXT} ,"
        "${UserTextTable.USERNAME_TEXT} ,"
        "${UserTextTable.KEY_VERIFY_TEXT} ,"
        "${UserTextTable.SEESION_TEXT} ,"
        "${UserTextTable.PHONE_NO_TEXT} ,"
        "${UserTextTable.IMEI_device_TEXT}, "
        "${UserTextTable.IS_VERIFY_TEXT} ,"
        "${UserTextTable.DATE_ADDED_TEXT} ,"
        "${UserTextTable.DATE_UPDATE_TEXT} ,"
        "${UserTextTable.IMAGES_USER_TEXT} ,"
        "${UserTextTable.KEY_ACTIVE_STATUS_TEXT} "
        " )"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          newUser.id != null ? newUser.id : 1,
          newUser.id,
          newUser.Full_Name,
          newUser.Email,
          newUser.password,
          newUser.UserName,
          newUser.keyVerify,
          newUser.session_no,
          newUser.PhoneNo,
          newUser.IMEI_device,
          newUser.isVerify,
          dataNew.toString(),
          dataNew.toString(),
          newUser.images_user,
          newUser.KeyActiveStatus
        ]);

    // //PRINT("IDDDDDDDDDDDDDDDDDDDDDDINSERRRRRRRRT2   $id_d ");
    // //PRINT("Data User Data User Data User Data User 2   ${table.map((c) => InLocaParent.fromMap(c)).toList()}");

    return raw;
  }

  newUserTow(InLocaParent newUser) async {
    final db = await database;
    var res =
        await db.insert("${UserTextTable.TABLE_USER_NAME} ", newUser.toMap());
    return res;
  }

  getUser(int id) async {
    final db = await database;
    var res = await db.query("${UserTextTable.TABLE_USER_NAME} ",
        where: "${UserTextTable.ID_USER_TEXT} = ?", whereArgs: [id]);
    return res.isNotEmpty ? InLocaParent.fromMap(res.first) : Null;
  }

  Future<List> getAllInLocaParent() async {
    final db = await database;
    var res = await db.query("${UserTextTable.TABLE_USER_NAME} ");
    List<InLocaParent> list =
        res.isNotEmpty ? res.map((c) => InLocaParent.fromMap(c)).toList() : [];
    return list;
  }

  getBlockedInLocaParent() async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM ${UserTextTable.TABLE_USER_NAME} WHERE ${UserTextTable.IS_VERIFY_TEXT} =1");
    List<InLocaParent> list = res.isNotEmpty
        ? res.toList().map((c) => InLocaParent.fromMap(c))
        : null;
    return list;
  }

  updateUser(InLocaParent newUser) async {
    final db = await database;
    var res = await db.update(
        "${UserTextTable.TABLE_USER_NAME} ", newUser.toMap(),
        where: "${UserTextTable.ID_USER_TEXT} = ?", whereArgs: [newUser.id]);
    return res;
  }

  blockOrUnblock(InLocaParent user) async {
    final db = await database;
    InLocaParent blocked = InLocaParent(
        id: user.id,
        Full_Name: user.Full_Name,
        Email: user.Email,
        password: user.password,
        UserName: user.UserName,
        isVerify: !user.isVerify);
    var res = await db.update(
        "${UserTextTable.TABLE_USER_NAME} ", blocked.toMap(),
        where: "${UserTextTable.ID_USER_TEXT}  = ?", whereArgs: [user.id]);
    return res;
  }

  deleteUser(int id) async {
    final db = await database;
    db.delete("User",
        where: "${UserTextTable.ID_USER_TEXT}  = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete  from ${UserTextTable.TABLE_USER_NAME} ");
  }
}
