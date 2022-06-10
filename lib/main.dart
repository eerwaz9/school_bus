import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'lib/ApiProvider/ApiSchool.dart';
import 'lib/ApiProvider/api_driver_buses.dart';
import 'lib/DataBase/DBProviderUser.dart';
import 'lib/Model/Data.dart';
import 'lib/Model/local_provider_app.dart';
import 'lib/Screan/splashScrean.dart';

Future<SharedPreferences> prefsMain = SharedPreferences.getInstance();
SharedPreferences prefs;

MyProvider myProvider;
DBProviderUser DB;

void sharedPrefInit(
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
  prefs = await prefsMain;
  prefs = await prefsMain;

  if (prefs != null) {
    try {
/*  prefs.setBool("HaveAccount",true);
  prefs.setBool(UserTextTable.IS_VERIFY_TEXT,true);
  prefs.setString(UserTextTable.EMAILE_TEXT,"wswsws@ajhasj.com");

  prefs.setString(UserTextTable.SEESION_TEXT,"ZdsDzXFRevaUxwVddEfowK92z0e");
  prefs.setString(UserTextTable.FULL_NAME_TEXT,"sswswsw");
  prefs.setString(UserTextTable.PASSWORD_TEXT,"gggggggg");
  prefs.setString(UserTextTable.PHONE_NO_TEXT,"333333");

  prefs.setString(UserTextTable.KEY_VERIFY_TEXT,"sjhskjsh");
  prefs.setString(UserTextTable.USERNAME_TEXT,"ggggggggg");*/

      prefs.getBool("HaveAccount");

      /* if(prefs.getBool("HaveAccount")==null)
      prefs.setBool("HaveAccount", false);*/
      print(
          "HaveAccount HaveAccount HaveAccount2${prefs.getBool("HaveAccount")}");

      myProvider = new MyProvider(prefs.getBool("HaveAccount") != null
          ? prefs.getBool("HaveAccount")
          : false);
      myProvider.getsharedPrefInitProvider();
      print(
          "HaveAccount HaveAccount HaveAccount3${prefs.getBool("HaveAccount")}");
    } catch (err) {
      /// setMockInitialValues initiates shared preference
      /// Adds app-name

      print(
          "HaveAccount HaveAccount HaveAccount${prefs.getBool("HaveAccount")}");

      myProvider = new MyProvider(prefs.getBool("HaveAccount"));
      print(
          "HaveAccount HaveAccount HaveAccount${prefs.getBool("HaveAccount")}");
      myProvider.setsharedPrefInitProvider(
          HaveAccount,
          isVeryVy,
          Email,
          session_no,
          Full_Name,
          password,
          PhoneNo,
          IMEI_device,
          keyVerify,
          UserName,
          id);
      print(
          "HaveAccount HaveAccount HaveAccount${prefs.getBool("HaveAccount")}");
    }
  }
}

var _packageInfo;
var packageName;
var appName;
var buildNumber;
var version;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MainSplashScreen());
  var getInfoDivice;
  await getInfoDivice.getDeviceDetails();

  await DataUserLocal.checkTypeAndHaveAccount();
  await DataUserLocal.getdataaccount();
  //await DataUserLocal.getLocationUser();

  prefs = await prefsMain;
  fetchAllschool();

  await DataUserLocal.addToRefrences();

  await DataUserLocal.addToRefrences();

  DBProviderUser databaseHelper = DBProviderUser();
  int count = 0;
  final Future<Database> dbFuture = databaseHelper.initDB();

  print(dbFuture);

  databaseHelper.initDB();
}

SchoolApiProvider schoolapi;
DriverBusesApiProvider driverbusis;
fetchAllschool() async {
  var testListNo = [];
  var testListkeyword = [];
  schoolapi = new SchoolApiProvider();
  Data.dataSchool = await schoolapi.fechAllSchool();
  // _testList.setRange(0,Data.dataSchool.length,Data.dataSchool);
  for (int i = 0; i < Data.dataSchool.length; i++) {
    testListNo.add({
      "no": Data.dataSchool[i].id,
      "keyword": Data.dataSchool[i].School_Name,
    });
  }
}
