import 'package:flutter/material.dart';
import 'package:school_ksa/lib/ApiProvider/APiInlocoParentis.dart';
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/DataBase/db_provider-driver_bus.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/InLocoParent.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Model/driver_buse.dart';
import 'package:school_ksa/lib/Model/input_format.dart';
import 'package:school_ksa/lib/Widget/buildFullName.dart';
import 'package:school_ksa/lib/Widget/buildStatItemUserName.dart';
import 'package:school_ksa/lib/Widget/text_field_card.dart';

import '../../../main.dart';
import '../home.dart';
import 'Profile/bus_driver_screan.dart';
import 'Profile/profile_parent.dart';
import 'RigisterParent.dart';
import 'logIn.dart';

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // UserModel _currentUser;

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

  int IS_VERIFY_TEXT = 0;
  int linghUser = 0;
  int linghDriver = 0;

  //

  @override
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

        IS_VERIFY_TEXT =
            DataUserLocal.UserAccountData[0][UserTextTable.IS_VERIFY_TEXT];

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

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/personProfile.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 140.0,
          height: 140.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/person.jpg'),
              fit: BoxFit.scaleDown,
            ),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(
              color: Colors.white,
              width: 5.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(children: [
            _buildFullName(),
            BuildStatItemUserName(
              Icons: Icons.person,
              count: _username,
            )
          ]),
        ),
      ],
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName.split(" ")[0] +
          " " +
          _fullName.split(" ")[_fullName.split(" ").length - 1],
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItemUserName(Icons, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons,
          size: 20,
          color: Colors.black54,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          count,
          style: _statCountTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatItem(Icons, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons,
          size: 20,
          color: Colors.black54,
        ),
        Text(
          count,
          style: _statCountTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 150.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem(Icons.phone_android, _followers),
          _buildStatItem(Icons.email, _posts),
          // _buildStatItem(Icons.person, _username),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        //   "Get in Touch with ${_fullName.split(" ")[0]}," ,
        "",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              //  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SettingScrean())),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: ColorAPP.lightGreen,
                ),
                child: Center(
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              //  onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => mainCityList())),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "الرئيسية",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(linghUser);
    print(linghDriver);

    if (linghUser <= 0 && linghDriver <= 0) return LogInScrean();
    if (linghUser > 0) {
      if (DataUserLocal.UserAccountData[0][UserTextTable.IS_VERIFY_TEXT] == 1) {
        /* return Scaffold(
          appBar: AppBar(
            title: Text("ProfilePage"),
            centerTitle: true,
          ),
          body: new Builder(builder: (BuildContext context) {
            scaffoldContext = context;


            return

              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "uid is ${UserAccountData[0][UserTextTable.ID_USER_TEXT]} , email is ${ UserAccountData[0][UserTextTable.EMAILE_TEXT]}, name is ${UserAccountData[0][UserTextTable.FULL_NAME_TEXT]}",
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: RaisedButton(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.orange,
                      onPressed: () {
                        setState(() {

                        });
                      },
                    ),
                  ),
                ],
              );
          },

          )
      );*/

        Size screenSize = MediaQuery.of(context).size;
        return ProfileParentScreen();
      } else {
        return ProfileBusDriverScreen();

        // if (_currentUser != null) {
        //   print("EMileeeeeeeeeeeee2 ${ prefs.getString(
        //       UserTextTable.EMAILE_TEXT)}");
        //   print(
        //       "EMileeeeeeeeeeeee2 ${UserAccountData[0][UserTextTable.EMAILE_TEXT]}");
        // }
//
//         return Directionality(textDirection: TextDirection.rtl,
//           child: Scaffold(
//
//
//               body:
//
//
//               InkWell(
//                 highlightColor: ColorAPP.lightGreen,
//                 child: Stack(
//
//                   children: [
//
//
//                     new Container(
//                         decoration: BoxDecoration(
//                           color: ColorAPP.lightGreen,
//
//
//                         )
//
//
//                     ),
//
//                     Container(
//                         child: Container(
//
//
//                           margin: EdgeInsets.only(top: 100, right: 30,
//                               left: 60
//
//                           )
//                           ,
//                           //width: MediaQuery.of(context).size.width,
//
//                           decoration: BoxDecoration(
//
//                             boxShadow: [
//                               new BoxShadow(
//                                 color: ColorAPP.lightGreen
//                                 ,
//                                 blurRadius: 300,
//                                 offset: Offset.infinite,
//                                 //spreadRadius: 100000
//
//                               ),
//                             ],
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(20.0),
//                                 topLeft: Radius.circular(20.0),
//                                 bottomLeft: Radius.circular(20.0),
//                                 bottomRight: Radius.circular(20.0)),
//                           ),
//
//
//                           child: Row(
//                             children: [
//                               Icon(Icons.add, size: 17,
//                                 color: ColorAPP.lightGreen,),
//                               Text("التحقق من الحساب", style: TextStyle(
//                                   fontSize: 17.0,
//                                   color: Colors.black),),
//
//
//
//
//                             ],
//                           ),
//                         )
//                     ),
//
//                     Container(
//                       child: Container(
//
//                         padding: EdgeInsets.only(top: 180),
//
//                         child:
//                         ListView(
//                           children: <Widget>[
//
//
//                             //sart cat
//
//                             //END cat
//
//
//                             Container(
//
//                                 height: MediaQuery.of(context).size.height-180,
//                                 decoration: BoxDecoration(
//
//
//                                   gradient: RadialGradient(
//                                     colors: [
//                                       ColorAPP.lightGreen.withOpacity(0.6),
//                                       ColorAPP.lightGreen.withOpacity(0.3),
//                                       ColorAPP.lightGreen.withOpacity(0.3),
//                                       ColorAPP.lightGreen.withOpacity(0.9),
//                                       ColorAPP.lightGreen.withOpacity(0.6),
//                                       ColorAPP.lightGreen.withOpacity(0.3),
//                                       Colors.white
//                                     ],
//                                     stops: [0.7, 0.7, 0.7, 0.7, 0.7, 0.7, 10],
//
//                                     center: Alignment(0.3, 0.5),
//                                     focal: Alignment(0.9, 0.2),
//                                     focalRadius: 5,
//                                   ),
//
//
// /*
//
//                               gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//
//                                   colors: [ Colors.white.withOpacity(0.6) ,
//                                     ColorAPP.lightGreen.withOpacity(0.6),
//
//                                     Colors.white.withOpacity(0.5) ,
//                                     Colors.white38,  ColorAPP.lightGreen.withOpacity(0.9),Colors.white, Colors.white,Colors.white ,Colors.white,  Colors.white,Colors.white ,Colors.white,Colors.white,Colors.white ,Colors.white,Colors.white, Colors.white,Colors.white, Colors.white,Colors.white,Colors.white, Colors.white]
//                               ),
// */
//
//
//                                   boxShadow: [
//                                     new BoxShadow(
//
//
//                                       color: ColorAPP.lightGreen
//                                       ,
//                                       blurRadius: 300,
//                                       offset: Offset.infinite,
//
//
//                                     ),
//                                   ],
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(50.0),
//                                       topLeft: Radius.circular(50.0)),
//                                 ),
//
//                                 padding: EdgeInsets.only(
//                                     bottom: 50, left: 10, right: 10, top: 30),
//
//
//                                 child:
//                                 Column(
//                                   children: <Widget>[
//
//
//                                     Row(
//
//
//                                       children: <Widget>[
//                                         new Padding(
//                                             padding: EdgeInsets.only(left:
//                                             MediaQuery
//                                                 .of(context)
//                                                 .size
//                                                 .height / 10)),
//                                         Icon(Icons.email_outlined,
//                                           color: ColorAPP.lightGreen,),
//                                         new Padding(
//                                             padding: EdgeInsets.only(left:
//                                             15)),
//
//                                         Text(DataUserLocal.UserAccountData.length>0 ? DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT] == null
//                                             ? ""
//                                             : DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT]:
//                                         DataUserLocal.DriverAccountData.length<=0
//
//                                             ?
//
//                                         ""
//                                             : DataUserLocal.DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT]
//
//
//                                           ,
//                                           style: TextStyle(
//                                               fontSize: 15,
//                                               color: ColorAPP.lightGreen),)
//                                       ],
//
//
//                                     ),
//
//                                     // textFildBuildContainer(
//                                     //     " أدخل مفتاح التحقق",
//                                     //     " أدخل مفتاح التحقق  ",
//                                     //     TextInputType.number,
//                                     //     Icon(Icons.person, color: colorIcon,
//                                     //
//                                     //     ),
//                                     //     this.KeyVerivyController,
//                                     //     TextInputAction.join
//                                     // ),
//
//
//
//                                     TextInputTextCard(
//                                       labelTxt: "  مفتاح التحقق",
//                                       hintTxt: "ادخل مفتاح التحقق",
//                                       textinputaction: TextInputAction.done,
//                                       isPassword: false,
//                                       controller:  this.KeyVerivyController,
//                                       iconsTextFild: Icon(Icons.vpn_key,color:colorIcon,),
//                                       textinputtype:  TextInputType.number,
//
//
//                                     ),
//
//
//                                     Container(
//                                         margin: EdgeInsets.all(15),
//
//
//                                         //width: MediaQuery.of(context).size.width,
//
//                                         decoration: BoxDecoration(
//
//                                           boxShadow: [
//                                             new BoxShadow(
//                                               color: Colors.grey
//                                               ,
//                                               blurRadius: 100,
//                                               offset: Offset.lerp(Offset.zero,
//                                                   Offset.infinite, 30),
//                                               //spreadRadius: 100000
//
//                                             ),
//                                           ],
//                                           color: ColorAPP.lightGreen,
//                                           borderRadius: BorderRadius.only(
//                                               topRight: Radius.circular(50.0),
//                                               topLeft: Radius.circular(50.0),
//                                               bottomLeft: Radius.circular(
//                                                   50.0),
//                                               bottomRight: Radius.circular(
//                                                   50.0)),
//                                         ),
//
//
//                                         child: Column(
//                                           children: [
//
//                                             TextButton(
//                                               style: ButtonStyle(
//
//
//                                                 overlayColor: MaterialStateProperty
//                                                     .resolveWith<Color>(
//                                                         (Set<
//                                                         MaterialState> states) {
//                                                       if (states.contains(
//                                                           MaterialState
//                                                               .focused))
//                                                         return Colors.red;
//                                                       if (states.contains(
//                                                           MaterialState
//                                                               .hovered))
//                                                         return ColorAPP.lightGreen;
//                                                       if (states.contains(
//                                                           MaterialState
//                                                               .pressed))
//                                                         return ColorAPP.lightGreen;
//                                                       return null; // Defer to the widget's default.
//                                                     }),
//                                               ),
//
//
//                                               child: Row(
//
//
//                                                 children: <Widget>[
//                                                   new Padding(
//                                                       padding: EdgeInsets
//                                                           .only(left:
//                                                       MediaQuery
//                                                           .of(context)
//                                                           .size
//                                                           .height / 10)),
//                                                   Icon(Icons.person,
//                                                     color: Colors.white,),
//                                                   new Padding(
//                                                       padding: EdgeInsets
//                                                           .only(left:
//                                                       15)),
//
//                                                   Text("التحقق",
//                                                     style: TextStyle(
//                                                         fontSize: 20,
//                                                         color: Colors.white),)
//                                                 ],
//
//
//                                               ),
//
//                                               onPressed: () async {
//                                                 // setState(() {
//                                                 //
//                                                 // //  Provider.of<MyProvider>(context,listen: false).setIsveryVicade(true,   KeyVerivyController.value.text);
//                                                 //
//                                                 //
//                                                 //   });
//
//
//                                                 _isVrifyOtp = await OtpEmile.verify(
//                                                     linghUser>0?
//                                                     DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT]
//
//                                                         :DataUserLocal.DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT],
//                                                     KeyVerivyController.value
//                                                         .text);
//                                                 setState(() {
//                                                   _isVrifyOtp = _isVrifyOtp;
//                                                 });
//
//
//                                                 print("_isVrifyOtp : ${_isVrifyOtp}");
//                                                 DBProviderUser db = new DBProviderUser();
//                                                 DBProviderDriverBuses dbDriveBus = new DBProviderDriverBuses();
//
//
//                                                 /* var dsjkjdsdj = await db
//                                                       .getUserByID(_email);*/
//                                                 //print(dsjkjdsdj);
//
//
//
//                                                 var Id_user = await db
//                                                     .getIdLastUser();
//                                                 /* if(Id_user!=null){*/
//
//
//
//                                                 //   prefs.setBool(UserTextTable.IS_VERIFY_TEXT, _isVrifyOtp);
//                                                 //prefs.setString(UserTextTable.SEESION_TEXT,  myProvider.Email);
//                                                 // prefs.setString(UserTextTable.KEY_VERIFY_TEXT, KeyVerivyController.value.text);
//
//                                                 if (DataUserLocal.UserAccountData.length>0) {
//                                                   InLocaParent newUser = new InLocaParent(
//                                                       id:DataUserLocal
//                                                           .UserAccountData[0][UserTextTable
//                                                           .ID_USER_TEXT],
//                                                       password: DataUserLocal
//                                                           .UserAccountData[0][UserTextTable
//                                                           .PASSWORD_TEXT],
//                                                       Full_Name: DataUserLocal
//                                                           .UserAccountData[0][UserTextTable
//                                                           .FULL_NAME_TEXT],
//                                                       IMEI_device: DataUserLocal
//                                                           .UserAccountData[0][UserTextTable
//                                                           .IMEI_device_TEXT],
//                                                       session_no: DataUserLocal
//                                                           .UserAccountData[0][UserTextTable
//                                                           .SEESION_TEXT],
//                                                       keyVerify: KeyVerivyController
//                                                           .value.text,
//                                                       isVerify: _isVrifyOtp,
//                                                       PhoneNo: DataUserLocal
//                                                           .UserAccountData[0][UserTextTable
//                                                           .PHONE_NO_TEXT],
//                                                       Data_Update: DateTime.now()
//                                                           .toString(),
//                                                       Date_Added: DateTime.now()
//                                                           .toString(),
//                                                       Email: DataUserLocal
//                                                           .UserAccountData[0][UserTextTable
//                                                           .EMAILE_TEXT],
//                                                       UserName: DataUserLocal
//                                                           .UserAccountData[0][UserTextTable
//                                                           .USERNAME_TEXT],
//                                                       // KeyActiveStatus: _isVrifyOtp,
//                                                       images_user: null
//
//
//                                                   );
//
//
//                                                   var dsjkjds = await db
//                                                       .updateUser(newUser);
//                                                   print(dsjkjds);
//                                                   //}
//
//                                                 }
//
//
//                                                 else if (DataUserLocal.DriverAccountData.length>0) {
//                                                   DriverBuses newUser = new DriverBuses(
//                                                       school: DataUserLocal
//                                                           .DriverAccountData[0][DriverBusesTextTable
//                                                           .School_TEXT]
//                                                       ,
//                                                       id:DataUserLocal
//                                                           .DriverAccountData[0][DriverBusesTextTable
//                                                           .ID_DriverBuses_TEXT],
//                                                       password: DataUserLocal
//                                                           .DriverAccountData[0][DriverBusesTextTable
//                                                           .PASSWORD_TEXT],
//                                                       Full_Name: DataUserLocal
//                                                           .DriverAccountData[0][DriverBusesTextTable
//                                                           .FULL_NAME_TEXT],
//                                                       IMEI_device: DataUserLocal
//                                                           .DriverAccountData[0][DriverBusesTextTable
//                                                           .IMEI_device_TEXT],
//                                                       session_no: DataUserLocal
//                                                           .DriverAccountData[0][DriverBusesTextTable
//                                                           .SEESION_TEXT],
//                                                       keyVerify: KeyVerivyController
//                                                           .value.text,
//                                                       isVerify: true,
//                                                       PhoneNo: DataUserLocal
//                                                           .DriverAccountData[0][DriverBusesTextTable
//                                                           .PHONE_NO_TEXT],
//                                                       Data_Update: DateTime.now()
//                                                           .toString(),
//                                                       Date_Added: DateTime.now()
//                                                           .toString(),
//                                                       Email: DataUserLocal
//                                                           .DriverAccountData[0][DriverBusesTextTable
//                                                           .EMAILE_TEXT],
//                                                       UserName: DataUserLocal
//                                                           .DriverAccountData[0][DriverBusesTextTable
//                                                           .USERNAME_TEXT],
//                                                       // KeyActiveStatus: _isVrifyOtp,
//                                                       images_user: null
//
//
//                                                   );
//                                                   dbDriveBus
//                                                       .deleteAll();
//
//                                                   var dsjkjds = await dbDriveBus
//                                                       .newUser(newUser);
//                                                   print(dsjkjds);
//                                                   //}
//
//                                                 }
//
//
//                                                 Navigator.of(context).pushReplacement(
//                                                     MaterialPageRoute
//                                                       (builder: (context) =>
//                                                         HomeScrean(
//
//                                                         )));
//
//
//                                               },
//                                             ),
//
//
//                                           ],
//                                         )
//                                     ),
//
//
//                                     Center(
//                                       child: FlatButton(
//
//                                         padding: EdgeInsets.only(
//                                           right:  MediaQuery.of(context).size.width/4,
//
//                                         ),
//
//
//                                         child: Row(
//
//
//                                           // crossAxisAlignment: CrossAxisAlignment
//                                           //     .center,
//                                           //
//                                           // mainAxisAlignment: MainAxisAlignment
//                                           //     .center,
//
//                                           children: <Widget>[
//
//                                             Icon(Icons.rotate_right,
//                                               color: ColorAPP.lightGreen,),
//                                             Text("     "),
//                                             Text("تغير البريد الألكتروني ؟",
//                                               style: TextStyle(fontSize: 20,
//                                                   color: ColorAPP
//                                                       .lightGreen),)
//                                           ],
//
//
//                                         )
//
//
//                                         , onPressed: () async {
//
//                                         //await DB.deleteAll();
//
//                                         // print(
//                                         //     "EMileeeeeeeeeeeee${ UserAccountData[0][UserTextTable.EMAILE_TEXT]}");
//                                         // print(
//                                         //     "EMileeeeeeeeeeeee${ UserAccountData[0][UserTextTable.EMAILE_TEXT]}");
//
//                                         //prefs.clear();
//                                         prefs.setBool("HaveAccount",false);
//                                         Navigator.of(context).pushReplacement(
//                                             MaterialPageRoute
//                                               (builder: (context) =>
//                                                 CreateAccountParent(
//
//                                                 )));
//                                       },
//                                       ),
//                                     ),
//
//                                     Center(
//                                       child: FlatButton(
//
//                                         padding: EdgeInsets.only(
//                                           right:  MediaQuery.of(context).size.width/4,
//                                           // left:  MediaQuery.of(context).size.width/3 ,
//                                         ),
//
//
//                                         child: Row(
//
//
//                                           children: <Widget>[
//
//                                             Icon(Icons.rotate_right,
//                                               color: ColorAPP.lightGreen,),
//                                             Text("     "),
//                                             Text("أعد الأرسال ؟",
//                                               style: TextStyle(fontSize: 20,
//                                                   color: ColorAPP
//                                                       .lightGreen),)
//                                           ],
//
//
//                                         )
//
//
//                                         , onPressed: ()  {
//
//
//                                         DataUserLocal.DriverAccountData.length>0?
//
//                                         print(DataUserLocal.DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT])
//
//                                             :
//                                         print(DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT]);
//
//
//                                         DataUserLocal.DriverAccountData.length>0?
//
//                                         OtpEmile.sendOtp(DataUserLocal.DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT])
//
//                                             :
//                                         OtpEmile.sendOtp(DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT]);
//                                       },
//                                       ),
//                                     )
//
//
//                                   ],
//
//                                 )
//                             ),
//
//
//                           ],
//                         ),
//                       ),),
//
//                   ],
//
//                 ),
//               )
//
//
//           ),
//         );
//
//

      }
    } else if (linghDriver > 0) {
      if (DataUserLocal.DriverAccountData[0][UserTextTable.IS_VERIFY_TEXT] ==
              1 ||
          DataUserLocal.DriverAccountData[0]
                  [DriverBusesTextTable.IS_VERIFY_TEXT] !=
              null) {
        /* return Scaffold(
          appBar: AppBar(
            title: Text("ProfilePage"),
            centerTitle: true,
          ),
          body: new Builder(builder: (BuildContext context) {
            scaffoldContext = context;


            return

              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "uid is ${UserAccountData[0][UserTextTable.ID_USER_TEXT]} , email is ${ UserAccountData[0][UserTextTable.EMAILE_TEXT]}, name is ${UserAccountData[0][UserTextTable.FULL_NAME_TEXT]}",
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: RaisedButton(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.orange,
                      onPressed: () {
                        setState(() {

                        });
                      },
                    ),
                  ),
                ],
              );
          },

          )
      );*/

        Size screenSize = MediaQuery.of(context).size;
        return Scaffold(
          body: Stack(
            children: <Widget>[
              _buildCoverImage(screenSize),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 6.4),
                      _buildProfileImage(),
                      _buildStatus(context),
                      _buildStatContainer(),
                      _buildBio(context),
                      _buildSeparator(screenSize),
                      SizedBox(height: 10.0),
                      _buildGetInTouch(context),
                      SizedBox(height: 8.0),
                      _buildButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        // if (_currentUser != null) {
        //   print("EMileeeeeeeeeeeee2 ${ prefs.getString(
        //       UserTextTable.EMAILE_TEXT)}");
        //   print(
        //       "EMileeeeeeeeeeeee2 ${UserAccountData[0][UserTextTable.EMAILE_TEXT]}");
        // }

      }
    } else {
      // if (_currentUser != null) {
      //   print("EMileeeeeeeeeeeee2 ${ prefs.getString(
      //       UserTextTable.EMAILE_TEXT)}");
      //   print(
      //       "EMileeeeeeeeeeeee2 ${UserAccountData[0][UserTextTable.EMAILE_TEXT]}");
      // }

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
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10)),
                                  Icon(
                                    Icons.email_outlined,
                                    color: ColorAPP.lightGreen,
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(left: 15)),
                                  Text(
                                    DataUserLocal.UserAccountData.length > 0
                                        ? DataUserLocal.UserAccountData[0][
                                                    UserTextTable
                                                        .EMAILE_TEXT] ==
                                                null
                                            ? "jdkhdsksd"
                                            : DataUserLocal.UserAccountData[0]
                                                [UserTextTable.EMAILE_TEXT]
                                        : DataUserLocal
                                                    .DriverAccountData.length <=
                                                0
                                            ? "jdkhdsksd"
                                            : DataUserLocal.DriverAccountData[0]
                                                [DriverBusesTextTable
                                                    .EMAILE_TEXT],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: ColorAPP.lightGreen),
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
                                inputFormatter:
                                    InputFormat.KeyVerivyInputFormatters,
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
                                            if (states.contains(
                                                MaterialState.focused))
                                              return Colors.red;
                                            if (states.contains(
                                                MaterialState.hovered))
                                              return ColorAPP.lightGreen;
                                            if (states.contains(
                                                MaterialState.pressed))
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
                                                          .UserAccountData[0][
                                                      UserTextTable.EMAILE_TEXT]
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

                                          var Id_user =
                                              await db.getIdLastUser();
                                          /* if(Id_user!=null){*/

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
                                                    Full_Name:
                                                        DataUserLocal.UserAccountData[0]
                                                            [UserTextTable
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
                                            DriverBuses newUser =
                                                new DriverBuses(
                                                    school: DataUserLocal.DriverAccountData[0]
                                                        [DriverBusesTextTable
                                                            .School_TEXT],
                                                    id: DataUserLocal.DriverAccountData[0]
                                                        [DriverBusesTextTable
                                                            .ID_DriverBuses_TEXT],
                                                    password: DataUserLocal.DriverAccountData[0]
                                                        [DriverBusesTextTable
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

                                            var dsjkjds = await dbDriveBus
                                                .updateUser(newUser);
                                            print(dsjkjds);
                                            //}

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
                                    right:
                                        MediaQuery.of(context).size.width / 4,
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
                                    right:
                                        MediaQuery.of(context).size.width / 4,
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
                                        ? print(DataUserLocal
                                                .DriverAccountData[0]
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

                                    //OtpEmile.sendOtp(UserAccountData[0][UserTextTable.EMAILE_TEXT]);

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

  Future<void> sendMassege() async {
    /* final Email email = Email(
      body: "_bodyController.text",
      subject: " _subjectController.text",
      recipients: ['abualbraa.alyemeni@gmail.com'],
        cc: ['abualbraa.alyemeni@gmail.com'],
        bcc: ['abualbraa.alyemeni@gmail.com'],
        attachmentPaths: ['/path/to/attachment.zip'],
        isHTML: false
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';

      print(platformResponse);
    } catch (error) {
      platformResponse = error.toString();

      print(platformResponse);
    }



  print(platformResponse);
    if (!mounted) return;*/

    String username = 'ialzoriqi@gmail.com';
    String password = '';

    // _scaffoldKey.currentState.showBodyScrim(true,0.5
  }
}

class UserProfilePage extends StatelessWidget {
  final String _fullName = "Nick Frost";
  final String _status = "Software Developer";
  final String _bio =
      "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";
  final String _followers = "173";
  final String _posts = "24";

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/menuSlider0.JPG'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/person.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        //  "Get in Touch with ${_fullName.split(" ")[0]},",
        " ",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print("followed"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "FOLLOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print("Message"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESSAGE",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  buildFullName(
                    fullName: _fullName,
                  ),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
