import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Model/driver_buse.dart';
import 'package:sqflite/sqflite.dart';

class DBProviderDriverBuses {
  DBProviderDriverBuses() {
    initDB();
  }

  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, DATABASE.DB_NAME);

    var database = await openDatabase(dbPath,
        version: DATABASE.DB_VERSION,
        onCreate: populateDb,
        onUpgrade: _onUpgrade);
    return database;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    db.execute("ALTER TABLE ${UserTextTable.TABLE_USER_NAME} ADD COLUMN "
        " ${UserTextTable.ID_USER_API_TEXT}  INTEGER NULL;");

    print("Done Update Table " + UserTextTable.TABLE_USER_NAME);
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();

    return _database;
  }

  void populateDb(Database database, int version) async {
    await database
        .execute("CREATE TABLE ${DriverBusesTextTable.TABLE_DriverBuses_NAME} ("
            "${DriverBusesTextTable.ID_DriverBuses_TEXT} INTEGER PRIMARY KEY,"
            "${DriverBusesTextTable.ID_DriverBuses_API_TEXT} INTEGER,"
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
  }

  Future<Database> initDBOlder() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE.DB_NAME);
    var todosDatabase = await openDatabase(path,
        version: DATABASE.DB_VERSION,
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ${CityTextTable.TABLE_City_NAME} ("
          "${CityTextTable.Id_City_TEXT} INTEGER PRIMARY KEY,"
          "${CityTextTable.Name_City_TEXT}  TEXT,"
          "${CityTextTable.Discryption_City_Text}  TEXT,"
          "${CityTextTable.Images_city_TEXT}  TEXT,"
          "${CityTextTable.Data_Update_TEXT}  TEXT,"
          "${CityTextTable.Date_Added_TEXT}  TEXT,"
          "${CityTextTable.URL_IMAGE_CITY}  TEXT"
          ")");

      await db.execute(
          "CREATE TABLE ${DriverBusesTextTable.TABLE_DriverBuses_NAME} ("
          "${DriverBusesTextTable.ID_DriverBuses_TEXT} INTEGER PRIMARY KEY,"
          "${DriverBusesTextTable.ID_DriverBuses_API_TEXT} INT NULL,"
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

      await db.execute("CREATE TABLE ${AreaTextTable.TABLE_AREA_NAME} ("
          "${AreaTextTable.ID_AREA_TEXT} INTEGER PRIMARY KEY,"
          "${AreaTextTable.ID_CITY} INT NULL,"
          "${AreaTextTable.ID_Type_Area_TEXT} INT NULL,"
          "${AreaTextTable.NumberOfViews_TEXT} INT NULL,"
          "${AreaTextTable.area_Discryption_TEXT}  TEXT NULL,"
          "${AreaTextTable.area_name_TEXT}  TEXT NULL,"
          "${AreaTextTable.latitude_TEXT}  REAL NULL,"
          "${AreaTextTable.longitude_TEXT}  REAL NULL,"
          "${AreaTextTable.CountUserRate_Text}  INT NULL,"
          "${AreaTextTable.AvrageRate_Text}  REAL NULL,"
          "${AreaTextTable.TotalStarRate_Text}  INT NULL,"
          "${AreaTextTable.DATE_UPDATE_TEXT}  TEXT NULL,"
          "${AreaTextTable.DATE_ADDED_TEXT}  TEXT NULL"
          ")");
    }, onUpgrade: _onUpgrade);

    return todosDatabase;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE.DB_NAME);
    var todosDatabase = await openDatabase(path,
        version: DATABASE.DB_VERSION,
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

      //
      // await db.execute("CREATE TABLE ${DriverBusesTextTable.TABLE_DriverBuses_NAME} ("
      //     "${DriverBusesTextTable.ID_DriverBuses_TEXT} INTEGER PRIMARY KEY,"
      //     "${DriverBusesTextTable.ID_DriverBuses_API_TEXT} INTEGER NULL,"
      //     "${DriverBusesTextTable.School_TEXT}  TEXT,"
      //
      //     "${DriverBusesTextTable.FULL_NAME_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.USERNAME_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.PASSWORD_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.EMAILE_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.KEY_VERIFY_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.SEESION_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.PHONE_NO_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.KEY_ACTIVE_STATUS_TEXT}  BIT,"
      //     "${DriverBusesTextTable.DATE_UPDATE_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.DATE_ADDED_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.IMAGES_DriverBuses_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.IMEI_device_TEXT}  TEXT,"
      //     "${DriverBusesTextTable.IS_VERIFY_TEXT}  BIT"
      //     ")");

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

      // await db.execute("ALTER  TABLE ${UserTextTable.TABLE_USER_NAME} ADD "
      //     "${UserTextTable.ID_USER_API_TEXT} INTEGER NULL;");

      print("Done Update Table " + UserTextTable.TABLE_USER_NAME);
    });

    return todosDatabase;
  }

  Future<List<Map>> fetchUserAccount() async {
    final db = await database;
    // List<DriverBuses> list =  DriverBuses.fromMap(await db.rawQuery('SELECT * FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME}'));
    List<Map> list = await db.rawQuery(
        'SELECT * FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME}');

    print(list);
    return list;
  }

  updateLastUser(DriverBuses newUser) async {
    final db = await database;
    var Table = await db.rawQuery(
        "SELECT * FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME} ORDER BY ${DriverBusesTextTable.ID_DriverBuses_TEXT} DESC LIMIT 1");
    var table = await db.rawQuery(
        "SELECT MAX(${DriverBusesTextTable.ID_DriverBuses_TEXT})+1 as ${DriverBusesTextTable.ID_DriverBuses_TEXT} FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME}");
    print(
        "Data User Data User Data User Data User   ${table.map((c) => DriverBuses.fromMap(c)).toList()}");
    int id_d = Table.first["${DriverBusesTextTable.ID_DriverBuses_TEXT} "];
    var res = await db.update(
        "${DriverBusesTextTable.TABLE_DriverBuses_NAME} ", newUser.toMap(),
        where: "${DriverBusesTextTable.EMAILE_TEXT} = ?",
        whereArgs: [newUser.Email]);
    return res;
  }

  getIdLastUser() async {
    final db = await database;

    var Table = await db.rawQuery(
        "SELECT * FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME} ORDER BY ${DriverBusesTextTable.ID_DriverBuses_TEXT} DESC LIMIT 1");

    // print("Data User Data User Data User Data User   ${table.map((c) => DriverBuses.fromMap(c)).toList()}");
    int id_d = Table.first["${DriverBusesTextTable.ID_DriverBuses_TEXT} "];
    return id_d;
  }

  updateLastUserdddddddddd(DriverBuses newUser) async {
    final db = await database;

    var Table = await db.rawQuery(
        "SELECT * FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME} ORDER BY ${DriverBusesTextTable.ID_DriverBuses_TEXT} DESC LIMIT 1");

    var table = await db.rawQuery(
        "SELECT MAX(${DriverBusesTextTable.ID_DriverBuses_TEXT})+1 as ${DriverBusesTextTable.ID_DriverBuses_TEXT} FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME}");

    print(
        "Data User Data User Data User Data User   ${table.map((c) => DriverBuses.fromMap(c)).toList()}");
    int id_d = Table.first["${DriverBusesTextTable.ID_DriverBuses_TEXT} "];

    print("IDDDDDDDDDDDDDDDDD USSSSSSSSSSSSSSSER  $id_d");
    var res = await db.update(
        "${DriverBusesTextTable.TABLE_DriverBuses_NAME} ", newUser.toMap(),
        where: "${DriverBusesTextTable.ID_DriverBuses_TEXT} = ?",
        whereArgs: [id_d]);
    return res;
  }

  GetIsVerifyForLastUser() async {
    final db = await database;

    var table = await db.rawQuery(
        "SELECT MAX(${DriverBusesTextTable.ID_DriverBuses_TEXT}) "
        "as ${DriverBusesTextTable.ID_DriverBuses_TEXT} FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME}");

    int id_d = table.first["${DriverBusesTextTable.ID_DriverBuses_TEXT} "];
    print("IDDDDDDDDDDDDDDDDD USSSSSSSSSSSSSSSER  $id_d");

    return null;
  }

  getUserByEmile(String Emile) async {
    final db = await database;
    var res = await db.query("${DriverBusesTextTable.TABLE_DriverBuses_NAME} ",
        where: "${DriverBusesTextTable.EMAILE_TEXT} = ?", whereArgs: [Emile]);
    return res.isNotEmpty ? DriverBuses.fromMap(res.first) : Null;
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

  Future<int> updateDriverBuses(DriverBuses employee) async {
    var dbClient = await database;
    return await dbClient.update(
        DriverBusesTextTable.TABLE_DriverBuses_NAME, employee.toMap(),
        where: "${DriverBusesTextTable.ID_DriverBuses_TEXT} = ?",
        whereArgs: [employee.id]);
  }

  Future close() async {
    var dbClient = await database;
    return dbClient.close();
  }

  newUser(DriverBuses newUser) async {
    final db = await database;
    //get the biggest id in the table
    // var table = await db.rawQuery("SELECT MAX(${DriverBusesTextTable.ID_DriverBuses_TEXT})+1 as ${DriverBusesTextTable.ID_DriverBuses_TEXT} FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME}");
    // int id_d = table.first["${DriverBusesTextTable.ID_DriverBuses_TEXT} "];
    // print("Data User Data User Data User Data User 1  ${table.map((c) => DriverBuses.fromMap(c)).toList()}");

    //insert to the table using the new id

    DateTime dataNew = DateTime.now();
    var raw = await db.rawInsert(
        "INSERT Into ${DriverBusesTextTable.TABLE_DriverBuses_NAME}("
        "${DriverBusesTextTable.ID_DriverBuses_TEXT} ,"
        "${DriverBusesTextTable.ID_DriverBuses_API_TEXT} ,"
        "${DriverBusesTextTable.FULL_NAME_TEXT} ,"
        "${DriverBusesTextTable.EMAILE_TEXT} ,"
        "${DriverBusesTextTable.PASSWORD_TEXT} ,"
        "${DriverBusesTextTable.USERNAME_TEXT} ,"
        "${DriverBusesTextTable.KEY_VERIFY_TEXT} ,"
        "${DriverBusesTextTable.SEESION_TEXT} ,"
        "${DriverBusesTextTable.PHONE_NO_TEXT} ,"
        "${DriverBusesTextTable.IMEI_device_TEXT}, "
        "${DriverBusesTextTable.DATE_ADDED_TEXT} ,"
        "${DriverBusesTextTable.DATE_UPDATE_TEXT} ,"
        "${DriverBusesTextTable.IMAGES_DriverBuses_TEXT} ,"
        "${DriverBusesTextTable.IS_VERIFY_TEXT} ,"
        "${DriverBusesTextTable.KEY_ACTIVE_STATUS_TEXT} "
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
          dataNew.toString(),
          dataNew.toString(),
          newUser.images_user,
          newUser.isVerify,
          newUser.KeyActiveStatus
        ]);

    // print("IDDDDDDDDDDDDDDDDDDDDDDINSERRRRRRRRT2   $id_d ");
    // print("Data User Data User Data User Data User 2   ${table.map((c) => DriverBuses.fromMap(c)).toList()}");

    return raw;
  }

  newUserTow(DriverBuses newUser) async {
    final db = await database;
    var res = await db.insert(
        "${DriverBusesTextTable.TABLE_DriverBuses_NAME} ", newUser.toMap());
    return res;
  }

  getUser(int id) async {
    final db = await database;
    var res = await db.query("${DriverBusesTextTable.TABLE_DriverBuses_NAME} ",
        where: "${DriverBusesTextTable.ID_DriverBuses_TEXT} = ?",
        whereArgs: [id]);
    return res.isNotEmpty ? DriverBuses.fromMap(res.first) : Null;
  }

  Future<List> getAllDriverBuses() async {
    final db = await database;
    var res = await db.query("${DriverBusesTextTable.TABLE_DriverBuses_NAME} ");
    List<DriverBuses> list =
        res.isNotEmpty ? res.map((c) => DriverBuses.fromMap(c)).toList() : [];
    return list;
  }

  getBlockedDriverBuses() async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM ${DriverBusesTextTable.TABLE_DriverBuses_NAME} WHERE ${DriverBusesTextTable.IS_VERIFY_TEXT} =1");
    List<DriverBuses> list =
        res.isNotEmpty ? res.toList().map((c) => DriverBuses.fromMap(c)) : null;
    return list;
  }

  updateUser(DriverBuses newUser) async {
    final db = await database;
    var res = await db.update(
        "${DriverBusesTextTable.TABLE_DriverBuses_NAME} ", newUser.toMap(),
        where: "${DriverBusesTextTable.ID_DriverBuses_TEXT} = ?",
        whereArgs: [newUser.id]);
    return res;
  }

  blockOrUnblock(DriverBuses user) async {
    final db = await database;
    DriverBuses blocked = DriverBuses(
      id: user.id,
      Full_Name: user.Full_Name,
      Email: user.Email,
      password: user.password,
      UserName: user.UserName,
    );
    var res = await db.update(
        "${DriverBusesTextTable.TABLE_DriverBuses_NAME} ", blocked.toMap(),
        where: "${DriverBusesTextTable.ID_DriverBuses_TEXT}  = ?",
        whereArgs: [user.id]);
    return res;
  }

  deleteUser(int id) async {
    final db = await database;
    db.delete("User",
        where: "${DriverBusesTextTable.ID_DriverBuses_TEXT}  = ?",
        whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete(
        "Delete  from ${DriverBusesTextTable.TABLE_DriverBuses_NAME} ");
  }
}
