/// ClientModel.dart
import 'dart:convert';

School SchoolFromJson(String str) {
  final jsonData = json.decode(str);
  return School.fromMap(jsonData);
}

String SchoolToJson(School data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class School {
  String url;
  int id;
  String School_Name;
  double latitude;
  double longitude;
  String Name_Location;
  String MobileNo;
  String PhoneNo;
  String Data_Update;
  String Date_Added;

  School({
    this.id,
    this.url,
    this.School_Name,
    this.Date_Added,
    this.Data_Update,
    this.longitude,
    this.latitude,
    this.MobileNo,
    this.Name_Location,
  });

  int get getId => id;

  factory School.fromMap(Map<String, dynamic> json) => new School(
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        MobileNo: json["MobileNo"],
        Name_Location: json["Name_Location"],
        School_Name: json["School_Name"],
        url: json["url"],
        Data_Update: json["Data_Update"],
        Date_Added: json["Date_Added"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "MobileNo": MobileNo,
        "Name_Location": Name_Location,
        "latitude": latitude,
        "longitude": longitude,
        "url": url,
        "PhoneNo": PhoneNo,
        "School_Name": School_Name,
        "Date_Added": Date_Added,
        "Data_Update": Data_Update,
      };

  bool LogIn(String username, String passowrd) {}

  bool editData(
      int id, String name, String password, String username, String emile) {}

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json["id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      MobileNo: json["MobileNo"],
      Name_Location: json["Name_Location"],
      School_Name: json["School_Name"],
      url: json["url"],
      Data_Update: json["Data_Update"],
      Date_Added: json["Date_Added"],
    );
  }
  dynamic toJson() => {
        "id": id,
        "MobileNo": MobileNo,
        "Name_Location": Name_Location,
        "latitude": latitude,
        "longitude": longitude,
        "url": url,
        "PhoneNo": PhoneNo,
        "School_Name": School_Name,
        "Date_Added": Date_Added,
        "Data_Update": Data_Update,
      };
}
