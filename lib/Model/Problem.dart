/// ClientModel.dart
import 'dart:convert';

import 'dart:io';

import 'dart:typed_data';


Proplem ProplemFromJson(String str) {
  final jsonData = json.decode(str);
  return Proplem.fromMap(jsonData);
}

String ProplemToJson(Proplem data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Proplem {

  String url;
  int id;
  String Couse;
  String Data_Solved_The_Problem;
  String IMEI_device;
  bool Solved_the_problem;
  String Data_Update;
  String Date_Added;
  String Driver;

  double latitude;
  double longitude;
  String Name_Location;
  Proplem({
    this.id,
    this.url,
    this.Couse,
    this.Date_Added,
    this.Data_Update,
    this.Data_Solved_The_Problem,
    this.IMEI_device,
    this.Solved_the_problem,
    this.Driver,
    this.longitude,
    this.latitude,
    this.Name_Location


  });



  int get getId => id;





  factory Proplem.fromMap(Map<String, dynamic> json) => new Proplem(

    id: json["id"],
    Couse: json["Couse"],
    Data_Solved_The_Problem: json["Data_Solved_The_Problem"],
    IMEI_device: json["IMEI_device"],
    Solved_the_problem: json["Solved_the_problem"],
    url: json["url"],
    Data_Update: json["Data_Update"],
    Date_Added: json["Date_Added"],
    Driver: json["Driver"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    Name_Location: json["Name_Location"],






  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "Couse": Couse,
    "Solved_the_problem": Solved_the_problem,
    "Data_Solved_The_Problem": Data_Solved_The_Problem,
    "url": url,
    "IMEI_device": IMEI_device,
    "Date_Added": Date_Added,
    "Data_Update": Data_Update,
    "Driver": Driver,

    "Name_Location": Name_Location,
    "latitude": latitude,
    "longitude": longitude,


  };

  factory Proplem.fromJson(Map<String, dynamic> json) {
    return Proplem(
      id: json["id"],
      Couse: json["Couse"],
      Data_Solved_The_Problem: json["Data_Solved_The_Problem"],
      IMEI_device: json["IMEI_device"],
      Solved_the_problem: json["Solved_the_problem"],
      url: json["url"],
      Data_Update: json["Data_Update"],
      Date_Added: json["Date_Added"],
      Driver: json["Driver"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      Name_Location: json["Name_Location"],
    );

  }
  dynamic toJson() =>

      {
        "id": id,
        "Couse": Couse,
        "Solved_the_problem": Solved_the_problem,
        "Data_Solved_The_Problem": Data_Solved_The_Problem,
        "url": url,
        "IMEI_device": IMEI_device,
        "Date_Added": Date_Added,
        "Data_Update": Data_Update,
        "Driver": Driver,
        "Name_Location": Name_Location,
        "latitude": latitude,
        "longitude": longitude,





      };

}
