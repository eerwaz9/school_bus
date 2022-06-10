import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/LocationDriver.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

class LocationDriverApiProvider with ChangeNotifier {
  LocationDriverApiProvider() {}
  List<LocationDriver> _todos = [];
  List<LocationDriver> _LocationDriverErr = [];

  List<LocationDriver> get todos {
    return [..._todos];
  }

  LocationDriver locationdrivers;
  Future<LocationDriver> addLocationDriver(
      LocationDriver locationdriverss) async {
    // DBProviderLocationDriver db= new DBProviderLocationDriver();
    var unencodedPath = "/api/v1/LocationDriverBus/";
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(locationdriverss));

    if (response.statusCode == 201) {
      print(await response.body.toString());

      var data = json.decode(response.body);

      print(await LocationDriver.fromJson(
          json.decode(utf8.decode(response.bodyBytes))));
      //PRINT(json.decode( utf8.decode(response.bodyBytes)));
      Data.dataLocationDriver.add(LocationDriver.fromJson(
          json.decode(utf8.decode(response.bodyBytes))));

      //  await db.deleteAll();

      // var jdsjd=await  db.newUser(LocationDriver);
      print(Data.dataLocationDriver);
      return Data.dataLocationDriver.last;
    } else {
      //  var data = json.decode(response.body) ;

      return new LocationDriver(
        longitude: null,
        IMEI_device: null,
        latitude: null,
        Name_Location: null,
      );
    }
  }

  Future<List<LocationDriver>> fetchLocationByDriver(int Driver) async {
    Data.dataLocationDriver = [];
    //PRINT("${PathAPI.PATH_MAIN_API}/api/v1/LocationDriverBus/${IMEI_device}/");

    var queryParameters = {"Driver": "${Driver}", "format": "json"};

    // queryParameters.update("Driver", (Driver) => null);

    var unencodedPath = "/api/v1/LocationDriverBus/";

    //PRINT(IMEI_device);
    var url = Uri.https(PathAPI.PATH_MAIN_API, unencodedPath, queryParameters);
    final response = await http.get(url);
    print("https://" +
        PathAPI.PATH_MAIN_API +
        unencodedPath +
        "?Driver=${Driver}");
    if (response.statusCode == 200) {
      //PRINT("dataUser");
      var Lastdata = json.decode(utf8.decode(response.bodyBytes));

      // LocationDriver locationDriver= LocationDriver.fromJson();
      //PRINT(Lastdata['results']);

      //PRINT(Lastdata['results'].length);
      //PRINT("Lastdata['results'].length");
      for (int i = 0; i < Lastdata['results'].length; i++) {
        //if(Data.dataLocationDriver.length<=i)
        Data.dataLocationDriver.add(LocationDriver.fromJson(
            json.decode(utf8.decode(response.bodyBytes))['results'][i]));

        var maps = LocationDriver.fromMap(Lastdata['results'][i]);
        //PRINT(await maps);

      }

      //Data.dataLocationDriver.add(Lastdata['results']);
      return Data.dataLocationDriver;
    } else {
      return Data.dataLocationDriver;
    }
  }

  updateUser(LocationDriver LocationDriver, int id) async {
    var unencodedPath = "/api/AllLocationDriverApi/${id}/";

    //PRINT("https://"+PathAPI.PATH_MAIN_API+unencodedPath);
    //PRINT("patch");
    print("patch tow");
    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    print(' json.encode(LocationDriver)');

    print(LocationDriverToJson(LocationDriver));

    print(json.encode(LocationDriver));
    final response = await http.patch(url,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: json.encode(LocationDriver),
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
      LocationDriver.id = json.decode(response.body)['id'];
      print(LocationDriver.id);
      _todos.add(LocationDriver);
      notifyListeners();

      return "1";
    } else {
      print(response.body.toString());

      return response.body.toString();
    }
  }

  void deleteLocationDriver(LocationDriver todo) async {
    var unencodedPath = "/AllUsersApi/${todo.id}/";

    var url = Uri.http(PathAPI.PATH_MAIN_API, unencodedPath);

    final response = await http.delete(url);
    if (response.statusCode == 204) {
      _todos.remove(todo);
      notifyListeners();
    }
  }

  Future<List<LocationDriver>> fechAllLocationoToday(int idSchool) async {
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
        if (Data.dataLocationDriver.length <= i)
          Data.dataLocationDriver.insert(
              i,
              LocationDriver.fromJson(
                  json.decode(utf8.decode(response.bodyBytes))['results'][i]));

        var maps = LocationDriver.fromMap(map['results'][i]);
        print(await maps);
      }

      //Data.dataSchool.addAll(json.decode(response.body));
      return Data.dataLocationDriver;
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
      _todos = data
          .map<LocationDriver>((json) => LocationDriver.fromMap(json))
          .toList();
      print(_todos);
      notifyListeners();
    }
  }
}
