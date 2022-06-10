import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:school_ksa/lib/DataBase/db_provider-driver_bus.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Model/driver_buse.dart';

class DriverBusesApiProvider with ChangeNotifier {
  DriverBusesApiProvider() {}
  List<DriverBuses> _todos = [];
  List<DriverBuses> _DriverBusesErr = [];

  List<DriverBuses> get todos {
    return [..._todos];
  }

  DriverBuses driverBusesss;
  addDriverBuses(DriverBuses driverbuses, String SchoolName) async {
    DBProviderDriverBuses db = new DBProviderDriverBuses();
    var unencodedPath = "/api/v1/DriverBus/";

    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(driverbuses));

    if (response.statusCode == 201) {
      print(response.body.toString());

      var data = json.decode(response.body);
      print(json.decode(utf8.decode(response.bodyBytes)));

      driverBusesss = driverbuses;
      driverBusesss.school = SchoolName;

      driverBusesss =
          DriverBuses.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      await db.deleteAll();

      var jdsjd = await db.newUser(driverBusesss);
      print(jdsjd);
      return "1";
    } else {
      var data = json.decode(response.body);

      if (data["Email"].toString().isNotEmpty) {
        print(response.body.toString());
        return "التأكد من صحة البريد او قد يكون موجود من سابق";
      }
      if (data["UserName"].toString().isNotEmpty) {
        print(response.body.toString());
        return "التأكد من اسم المستخدم او قد يكون موجود من سابقُ";
      }

      if (data["UserName"].toString().isNotEmpty) {
        print(response.body.toString());
        return "التأكد من اسم المستخدم او قد يكون موجود من سابقُ";
      }
      return response.body.toString();
    }
  }

  Future<List> fetchDataUserByAmile(String Emile) async {
    print("${PathAPI.PATH_MAIN_API}/api/viewUserByEmile/${Emile}/");

    var unencodedPath = "/api/viewUserByEmile/${Emile}/";
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("dataUser");
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  updateUser(DriverBuses DriverBuses, int id) async {
    var unencodedPath = "/api/AllDriverBusesApi/${id}/";

    print("https://" + PathAPI.PATH_MAIN_API + unencodedPath);
    print("patch");
    print("patch tow");
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    print(' json.encode(DriverBuses)');

    print(DriverBusesToJson(DriverBuses));

    print(json.encode(DriverBuses));
    final response = await http.patch(url,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: json.encode(DriverBuses),
        encoding: Encoding.getByName("utf-8"));
    print(response.contentLength);
    print(response.persistentConnection);
    print(response.bodyBytes.toString());
    print(response.body);
    print(await response.isRedirect);
    print(await response.reasonPhrase);
    print(await response.headers);
    print(await response.statusCode);

    print(await response.body.toString());
    print(await response.statusCode);

    if (response.statusCode == 200) {
      DriverBuses.id = json.decode(response.body)['id'];
      print(DriverBuses.id);
      _todos.add(DriverBuses);
      notifyListeners();

      return "1";
    } else {
      print(response.body.toString());

      return response.body.toString();
    }
  }

  void deleteDriverBuses(DriverBuses todo) async {
    var unencodedPath = "/AllUsersApi/${todo.id}/";

    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    final response = await http.delete(url);
    if (response.statusCode == 204) {
      _todos.remove(todo);
      notifyListeners();
    }
  }

  Future<List<DriverBuses>> fechAllDriverBusesInSchool(int idSchool) async {
    print("https://${PathAPI.PATH_MAIN_API}/api/v1/school/");
//id=&Full_Name=&=1&Email=&IMEI_device=&password=&session_no=&UserName=&'
// PhoneNo=&keyVerify=&Data_Update=&Date_Added=&KeyActiveStatus=&school__School_Name=&school__id=&school__Name_Location=

    var unencodedPath = "/api/v1/DriverBus/";
    Map<String, dynamic> query = {
      'format': "json",
      "school": "${idSchool}",
    };
    var url = Uri.https(PathAPI.PATH_MAIN_API, unencodedPath, query);
    final response = await http.get(url);
    print(response.statusCode);
    print(url.path);
    if (response.statusCode == 200) {
      print("dataUser");
      var map = json.decode(utf8.decode(response.bodyBytes));
      print(await map);

      print(await map['results'].length);

      //Data.dataSchool = School.fromJson(json.decode( utf8.decode(response.bodyBytes))['results'][0]);

      for (int i = 0; i < map['results'].length; i++) {
        if (Data.dataDriverBusesinSchool.length <= i)
          Data.dataDriverBusesinSchool.insert(
              i,
              DriverBuses.fromJson(
                  json.decode(utf8.decode(response.bodyBytes))['results'][i]));

        var maps = DriverBuses.fromMap(map['results'][i]);
        print(await maps);
      }

      //Data.dataSchool.addAll(json.decode(response.body));
      return Data.dataDriverBusesinSchool;
    } else {
      return [];
    }
  }

  Future<List> fetchOnUserByID(int id) async {
    var unencodedPath = "/api/AllUsersApi/";
    print("https://" + PathAPI.PATH_MAIN_API + unencodedPath + "?format=json");
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath,
        {"${id}/?format": "json; charset=UTF-8"});
    print("https://" + url.host + url.path + url.query);
    print(url.data);
    print(url.query);
    print(url.isAbsolute);
    final response = await http.get(
      url,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  fetchOneUser(String Emile) async {
    var unencodedPath = "/UserDetilsApiWhithEmile/${Emile}/?format=json";
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _todos =
          data.map<DriverBuses>((json) => DriverBuses.fromMap(json)).toList();
      print(_todos);
      notifyListeners();
    }
  }
}
