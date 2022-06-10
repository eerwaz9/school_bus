import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/Model/InLocoParent.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

export 'package:provider/provider.dart';

class ParentApiProvider with ChangeNotifier {
  ParentApiProvider() {}
  List<InLocaParent> _todos = [];
  List<InLocaParent> _InLocaParentErr = [];

  List<InLocaParent> get todos {
    return [..._todos];
  }

  InLocaParent _inLocaparent;

  DBProviderUser DB;
  addParent(InLocaParent innLocaparentP) async {
    DB = await new DBProviderUser();
    var unencodedPath = "/api/v1/Guardian/";

    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(innLocaparentP));
    if (response.statusCode == 201) {
      _inLocaparent =
          InLocaParent.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      await DB.deleteAll();
      var jdsjd = await DB.newUser(_inLocaparent);
      return "1";
    } else {
      var data = json.decode(response.body);

      if (data["Email"].toString().isNotEmpty) {
        return "التأكد من صحة البريد او قد يكون موجود من سابق";
      }
      if (data["ParentName"].toString().isNotEmpty) {
        return "التأكد من اسم المستخدم او قد يكون موجود من سابقُ";
      }

      if (data["ParentName"].toString().isNotEmpty) {
        return "التأكد من اسم المستخدم او قد يكون موجود من سابقُ";
      }
      return response.body.toString();
    }
  }

  Future<List> fetchDataParentByAmile(String Emile) async {
    print("${PathAPI.PATH_MAIN_API}/api/viewParentByEmile/${Emile}/");

    var unencodedPath = "/api/viewParentByEmile/${Emile}/";
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("dataParent");
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  updateParent(InLocaParent InLocaParent, int id) async {
    var unencodedPath = "/api/AllInLocaParentApi/${id}/";

    print("https://" + PathAPI.PATH_MAIN_API + unencodedPath);
    print("patch");
    print("patch tow");
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    print(' json.encode(InLocaParent)');

    print(InLocaParentToJson(InLocaParent));

    print(json.encode(InLocaParent));
    final response = await http.patch(url,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: json.encode(InLocaParent),
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
      InLocaParent.id = json.decode(response.body)['id'];
      print(InLocaParent.id);
      _todos.add(InLocaParent);
      notifyListeners();

      return "1";
    } else {
      print(response.body.toString());

      return response.body.toString();
    }
  }

  void deleteInLocaParent(InLocaParent todo) async {
    var unencodedPath = "/AllParentsApi/${todo.id}/";

    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    final response = await http.delete(url);
    if (response.statusCode == 204) {
      _todos.remove(todo);
      notifyListeners();
    }
  }

  Future<List> fetchOnParentByID(int id) async {
    var unencodedPath = "/api/AllParentsApi/";
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

  fetchOneParent(String Emile) async {
    var unencodedPath = "/ParentDetilsApiWhithEmile/${Emile}/?format=json";
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _todos =
          data.map<InLocaParent>((json) => InLocaParent.fromMap(json)).toList();
      print(_todos);
      notifyListeners();
    }
  }
}
