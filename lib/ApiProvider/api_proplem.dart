import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/Problem.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

export 'package:provider/provider.dart';

class ProplemApiProvider with ChangeNotifier {
  ProplemProvider() {
    fechAllProplem();
  }

  List<Proplem> _todos = [];
  List<Proplem> _ProplemErr = [];

  List<Proplem> get todos {
    return [..._todos];
  }

  Future<Proplem> addProplem(Proplem newproplem) async {
    var unencodedPath = "/api/v1/CouseOFDelay/";
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(newproplem));
    print(json.decode(utf8.decode(response.bodyBytes)));

    if (response.statusCode == 201) {
      Data.dataProplem
          .add(Proplem.fromJson(json.decode(utf8.decode(response.bodyBytes))));
      print(Data.dataProplem);
      return Proplem.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else
      null;
  }

  Future<List<Proplem>> fechAllProplem() async {
    //PRINT("https://${PathAPI.PATH_MAIN_API}/api/v1/Proplem/");

    var unencodedPath = "/api/v1/Proplem/";
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

      //Data.dataProplem = Proplem.fromJson(json.decode( utf8.decode(response.bodyBytes))['results'][0]);

      for (int i = 0; i < map['results'].length; i++) {
        if (Data.dataProplem.length <= i)
          Data.dataProplem.insert(
              i,
              Proplem.fromJson(
                  json.decode(utf8.decode(response.bodyBytes))['results'][i]));

        var maps = Proplem.fromMap(map['results'][i]);
        print(await maps);
      }

      //Data.dataProplem.addAll(json.decode(response.body));
      return Data.dataProplem;
    } else {
      return [];
    }
  }

  updateUser(Proplem Proplem, int id) async {
    var unencodedPath = "/api/AllProplemApi/${id}/";

    print("https://" + PathAPI.PATH_MAIN_API + unencodedPath);
    print("patch");
    print("patch tow");
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    print(' json.encode(Proplem)');

    print(ProplemToJson(Proplem));

    print(json.encode(Proplem));
    final response = await http.patch(url,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: json.encode(Proplem),
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
      Proplem.id = json.decode(response.body)['id'];
      print(Proplem.id);
      _todos.add(Proplem);
      notifyListeners();

      return "1";
    } else {
      print(response.body.toString());

      return response.body.toString();
    }
  }

  void deleteProplem(Proplem todo) async {
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
      _todos = data.map<Proplem>((json) => Proplem.fromMap(json)).toList();
      print(_todos);
      notifyListeners();
    }
  }
}
