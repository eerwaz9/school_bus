import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'StaticVirable.dart';

class MyProvider extends ChangeNotifier {
  int page = 0;

  void PageGet(int index) {
    page = index;
    notifyListeners();
  }

  bool isVeryVy;
  bool isVisble = true;

  bool getIsVisble() {
    notifyListeners();

    return this.isVisble;
  }

  void setIsVisble(isVisble) {
    this.isVisble = isVisble;

    // notifyListeners();

    // notifyListeners();
  }

  final bool HaveAccount;
  MyProvider(this.HaveAccount) {
    print(
        "HaveAccount HaveAccount HaveAccountHaveAccountHaveAccount${this.HaveAccount}");
  }
  String Email;
  int getid() {
    notifyListeners();
    return this.id;
  }

  String getEmile() {
    notifyListeners();
    return this.Email;
  }

  String getFull_Name() {
    notifyListeners();
    return this.Full_Name;
  }

  String getsession_no() {
    notifyListeners();
    return this.session_no;
  }

  String getPassword() {
    notifyListeners();
    return this.password;
  }

  String getPhoneNo() {
    notifyListeners();
    return this.PhoneNo;
  }

  String getUserName() {
    notifyListeners();
    return this.UserName;
  }

  String getkeyVerifye() {
    notifyListeners();
    return this.keyVerify;
  }

  String session_no;
  String Full_Name;

  String password;
  String PhoneNo;
  String IMEI_device;
  String keyVerify;
  String UserName;
  int id;

  void setIsveryVicade(bool isVeryVy, String KEY_VERIFY) {
    this.isVeryVy = isVeryVy;
    prefs.setString(UserTextTable.KEY_VERIFY_TEXT, KEY_VERIFY);
    prefs.setBool(UserTextTable.IS_VERIFY_TEXT, isVeryVy);

    notifyListeners();
  }

  void setsharedPrefInitProvider(
    bool HaveAccount,
    bool isVeryVy,
    String Email,
    String session_no,
    String Full_Name,
    String password,
    String PhoneNo,
    String IMEI_device,
    String keyVerify,
    String UserName,
    int id,
  ) async {
    /// setMockInitialValues initiates shared preference
    /// Adds app-name
    SharedPreferences.setMockInitialValues({});

    prefs.setString("app-name", "MyGuideAtMyHome");
    prefs.setBool("HaveAccount", HaveAccount);

    prefs.setInt(UserTextTable.ID_USER_TEXT, id);

    prefs.setInt(UserTextTable.ID_USER_TEXT, id);

    prefs.setString(UserTextTable.FULL_NAME_TEXT, Full_Name);
    prefs.setString(UserTextTable.PHONE_NO_TEXT, PhoneNo);
    prefs.setString(UserTextTable.EMAILE_TEXT, Email);
    prefs.setString(UserTextTable.PASSWORD_TEXT, password);

    prefs.setBool(UserTextTable.IS_VERIFY_TEXT, isVeryVy);

    prefs.setString(UserTextTable.USERNAME_TEXT, UserName);

    prefs.setString(UserTextTable.SEESION_TEXT, session_no);
    prefs.setBool("HaveAccount", HaveAccount);

    MyProvider(prefs.getBool("HaveAccount"));

    print("Share Rifrance ${prefs.getBool("HaveAccount")}");

    print(
        "HaveAccount HaveAccount HaveAccount5${prefs.getBool("HaveAccount")}");

    prefs.getString("app-name");
    prefs.getBool("HaveAccount");
    print("HaveAccount HaveAccount 2${prefs.getBool("HaveAccount")}");
    print("HaveAccount HaveAccountHaveAccountHaveAccount 2${this.HaveAccount}");
    this.isVeryVy = isVeryVy;

    notifyListeners();
  }

  void getsharedPrefInitProvider() {
    id = prefs.getInt(UserTextTable.ID_USER_TEXT);
    UserName = prefs.getString(UserTextTable.USERNAME_TEXT);

    session_no = prefs.getString(UserTextTable.SEESION_TEXT);

    this.Email = prefs.getString(UserTextTable.EMAILE_TEXT);

    this.password = prefs.getString(UserTextTable.PASSWORD_TEXT);
    isVeryVy = prefs.getBool(UserTextTable.IS_VERIFY_TEXT);

    print(
        "HaveAccount HaveAccount HaveAccount2${prefs.getBool("HaveAccount")}");

    MyProvider(prefs.getBool("HaveAccount"));
    print("Share Rifrance ${prefs.getBool("HaveAccount")}");
    prefs.getString("app-name");
    prefs.getBool("HaveAccount");
    notifyListeners();
  }
}
