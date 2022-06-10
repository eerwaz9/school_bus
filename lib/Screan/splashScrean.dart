import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/DataBase/db_provider-driver_bus.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:splashscreen/splashscreen.dart';

import '../../main.dart';
import 'Account/logIn.dart';
import 'ChooseScool.dart';
import 'HomeDriver.dart';
import 'home.dart';

class MainSplashScreen extends StatefulWidget {
  @override
  _MainSplashScreenState createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  int timeSecond = 0;
  int index = 0;

  DBProviderUser DB;
  DBProviderDriverBuses DBDri;

  void checkAccount() async {
    await DataUserLocal.checkTypeAndHaveAccount();

    await DataUserLocal.getdataaccount();
    await DataUserLocal.addShollChoseToRefrences();
    await DataUserLocal.checkTypeAndHaveAccount();

    setState(() {});
    setState(() {});

    if (DataUserLocal.DriverAccountData.length > 0) {
      //print(DataUserLocal.DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT])
      if (DataUserLocal.DriverAccountData[0]
              [DriverBusesTextTable.IS_VERIFY_TEXT] ==
          1) {
        setState(() {
          DataUserLocal.isVeryEmile = true;
        });
      } else {
        setState(() {
          DataUserLocal.isVeryEmile = false;
        });
      }
      setState(() {
        DataUserLocal.isDriver = true;
        DataUserLocal.HaveAccount = true;
        DataUserLocal.HaveAccount = true;
      });
      //print(DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT]);

    } else if (DataUserLocal.UserAccountData.length > 0) {
      setState(() {
        if (DataUserLocal.UserAccountData[0][UserTextTable.IS_VERIFY_TEXT] ==
            1) {
          setState(() {
            DataUserLocal.isVeryEmile = true;
          });
        } else {
          setState(() {
            DataUserLocal.isVeryEmile = false;
          });
        }
        DataUserLocal.isParent = true;

        DataUserLocal.HaveAccount = true;
        DataUserLocal.HaveAccount = true;
      });
    } else {
      setState(() {
        DataUserLocal.isVeryEmile = false;
        DataUserLocal.HaveAccount = false;
        DataUserLocal.HaveAccount = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    DB = new DBProviderUser();
    DBDri = new DBProviderDriverBuses();
    DataUserLocal.getdataaccount();
    DataUserLocal.addShollChoseToRefrences();

    checkAccount();

    // DataUserLocal.HaveAccount = prefs.getBool("HaveAccount");

    if (prefs != null)
      setState(() {
        //  DataUserLocal.HaveAccount = prefs.getBool("HaveAccount");
      });

    if (DataScoolAndDriverChooseLocal.getSchooIdFromRefrences() != null) {
      setState(() {
        ChooseIdShool = true;
      });
    }
    if (DataScoolAndDriverChooseLocal.getDriverNameFromRefrences() != null) {
      setState(() {
        ChooseNameDrive = true;
      });
    }
    if (DataScoolAndDriverChooseLocal.getDriverIdFromRefrences() != null) {
      setState(() {
        ChooseIdDrive = true;
      });
    }

    if (DataScoolAndDriverChooseLocal.getSchooNameFromRefrences() != null) {
      setState(() {
        ChooseNameShool = true;
      });
    }

    // Navigator.of(context).pushReplacement(
    // MaterialPageRoute(builder:
    // (ctx) => HomeScrean(
    //
    // )));

    AutoMoeve = true;

    setState(() {
      if (prefs != null) {
        DataUserLocal.HaveAccount = prefs.getBool("HaveAccount");
      } else {}
    });

    setState(() {
      if (prefs != null) {
        DataUserLocal.HaveAccount = prefs.getBool("HaveAccount");
      }
    });

    try {
      sharedPrefInit(
          prefs.getBool("HaveAccount"),
          prefs.getBool(UserTextTable.IS_VERIFY_TEXT),
          prefs.getString(UserTextTable.EMAILE_TEXT),
          prefs.getString(UserTextTable.SEESION_TEXT),
          prefs.getString(UserTextTable.FULL_NAME_TEXT),
          prefs.getString(UserTextTable.PASSWORD_TEXT),
          prefs.getString(UserTextTable.PHONE_NO_TEXT),
          prefs.getString(UserTextTable.IMEI_device_TEXT),
          prefs.getString(UserTextTable.KEY_VERIFY_TEXT),
          prefs.getString(UserTextTable.USERNAME_TEXT),
          prefs.getInt(UserTextTable.ID_USER_TEXT));
    } catch (e, s) {
      sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
    }
    setState(() {
      try {
        //  if (prefs.getString(UserTextTable.EMAILE_TEXT) != null || (prefs.getString(UserTextTable.EMAILE_TEXT).isNotEmpty &&  prefs.getString(UserTextTable.EMAILE_TEXT)!="") )
        sharedPrefInit(
            prefs.getBool("HaveAccount"),
            prefs.getBool(UserTextTable.IS_VERIFY_TEXT),
            prefs.getString(UserTextTable.EMAILE_TEXT),
            prefs.getString(UserTextTable.SEESION_TEXT),
            prefs.getString(UserTextTable.FULL_NAME_TEXT),
            prefs.getString(UserTextTable.PASSWORD_TEXT),
            prefs.getString(UserTextTable.PHONE_NO_TEXT),
            prefs.getString(UserTextTable.IMEI_device_TEXT),
            prefs.getString(UserTextTable.KEY_VERIFY_TEXT),
            prefs.getString(UserTextTable.USERNAME_TEXT),
            prefs.getInt(UserTextTable.ID_USER_TEXT));
      } catch (e, s) {
        sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
      }
    });
    if (prefs != null) setState(() => prefs.setBool("intilize", true));

    setState(() {
      if (prefs != null) {
        DataUserLocal.HaveAccount = prefs.getBool("HaveAccount");
      }
    });

    DB = new DBProviderUser();
    getdataaccount();

    DB = new DBProviderUser();
    getdataaccount();
  }

  String textSplash = "شاهد وتمتع بأجمل المناضر الخلابة بالجمهورية اليمنية";
  Widget navigateAfterFuture;

  bool AutoMoeve;

  var second_plash_crean = 10;
  Color colortext = Colors.black;

  var ChooseIdDrive;
  var ChooseIdShool;

  var ChooseNameDrive;
  var ChooseNameShool;

  void showInSnackBar(String value, BuildContext context) {
    //  _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Icon(Icons.message),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: value,
        onPressed: () {},
      ),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext contexttt) {
    setState(() {
      if (prefs != null) {
        DataUserLocal.HaveAccount = prefs.getBool("HaveAccount");
      }
    });
    setState(() {
      if (prefs != null) {
        DataUserLocal.HaveAccount = prefs.getBool("HaveAccount");
      } else {
        setState(() {});
      }
    });

    setState(() {
      if (prefs != null) {}
    });

    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          body: SplashScreen(
            backgroundColor: ColorAPP.colorWhite,
            title: Text(
              "حافلتي",
              style: TextStyle(
                color: ColorAPP.lightGreen,
                fontSize: 20,
              ),
            ),
            seconds: DataUserLocal.isParent != null &&
                    DataUserLocal.isDriver != null &&
                    ChooseNameShool != null &&
                    ChooseNameDrive != null &&
                    ChooseIdShool != null &&
                    ChooseIdDrive != null &&
                    DataUserLocal.isVeryEmile != null &&
                    DataUserLocal.HaveAccount != null
                ? 2
                : 5,
            loaderColor: ColorAPP.colorWhite,
            useLoader: false,
            navigateAfterSeconds: DataUserLocal.HaveAccount == false
                ? LogInScrean()
                : DataUserLocal.HaveAccount == true &&
                        DataUserLocal.isDriver == true
                    ? HomeDriverScrean()
                    : DataUserLocal.HaveAccount == true &&
                            DataUserLocal.isParent == true
                        ? HomeScrean()
                        : ChooseNameShool == true &&
                                ChooseNameDrive == true &&
                                ChooseIdShool == true &&
                                ChooseIdDrive == true
                            ? HomeScrean()
                            : ChooseSchoolScrean(),
            photoSize: 200,
          )),
    );
  }

  final EmileController = TextEditingController();
  final PassowrdController = TextEditingController();

  Color colorIcon = ColorAPP.lightGreen;
  bool visablebassowrd = true;
  Icon iconVisableandnonvisable = Icon(Icons.visibility);
  bool checkforconvortImage = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  getdataaccount() async {
    DataUserLocal.UserAccountData = await DB.fetchUserAccount();

    if (DataUserLocal.UserAccountData.length > 0) {
      setState(() {
        print(DataUserLocal.UserAccountData.length);
      });
    }
  }
}
