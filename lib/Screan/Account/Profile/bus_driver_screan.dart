import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Widget/buildStatItemUserName.dart';
import 'package:school_ksa/lib/Widget/build_profile_image.dart';
import 'package:school_ksa/lib/appColors/app_colors.dart';

import '../../home.dart';

class ProfileBusDriverScreen extends StatefulWidget {
  @override
  _ProfileBusDriverScreenState createState() => _ProfileBusDriverScreenState();
}

class _ProfileBusDriverScreenState extends State<ProfileBusDriverScreen> {
  String _fullName;
  String _status;
  String _bio;
  String SchoolName = " ";
  String _followers;

  String _posts;

  String _username;

  MySharedPreferences MSharedPreferences = new MySharedPreferences();

  Future<List> datauser;
  String Messege;

  int IS_VERIFY_TEXT = 0;
  int linghUser = 0;
  int linghDriver = 0;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.42291670082779, 39.82589776995795),
    zoom: 10.4746,
  );

  var coordinates;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var addresses;
  var addresesLan;

  var first;
  double lat = 21.420525330514568;
  double long = 39.82268717139959;
  int i = 0;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000;
  var location;
  CountdownTimerController controller;

  getlocation() async {
    coordinates = new Coordinates(lat, long);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    //addresses=await Geocoder.google("AIzaSyBOnp_PY0tImyFRmPa62MgLlfFt5TP2doM",language: "Ar").findAddressesFromCoordinates(coordinates);
    setState(() {
      first = addresses.first;
      location = first;

      setState(() {
        first = addresses.first;
        location = first;

        // first = addresses.first;
        // //PRINT(i);

        // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
      });
    });
  }

  addSchoolName() async {
    if (await DataScoolAndDriverChooseLocal.getSchooNameFromRefrences() !=
        null) {
      SchoolName =
          await DataScoolAndDriverChooseLocal.getSchooNameFromRefrences();
      setState(() {
        SchoolName = SchoolName;
      });
    } else {
      await DataUserLocal.getdataaccount();
      if (DataUserLocal.DriverAccountData[0][DriverBusesTextTable.School_TEXT])
        setState(() {
          SchoolName = DataUserLocal.DriverAccountData[0]
              [DriverBusesTextTable.School_TEXT];
        });
      else {
        setState(() {
          SchoolName = SchoolName;
        });
      }
    }
  }

  initState() {
    addSchoolName();
    // TODO: implement initState
    super.initState();
    addSchoolName();
    DataUserLocal.getdataaccount();

    if (DataUserLocal.isDriver) {
      _fullName = DataUserLocal.DriverAccountData[0]
          [DriverBusesTextTable.FULL_NAME_TEXT];
      _status = DataUserLocal.DriverAccountData[0]
          [DriverBusesTextTable.FULL_NAME_TEXT];
      _bio = "Ibrahim Alzoriqi";
      _followers = "+966 532270314";
      _username = "MyBus";
      _posts = "MyBus@MyBus.com";
      IS_VERIFY_TEXT = 1;
      _status = " ";
      _bio = " ";
    } else {
      _fullName = "Ibrahim Alzoriqi";
      _status = "+966 532270314";
      _bio = "Ibrahim Alzoriqi";
      _followers = "+966 532270314";
      _username = "MyBus";
      _posts = "MyBus@MyBus.com";
      IS_VERIFY_TEXT = 1;
      _status = " ";
      _bio = " ";
    }
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
        //PRINT(DataUserLocal.UserAccountData[0][UserTextTable.SEESION_TEXT]);
        //PRINT(DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT]);
        //PRINT(DataUserLocal.UserAccountData[0][UserTextTable.SEESION_TEXT]);
        //PRINT(DataUserLocal.UserAccountData[0][UserTextTable.IMAGES_USER_TEXT]);
        //PRINT(DataUserLocal.UserAccountData[0][UserTextTable.IS_VERIFY_TEXT]);
        //PRINT(DataUserLocal.UserAccountData[0][UserTextTable.KEY_VERIFY_TEXT]);
      }
      if (linghDriver > 0) {
        //PRINT(DataUserLocal.DriverAccountData[0]
        // [DriverBusesTextTable.SEESION_TEXT]);
        //PRINT(DataUserLocal.DriverAccountData[0]
        // [DriverBusesTextTable.EMAILE_TEXT]);
        //PRINT(DataUserLocal.DriverAccountData[0]
        // [DriverBusesTextTable.SEESION_TEXT]);
        //PRINT(DataUserLocal.DriverAccountData[0]
        //   [DriverBusesTextTable.IMAGES_DriverBuses_TEXT]);
        //PRINT(DataUserLocal.DriverAccountData[0]
        // [DriverBusesTextTable.IS_VERIFY_TEXT]);
        //PRINT(DataUserLocal.DriverAccountData[0]
        //  [DriverBusesTextTable.KEY_VERIFY_TEXT]);
      }

      Messege = "تم أنشاء الحساب قم بتأكيد الأيميل";
    });
    //  createSnackBar("تم أرسال رقم التحقق الى الايميل");

    if (DataUserLocal.DriverAccountData.length > 0) {
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

        //PRINT(DataUserLocal.DriverAccountData.length);

        // //PRINT("User Data : ${UserAccountData}");
        // //PRINT("User Data : ${UserAccountData[0]['id']}");
        //
        // //PRINT("ID : ${UserAccountData[0][UserTextTable.ID_USER_TEXT]}");
        // //PRINT("Full_Name : ${UserAccountData[0][UserTextTable.FULL_NAME_TEXT]}");
        // //PRINT("UserName : ${UserAccountData[0][UserTextTable.USERNAME_TEXT]}");
        // //PRINT("password : ${UserAccountData[0][UserTextTable.PASSWORD_TEXT]}");
        // //PRINT("KEY_VERIFY_TEXT : ${UserAccountData[0][UserTextTable.KEY_VERIFY_TEXT]}");
        // //PRINT("IS_VERIFY_TEXT : ${UserAccountData[0][UserTextTable.IS_VERIFY_TEXT]}");
        //
        // //PRINT("Data : ${DB.fetchUserAccount()}");
      });
    }
    if (linghDriver > 0) {
      setState(() {
        _fullName = "Soft Eng : Ibrahim Alzoriqi";
        _status = "Sof Alzoriqi";
        _bio = "Ibrahim Alzoriqi";
        _followers = "+967 772703145";
        _username = "IAlzoriqi";
        _posts = "IAlzoriqi@gmail.com";
        IS_VERIFY_TEXT = 1;
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

        //PRINT(DataUserLocal.DriverAccountData.length);

        // //PRINT("User Data : ${UserAccountData}");
        // //PRINT("User Data : ${UserAccountData[0]['id']}");
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
                  BuildProfileImage(_username, _fullName),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  Map(),
                ],
              ),
            ),
          ),
        ],
      ),
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
      fontWeight: FontWeight.w400,
      //try changing weight to w500 if not thin
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
                      "سائق لمدرسة  " + SchoolName,
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

  Widget Map() {
    return Card(
      borderOnForeground: true,
      shadowColor: Colors.grey,
      child: SingleChildScrollView(
        child: InkWell(
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => HomeScrean())),
          child: Card(
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onCameraMove: ((pinPosition) async {
                    lat = pinPosition.target.latitude;
                    long = pinPosition.target.longitude;
                    print(lat);
                    print(long);
                    print(pinPosition.tilt);
                    coordinates = new Coordinates(lat, long);
                    addresses = await Geocoder.local
                        .findAddressesFromCoordinates(coordinates);

                    first = addresses.first;
                    i += 1;
                    i == 1
                        ? setState(() {
                            first = addresses.first;
                            print(i);

                            // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
                          })
                        : first = addresses.first;
                    i == 10
                        ? setState(() {
                            first = addresses.first;
                            i = 0;
                            print(i);

                            // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
                          })
                        : first = addresses.first;

                    // onEnd();
                    // controller.start();

                    /*  print("${first.featureName == null ? " " : first.featureName} : ${first.addressLine}");
                          print("${first.countryName == null ? " " : first.countryName } : ${first.locality}");
                          print("${first.featureName} : ${first.locality}");
*/
                  }),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              Center(
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: AppColors.baseDarkPinkColor,
                    ),
                    color: AppColors.baseDarkPinkColor,
                    iconSize: 40,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

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
}
