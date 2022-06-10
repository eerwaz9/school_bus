import 'package:flutter/material.dart';
import 'package:school_ksa/lib/ApiProvider/APiInlocoParentis.dart';
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/DataBase/db_provider-driver_bus.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/InLocoParent.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Model/driver_buse.dart';
import 'package:school_ksa/lib/Widget/text_field_card.dart';

import '../../../main.dart';
import '../home.dart';
import 'RigisterParent.dart';

class VerificationEmileScrean extends StatefulWidget {
  @override
  _VerificationEmileScreanState createState() =>
      _VerificationEmileScreanState();
}

class _VerificationEmileScreanState extends State<VerificationEmileScrean> {
  MySharedPreferences MSharedPreferences = new MySharedPreferences();

  Future<List> datauser;
  String Messege;

  // fetchDataUserFromLocal() async {
  //   setState(() async {
  //     UserAccountData =  await DB.fetchUserAccount();
  //
  //   });
  //     UserAccountData =  await DB.fetchUserAccount();
  //
  // }

  double padingright;

  ParentApiProvider userApi;
  BuildContext scaffoldContext;

  void createSnackBar(String message) {
    final snackBar = new SnackBar(
        content: new Text(message), backgroundColor: ColorAPP.lightGreen);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Color colorIcon = ColorAPP.lightGreen;
  final KeyVerivyController = TextEditingController();

  bool _isVrifyOtp = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    KeyVerivyController.dispose();
    super.dispose();
  }

  String _fullName;
  String _status;
  String _bio;

  String _followers;
  String _posts;
  String _username;

  String IS_VERIFY_TEXT = "";
  int linghUser = 0;
  int linghDriver = 0;

  //

  initState() {
    // TODO: implement initState
    super.initState();

    //fetchDataUserFromLocal();
    // getdataaccount();
    setState(() {
      //UserAccountData = await DB.fetchUserAccount();
      DataUserLocal.addToRefrences();

      if (DataUserLocal.UserAccountData.length > 0) {
        linghUser = DataUserLocal.UserAccountData.length;
      } else {
        linghDriver = DataUserLocal.DriverAccountData.length;
      }
      if (linghUser > 0) {
        print(DataUserLocal.UserAccountData[0][UserTextTable.SEESION_TEXT]);
        print(DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT]);
        print(DataUserLocal.UserAccountData[0][UserTextTable.SEESION_TEXT]);
        print(DataUserLocal.UserAccountData[0][UserTextTable.IMAGES_USER_TEXT]);
        print(DataUserLocal.UserAccountData[0][UserTextTable.IS_VERIFY_TEXT]);
        print(DataUserLocal.UserAccountData[0][UserTextTable.KEY_VERIFY_TEXT]);
      }
      if (linghDriver > 0) {
        print(DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.SEESION_TEXT]);
        print(DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.EMAILE_TEXT]);
        print(DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.SEESION_TEXT]);
        print(DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.IMAGES_DriverBuses_TEXT]);
        print(DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.IS_VERIFY_TEXT]);
        print(DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.KEY_VERIFY_TEXT]);
      }

      Messege = "تم أنشاء الحساب قم بتأكيد الأيميل";
    });
    //  createSnackBar("تم أرسال رقم التحقق الى الايميل");

    if (DataUserLocal.UserAccountData.length > 0) {
      setState(() {
        _fullName =
            DataUserLocal.UserAccountData[0][UserTextTable.FULL_NAME_TEXT];
        _status = " ";
        _bio = " ";
        _followers =
            DataUserLocal.UserAccountData[0][UserTextTable.PHONE_NO_TEXT];
        _posts = DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT];
        _username =
            DataUserLocal.UserAccountData[0][UserTextTable.USERNAME_TEXT];

        //IS_VERIFY_TEXT =DataUserLocal.UserAccountData[0][UserTextTable.IS_VERIFY_TEXT];

        print(DataUserLocal.UserAccountData.length);

        // print("User Data : ${UserAccountData}");
        // print("User Data : ${UserAccountData[0]['id']}");
        //
        // print("ID : ${UserAccountData[0][UserTextTable.ID_USER_TEXT]}");
        // print("Full_Name : ${UserAccountData[0][UserTextTable.FULL_NAME_TEXT]}");
        // print("UserName : ${UserAccountData[0][UserTextTable.USERNAME_TEXT]}");
        // print("password : ${UserAccountData[0][UserTextTable.PASSWORD_TEXT]}");
        // print("KEY_VERIFY_TEXT : ${UserAccountData[0][UserTextTable.KEY_VERIFY_TEXT]}");
        // print("IS_VERIFY_TEXT : ${UserAccountData[0][UserTextTable.IS_VERIFY_TEXT]}");
        //
        // print("Data : ${DB.fetchUserAccount()}");
      });
    }
    if (linghDriver > 0) {
      setState(() {
        _fullName = DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.FULL_NAME_TEXT];
        _status = " ";
        _bio = " ";
        _followers = DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.PHONE_NO_TEXT];
        _posts = DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.EMAILE_TEXT];
        _username = DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.USERNAME_TEXT];

        IS_VERIFY_TEXT = DataUserLocal.DriverAccountData[0]
            [DriverBusesTextTable.IS_VERIFY_TEXT];

        print(DataUserLocal.DriverAccountData.length);

        // print("User Data : ${UserAccountData}");
        // print("User Data : ${UserAccountData[0]['id']}");
        //
        // print("ID : ${UserAccountData[0][UserTextTable.ID_USER_TEXT]}");
        // print("Full_Name : ${UserAccountData[0][UserTextTable.FULL_NAME_TEXT]}");
        // print("UserName : ${UserAccountData[0][UserTextTable.USERNAME_TEXT]}");
        // print("password : ${UserAccountData[0][UserTextTable.PASSWORD_TEXT]}");
        // print("KEY_VERIFY_TEXT : ${UserAccountData[0][UserTextTable.KEY_VERIFY_TEXT]}");
        // print("IS_VERIFY_TEXT : ${UserAccountData[0][UserTextTable.IS_VERIFY_TEXT]}");
        //
        // print("Data : ${DB.fetchUserAccount()}");
      });
    }

    // userApi.fetchOneUser(_email);
    //  getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: InkWell(
        highlightColor: ColorAPP.lightGreen,
        child: Stack(
          children: [
            new Container(
                decoration: BoxDecoration(
              color: ColorAPP.lightGreen,
            )),
            Container(
                child: Container(
              margin: EdgeInsets.only(top: 100, right: 30, left: 60),
              //width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: ColorAPP.lightGreen,
                    blurRadius: 300,
                    offset: Offset.infinite,
                    //spreadRadius: 100000
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 17,
                    color: ColorAPP.lightGreen,
                  ),
                  Text(
                    "التحقق من الحساب",
                    style: TextStyle(fontSize: 17.0, color: Colors.black),
                  ),
                ],
              ),
            )),
            Container(
              child: Container(
                padding: EdgeInsets.only(top: 180),
                child: ListView(
                  children: <Widget>[
                    //sart cat

                    //END cat

                    Container(
                        height: MediaQuery.of(context).size.height - 180,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              ColorAPP.lightGreen.withOpacity(0.6),
                              ColorAPP.lightGreen.withOpacity(0.3),
                              ColorAPP.lightGreen.withOpacity(0.3),
                              ColorAPP.lightGreen.withOpacity(0.9),
                              ColorAPP.lightGreen.withOpacity(0.6),
                              ColorAPP.lightGreen.withOpacity(0.3),
                              Colors.white
                            ],
                            stops: [0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 10],
                            center: Alignment(0.3, 0.5),
                            focal: Alignment(0.9, 0.2),
                            focalRadius: 5,
                          ),

/*

                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,

                                  colors: [ Colors.white.withOpacity(0.6) ,
                                    ColorAPP.lightGreen.withOpacity(0.6),

                                    Colors.white.withOpacity(0.5) ,
                                    Colors.white38,  ColorAPP.lightGreen.withOpacity(0.9),Colors.white, Colors.white,Colors.white ,Colors.white,  Colors.white,Colors.white ,Colors.white,Colors.white,Colors.white ,Colors.white,Colors.white, Colors.white,Colors.white, Colors.white,Colors.white,Colors.white, Colors.white]
                              ),
*/

                          boxShadow: [
                            new BoxShadow(
                              color: ColorAPP.lightGreen,
                              blurRadius: 300,
                              offset: Offset.infinite,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50.0),
                              topLeft: Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.only(
                            bottom: 50, left: 10, right: 10, top: 30),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height /
                                                10)),
                                Icon(
                                  Icons.email_outlined,
                                  color: ColorAPP.lightGreen,
                                ),
                                new Padding(padding: EdgeInsets.only(left: 15)),
                                Text(
                                  DataUserLocal.UserAccountData.length > 0
                                      ? DataUserLocal.UserAccountData[0]
                                                  [UserTextTable.EMAILE_TEXT] ==
                                              null
                                          ? ""
                                          : DataUserLocal.UserAccountData[0]
                                              [UserTextTable.EMAILE_TEXT]
                                      : DataUserLocal
                                                  .DriverAccountData.length <=
                                              0
                                          ? ""
                                          : DataUserLocal.DriverAccountData[0][
                                              DriverBusesTextTable.EMAILE_TEXT],
                                  style: TextStyle(
                                      fontSize: 15, color: ColorAPP.lightGreen),
                                )
                              ],
                            ),

                            // textFildBuildContainer(
                            //     " أدخل مفتاح التحقق",
                            //     " أدخل مفتاح التحقق  ",
                            //     TextInputType.number,
                            //     Icon(Icons.person, color: colorIcon,
                            //
                            //     ),
                            //     this.KeyVerivyController,
                            //     TextInputAction.join
                            // ),

                            TextInputTextCard(
                              labelTxt: "  مفتاح التحقق",
                              hintTxt: "ادخل مفتاح التحقق",
                              textinputaction: TextInputAction.done,
                              isPassword: false,
                              controller: this.KeyVerivyController,
                              iconsTextFild: Icon(
                                Icons.vpn_key,
                                color: colorIcon,
                              ),
                              textinputtype: TextInputType.number,
                              inputFormatter: [],
                            ),

                            Container(
                                margin: EdgeInsets.all(15),

                                //width: MediaQuery.of(context).size.width,

                                decoration: BoxDecoration(
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 100,
                                      offset: Offset.lerp(
                                          Offset.zero, Offset.infinite, 30),
                                      //spreadRadius: 100000
                                    ),
                                  ],
                                  color: ColorAPP.lightGreen,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50.0),
                                      topLeft: Radius.circular(50.0),
                                      bottomLeft: Radius.circular(50.0),
                                      bottomRight: Radius.circular(50.0)),
                                ),
                                child: Column(
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.focused))
                                            return Colors.red;
                                          if (states
                                              .contains(MaterialState.hovered))
                                            return ColorAPP.lightGreen;
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return ColorAPP.lightGreen;
                                          return null; // Defer to the widget's default.
                                        }),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          new Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      10)),
                                          Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                          new Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15)),
                                          Text(
                                            "التحقق",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      onPressed: () async {
                                        // setState(() {
                                        //
                                        // //  Provider.of<MyProvider>(context,listen: false).setIsveryVicade(true,   KeyVerivyController.value.text);
                                        //
                                        //
                                        //   });

                                        _isVrifyOtp = await OtpEmile.verify(
                                            linghUser > 0
                                                ? DataUserLocal
                                                        .UserAccountData[0]
                                                    [UserTextTable.EMAILE_TEXT]
                                                : DataUserLocal
                                                        .DriverAccountData[0][
                                                    DriverBusesTextTable
                                                        .EMAILE_TEXT],
                                            KeyVerivyController.value.text);

                                        setState(() {
                                          _isVrifyOtp = _isVrifyOtp;
                                        });

                                        print("_isVrifyOtp : ${_isVrifyOtp}");
                                        DBProviderUser db =
                                            new DBProviderUser();
                                        DBProviderDriverBuses dbDriveBus =
                                            new DBProviderDriverBuses();

                                        /* var dsjkjdsdj = await db
                                                      .getUserByID(_email);*/
                                        //print(dsjkjdsdj);

                                        //   prefs.setBool(UserTextTable.IS_VERIFY_TEXT, _isVrifyOtp);
                                        //prefs.setString(UserTextTable.SEESION_TEXT,  myProvider.Email);
                                        // prefs.setString(UserTextTable.KEY_VERIFY_TEXT, KeyVerivyController.value.text);

                                        if (DataUserLocal
                                                .UserAccountData.length >
                                            0) {
                                          InLocaParent newUser =
                                              new InLocaParent(
                                                  id: DataUserLocal.UserAccountData[0]
                                                      [UserTextTable
                                                          .ID_USER_TEXT],
                                                  password: DataUserLocal.UserAccountData[0]
                                                      [UserTextTable
                                                          .PASSWORD_TEXT],
                                                  Full_Name: DataUserLocal
                                                          .UserAccountData[0][
                                                      UserTextTable
                                                          .FULL_NAME_TEXT],
                                                  IMEI_device: DataUserLocal
                                                          .UserAccountData[0]
                                                      [UserTextTable.IMEI_device_TEXT],
                                                  session_no: DataUserLocal.UserAccountData[0][UserTextTable.SEESION_TEXT],
                                                  keyVerify: KeyVerivyController.value.text,
                                                  isVerify: _isVrifyOtp,
                                                  PhoneNo: DataUserLocal.UserAccountData[0][UserTextTable.PHONE_NO_TEXT],
                                                  Data_Update: DateTime.now().toString(),
                                                  Date_Added: DateTime.now().toString(),
                                                  Email: DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT],
                                                  UserName: DataUserLocal.UserAccountData[0][UserTextTable.USERNAME_TEXT],
                                                  // KeyActiveStatus: _isVrifyOtp,
                                                  images_user: null);

                                          var dsjkjds =
                                              await db.updateUser(newUser);
                                          print(dsjkjds);
                                          //}

                                        } else if (DataUserLocal
                                                .DriverAccountData.length >
                                            0) {
                                          DriverBuses newUser = new DriverBuses(
                                              school:
                                                  DataUserLocal.DriverAccountData[0]
                                                      [DriverBusesTextTable
                                                          .School_TEXT],
                                              id: DataUserLocal.DriverAccountData[0]
                                                  [DriverBusesTextTable
                                                      .ID_DriverBuses_TEXT],
                                              password: DataUserLocal
                                                      .DriverAccountData[0][
                                                  DriverBusesTextTable
                                                      .PASSWORD_TEXT],
                                              Full_Name: DataUserLocal
                                                      .DriverAccountData[0]
                                                  [DriverBusesTextTable.FULL_NAME_TEXT],
                                              IMEI_device: DataUserLocal.DriverAccountData[0][DriverBusesTextTable.IMEI_device_TEXT],
                                              session_no: DataUserLocal.DriverAccountData[0][DriverBusesTextTable.SEESION_TEXT],
                                              keyVerify: KeyVerivyController.value.text,
                                              isVerify: true,
                                              PhoneNo: DataUserLocal.DriverAccountData[0][DriverBusesTextTable.PHONE_NO_TEXT],
                                              Data_Update: DateTime.now().toString(),
                                              Date_Added: DateTime.now().toString(),
                                              Email: DataUserLocal.DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT],
                                              UserName: DataUserLocal.DriverAccountData[0][DriverBusesTextTable.USERNAME_TEXT],
                                              // KeyActiveStatus: _isVrifyOtp,
                                              images_user: null);

                                          dbDriveBus.deleteAll();

                                          var dsjkjds =
                                              await dbDriveBus.newUser(newUser);
                                          print(dsjkjds);
                                        }

                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScrean()));
                                      },
                                    ),
                                  ],
                                )),

                            Center(
                              child: FlatButton(
                                padding: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width / 4,
                                ),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment
                                  //     .center,
                                  //
                                  // mainAxisAlignment: MainAxisAlignment
                                  //     .center,

                                  children: <Widget>[
                                    Icon(
                                      Icons.rotate_right,
                                      color: ColorAPP.lightGreen,
                                    ),
                                    Text("     "),
                                    Text(
                                      "تغير البريد الألكتروني ؟",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: ColorAPP.lightGreen),
                                    )
                                  ],
                                ),
                                onPressed: () async {
                                  //await DB.deleteAll();

                                  // print(
                                  //     "EMileeeeeeeeeeeee${ UserAccountData[0][UserTextTable.EMAILE_TEXT]}");
                                  // print(
                                  //     "EMileeeeeeeeeeeee${ UserAccountData[0][UserTextTable.EMAILE_TEXT]}");

                                  //prefs.clear();
                                  prefs.setBool("HaveAccount", false);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAccountParent()));
                                },
                              ),
                            ),

                            Center(
                              child: FlatButton(
                                padding: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width / 4,
                                  // left:  MediaQuery.of(context).size.width/3 ,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.rotate_right,
                                      color: ColorAPP.lightGreen,
                                    ),
                                    Text("     "),
                                    Text(
                                      "أعد الأرسال ؟",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: ColorAPP.lightGreen),
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  DataUserLocal.DriverAccountData.length > 0
                                      ? print(DataUserLocal.DriverAccountData[0]
                                          [DriverBusesTextTable.EMAILE_TEXT])
                                      : print(DataUserLocal.UserAccountData[0]
                                          [UserTextTable.EMAILE_TEXT]);

                                  DataUserLocal.DriverAccountData.length > 0
                                      ? OtpEmile.sendOtp(DataUserLocal
                                              .DriverAccountData[0]
                                          [DriverBusesTextTable.EMAILE_TEXT])
                                      : OtpEmile.sendOtp(
                                          DataUserLocal.UserAccountData[0]
                                              [UserTextTable.EMAILE_TEXT]);

                                  //   sendMassege();
                                },
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
