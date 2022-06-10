import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/School.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

export 'package:provider/provider.dart';

class SchoolApiProvider with ChangeNotifier {
  SchoolProvider() {
    fechAllSchool();
  }

  List<School> _todos = [];
  List<School> _SchoolErr = [];

  List<School> get todos {
    return [..._todos];
  }

  addSchool(School School) async {
    var unencodedPath = "/api/AllUsersApi/";
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(School));
    if (response.statusCode == 201) {
      return "1";
    } else {
      var data = json.decode(response.body);

      if (data["Email"].toString().isNotEmpty) {
        return "التأكد من صحة البريد او قد يكون موجود من سابق";
      }
      if (data["UserName"].toString().isNotEmpty) {
        return "التأكد من اسم المستخدم او قد يكون موجود من سابقُ";
      }

      if (data["UserName"].toString().isNotEmpty) {
        return "التأكد من اسم المستخدم او قد يكون موجود من سابقُ";
      }
      return response.body.toString();
    }
  }

  Future<List<School>> fechAllSchool() async {
    //PRINT("https://${PathAPI.PATH_MAIN_API}/api/v1/school/");

    var unencodedPath = "/api/v1/school/";
    Map<String, String> query = {
      'format': "json",
    };
    var url = Uri.https(PathAPI.PATH_MAIN_API, unencodedPath, query);
    final response = await http.get(url);
    //PRINT(response.statusCode);
    //PRINT(url.path);
    if (response.statusCode == 200) {
      //PRINT("dataUser");
      var map = json.decode(utf8.decode(response.bodyBytes));
      //PRINT(await map);

      print(await map['results'].length);

      //Data.dataSchool = School.fromJson(json.decode( utf8.decode(response.bodyBytes))['results'][0]);

      for (int i = 0; i < map['results'].length; i++) {
        if (Data.dataSchool.length <= i)
          Data.dataSchool.insert(
              i,
              School.fromJson(
                  json.decode(utf8.decode(response.bodyBytes))['results'][i]));

        var maps = School.fromMap(map['results'][i]);
        print(await maps);
      }

      //Data.dataSchool.addAll(json.decode(response.body));
      return Data.dataSchool;
    } else {
      return [];
    }
  }

  updateUser(School School, int id) async {
    var unencodedPath = "/api/AllSchoolApi/${id}/";

    print("https://" + PathAPI.PATH_MAIN_API + unencodedPath);
    print("patch");
    print("patch tow");
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    print(' json.encode(School)');

    print(SchoolToJson(School));

    print(json.encode(School));
    final response = await http.patch(url,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: json.encode(School),
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
      School.id = json.decode(response.body)['id'];
      print(School.id);
      _todos.add(School);
      notifyListeners();

      return "1";
    } else {
      print(response.body.toString());

      return response.body.toString();
    }
  }

  void deleteSchool(School todo) async {
    var unencodedPath = "/AllUsersApi/${todo.id}/";

    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    final response = await http.delete(url);
    if (response.statusCode == 204) {
      _todos.remove(todo);
      notifyListeners();
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
      _todos = data.map<School>((json) => School.fromMap(json)).toList();
      print(_todos);
      notifyListeners();
    }
  }
}
