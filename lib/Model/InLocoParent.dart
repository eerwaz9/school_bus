/// ClientModel.dart
import 'dart:convert';

import 'dart:io';

import 'dart:typed_data';

InLocaParent InLocaParentFromJson(String str) {
  final jsonData = json.decode(str);
  return InLocaParent.fromMap(jsonData);
}

String InLocaParentToJson(InLocaParent data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class InLocaParent {


  int id;
  String Full_Name;
  String UserName;
  String password;
  String Email;
  String keyVerify;
  String IMEI_device;

  bool isVerify;
  bool KeyActiveStatus;
  String session_no;
  String PhoneNo;
  String Data_Update;
  String Date_Added;
  String images_user;




  InLocaParent({
    this.id,
    this.password,
    this.isVerify,
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
    this.keyVerify

  });



  int get getId => id;
  String get get_full_name => Full_Name;
  String get get_username => UserName;
  String get get_email => Email;
  String get get_keyVerify => keyVerify;
  String get get_password => password;
  String get get_seestion=> session_no;
  String get get_IMEI_device=>IMEI_device;

  bool get get_isVerify => isVerify;



  factory InLocaParent.fromMap(Map<String, dynamic> json) => new InLocaParent(

    id: json["id"],
    Full_Name: json["Full_Name"],
    UserName: json["UserName"],
    password: json["password"],
    Email: json["Email"],
    keyVerify: json["keyVerify"],
    isVerify: json["isVerify"]==0,
    session_no: json["session_no"],
    PhoneNo: json["PhoneNo"],
    IMEI_device: json["IMEI_device"],
    images_user: json["images_user"],
    Date_Added: json["Date_Added"],
    Data_Update: json["Data_Update"],
    KeyActiveStatus: json["KeyActiveStatus"],



  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "Full_Name": Full_Name,
    "UserName": UserName,
    "password": password,
    "Email": Email,
    "keyVerify": keyVerify,
    "isVerify": isVerify,
    "session_no": session_no,
    "PhoneNo": PhoneNo,
    "IMEI_device":IMEI_device,
    "images_user":images_user,

    "Date_Added": Date_Added,
    "Data_Update": Data_Update,
    "KeyActiveStatus":KeyActiveStatus
  };

  bool LogIn( String  username,String passowrd){

  }

  bool editData( int id,   String name,   String password,   String username,   String emile){

  }






  factory InLocaParent.fromJson(Map<String, dynamic> json) {
    return InLocaParent(

      id: json["id"],
      Full_Name: json["Full_Name"],
      UserName: json["UserName"],
      password: json["password"],
      Email: json["Email"],
      keyVerify: json["keyVerify"],
      isVerify: json["isVerify"]==0,
      session_no: json["session_no"],
      PhoneNo: json["PhoneNo"],
      IMEI_device: json["IMEI_device"],
      images_user: json["images_user"],
      Date_Added: json["Date_Added"],
      Data_Update: json["Data_Update"],
      KeyActiveStatus: json["KeyActiveStatus"],

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
        "isVerify": isVerify,
        "session_no": session_no,
        "PhoneNo": PhoneNo,
        "IMEI_device":IMEI_device,
        "images_user":images_user,

        "Date_Added": Date_Added,
        "Data_Update": Data_Update,
        "KeyActiveStatus":KeyActiveStatus






      };

}
