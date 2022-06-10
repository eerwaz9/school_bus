/// ClientModel.dart
import 'dart:convert';

import 'dart:io';

import 'dart:typed_data';

LocationDriver LocationDriverFromJson(String str) {
  final jsonData = json.decode(str);
  return LocationDriver.fromMap(jsonData);
}

String LocationDriverToJson(LocationDriver data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class LocationDriver {
  String url;
  int id;
  var Name_Location;

  double latitude;
  double longitude;
  String IMEI_device;

  String Driver;
  String Data_Update;
  String Date_Added;

  LocationDriver({
    this.id,
    this.latitude,
    this.Date_Added,
    this.Data_Update,
    this.longitude,
    this.Name_Location,
    this.IMEI_device,
    this.url,
    this.Driver,
  });

  int get getId => id;

  factory LocationDriver.fromMap(Map<String, dynamic> json) =>
      new LocationDriver(
          id: json["id"],
          url: json["url"],
          latitude: json["latitude"],
          longitude: json["longitude"],
          Name_Location: json["Name_Location"],
          IMEI_device: json["IMEI_device"],
          Date_Added: json["Date_Added"],
          Data_Update: json["Data_Update"],
          Driver: json["Driver"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "Name_Location": Name_Location,
        "longitude": longitude,
        "latitude": latitude,
        "IMEI_device": IMEI_device,
        "Date_Added": Date_Added,
        "Data_Update": Data_Update,
        "url": url,
        "Driver": Driver
      };

  factory LocationDriver.fromJson(Map<String, dynamic> json) {
    return LocationDriver(
      id: json["id"],
      url: json["url"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      Name_Location: json["Name_Location"],
      IMEI_device: json["IMEI_device"],
      Date_Added: json["Date_Added"],
      Data_Update: json["Data_Update"],
      Driver: json["Driver"],
    );
  }

  dynamic toJson() => {
        "id": id,
        "Name_Location": Name_Location,
        "longitude": longitude,
        "latitude": latitude,
        "IMEI_device": IMEI_device,
        "Date_Added": Date_Added,
        "Data_Update": Data_Update,
        "url": url,
        "Driver": Driver,
      };
}
