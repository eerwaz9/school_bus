/// ClientModel.dart
import 'dart:convert';

import 'dart:io';

import 'dart:typed_data';


DriverBuses DriverBusesFromJson(String str) {
  final jsonData = json.decode(str);
  return DriverBuses.fromMap(jsonData);
}

String DriverBusesToJson(DriverBuses data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class DriverBuses {

  String url;
  int id;
  String Full_Name;
  String UserName;
  String password;
  String Email;
  String keyVerify;
  String IMEI_device;

  bool KeyActiveStatus;
  String session_no;
  String PhoneNo;
  String Data_Update;
  String Date_Added;
  String school;
  String images_user;

  bool isVerify;


  DriverBuses({
    this.id,
    this.password,
    this.Date_Added,
    this.Data_Update,
    this.images_user,
    this.UserName,
    this.Full_Name,
    this.session_no,
    this.PhoneNo,
    this.KeyActiveStatus,
    this.Email,
    this.IMEI_device,
    this.keyVerify,
    this.url,
    this.school,
    this.isVerify=false


  });



  int get getId => id;





  factory DriverBuses.fromMap(Map<String, dynamic> json) => new DriverBuses(

    id: json["id"],

    Full_Name: json["Full_Name"],
    UserName: json["UserName"],
    password: json["password"],
    Email: json["Email"],
    keyVerify: json["keyVerify"],

    session_no: json["session_no"],
    PhoneNo: json["PhoneNo"],
    IMEI_device: json["IMEI_device"],
    images_user: json["images_user"],
    Date_Added: json["Date_Added"],
    Data_Update: json["Data_Update"],
    KeyActiveStatus: json["KeyActiveStatus"],
    url: json["url"],
    school: json["school"],
      isVerify: json["isVerify"],








  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "Full_Name": Full_Name,
    "UserName": UserName,
    "password": password,
    "Email": Email,
    "keyVerify": keyVerify,
    "session_no": session_no,
    "PhoneNo": PhoneNo,
    "IMEI_device":IMEI_device,
    " images_user":images_user,

    "Date_Added": Date_Added,
    "Data_Update": Data_Update,
    "KeyActiveStatus":KeyActiveStatus,
    "url":url,
    "school":school,
    "isVerify":isVerify,


  };







  factory DriverBuses.fromJson(Map<String, dynamic> json) {
    return DriverBuses(
      id: json["id"],

      Full_Name: json["Full_Name"],
      UserName: json["UserName"],
      password: json["password"],
      Email: json["Email"],
      keyVerify: json["keyVerify"],
      session_no: json["session_no"],
      PhoneNo: json["PhoneNo"],
      IMEI_device: json["IMEI_device"],
      images_user: json["images_user"],
      Date_Added: json["Date_Added"],
      Data_Update: json["Data_Update"],
      KeyActiveStatus: json["KeyActiveStatus"],
      url: json["url"],
      school: json["school"],
      isVerify: json["isVerify"],

    );

  }
  dynamic toJson() =>

      {
        "id": id,
        "Full_Name": Full_Name,
        "UserName": UserName,
        "password": password,
        "Email": Email,
        "keyVerify": keyVerify,
        "session_no": session_no,
        "PhoneNo": PhoneNo,
        "IMEI_device":IMEI_device,
        " images_user":images_user,

        "Date_Added": Date_Added,
        "Data_Update": Data_Update,
        "KeyActiveStatus":KeyActiveStatus,
        "url":url,
        "school":school,
      "isVerify":isVerify





      };

}
