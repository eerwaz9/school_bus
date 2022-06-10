import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:geocoder/geocoder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:school_ksa/lib/ApiProvider/ApiSchool.dart';
import 'package:school_ksa/lib/ApiProvider/api_proplem.dart';
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/Problem.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Widget/date_time_picker.dart';
import 'package:school_ksa/lib/Widget/text_field_card.dart';
import 'package:school_ksa/lib/appColors/app_colors.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';
import 'AddLocation.dart';
import 'HomeDriver.dart';

class AddProblemScreen extends StatefulWidget {
  double lat;

  double long;
  AddProblemScreen({this.lat, this.long});
  _AddProblemScreenState createState() => _AddProblemScreenState();
}

class _AddProblemScreenState extends State<AddProblemScreen> {
  File _image;

  Future _getImage() async {
    //var image = await ImagePicker.(source: ImageSource.gallery);
    setState(() {
      //  _image = image;
    });
  }

  final picker = ImagePicker();

  List<DropdownMenuItem<Object>> _dropdownTestItems = [];
  var _selectedTest;

  onChangeDropdownTests(selectedTest) {
    //PRINT(selectedTest);
    setState(() {
      _selectedTest = selectedTest;

      _valuseChoseChhool = selectedTest['no'];
    });
  }

  var _valuseChoseChhool = null;

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem> items = List();
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  var image;

  var pickedFile;

  Future getImage(int i) async {
    //PRINT('No image selected.${i}');
    //var image = await picker.getImage(source: imageSource, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);

    pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        //PRINT('No image selected.');
      }
    });
  }

  int groupValue = 1;

  Completer<GoogleMapController> _controller = Completer();

  // double lattude=widget.lat!=null?21.42291670082779 : widget.lat ;

  CameraPosition _kGooglePlex() {
    return CameraPosition(
      target: LatLng(widget.lat == null ? 21.42291670082779 : widget.lat,
          widget.long == null ? 39.82589776995795 : widget.long),
      zoom: 10.4746,
    );
  }
  // static  CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(widget.lat!=null?21.42291670082779 : widget.lat;==null?21.42291670082779, 39.82589776995795),
  //   zoom: 10.4746,
  // );

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
  var apiKey = "AIzaSyBOnp_PY0tImyFRmPa62MgLlfFt5TP2doM";

  String Name_Location = "ضتايت";
  getlocation() async {
    coordinates = new Coordinates(lat, long);
    // addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    addresses = await Geocoder.google(apiKey, language: "Ar")
        .findAddressesFromCoordinates(coordinates);
    setState(() {
      first = addresses;
      location = first;
      Name_Location = addresses == null || addresses.length <= 0
          ? " NULL "
          : "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].adminArea}, ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subAdminArea},"
              " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryCode} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine},  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,"
              " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode}  , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality} , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subLocality}";
      setState(() {
        Name_Location = addresses == null || addresses.length <= 0
            ? " NULL "
            : "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].adminArea}, ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subAdminArea},"
                " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryCode} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine},  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,"
                " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode}  , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality} , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subLocality}";
        if (Name_Location == null) Name_Location = " Null Null Null ";
        print(Name_Location);
        print(widget.lat);
        print(widget.long);

        first = addresses;
        location = first;

        // first = addresses.first;
        // //PRINT(i);

        // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
      });
    });
  }

  Widget Map() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => AddLocationProplemScreen()));
      },
      child: Card(
        child: Stack(children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => AddLocationProplemScreen()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.2,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex(),
                onCameraMove: ((pinPosition) async {
                  lat = pinPosition.target.latitude;
                  long = pinPosition.target.longitude;
                  //PRINT(lat);
                  //PRINT(long);
                  //PRINT(pinPosition.tilt);
                  coordinates = new Coordinates(lat, long);
                  addresses = await Geocoder.local
                      .findAddressesFromCoordinates(coordinates);

                  first = addresses.first;
                  i += 1;
                  i == 1
                      ? setState(() {
                          first = addresses.first;
                          //PRINT(i);

                          // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
                        })
                      : first = addresses.first;
                  i == 10
                      ? setState(() {
                          first = addresses.first;
                          i = 0;
                          //PRINT(i);

                          // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
                        })
                      : first = addresses.first;

                  // onEnd();
                  // controller.start();

                  /*  //PRINT("${first.featureName == null ? " " : first.featureName} : ${first.addressLine}");
                        //PRINT("${first.countryName == null ? " " : first.countryName } : ${first.locality}");
                        //PRINT("${first.featureName} : ${first.locality}");
*/
                }),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.2,
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
    );
  }

  Widget CheekBoox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GFRadio(
                  size: GFSize.LARGE,
                  activeBorderColor: ColorAPP.lightGreen,
                  value: 0,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                      //PRINT(groupValue);
                    });
                  },
                  inactiveIcon: null,
                  radioColor: ColorAPP.lightGreen,
                ),
                SizedBox(
                  width: 10,
                ),
                GFButton(
                  onPressed: null,
                  text: "نعم",
                  color: ColorAPP.lightGreen,
                  shape: GFButtonShape.square,
                  type: GFButtonType.transparent,
                ),
              ]),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
              GFRadio(
                size: GFSize.LARGE,
                value: 1,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value;
                    //PRINT(groupValue);
                  });
                },
                inactiveIcon: null,
                activeBorderColor: ColorAPP.lightGreen,
                radioColor: ColorAPP.lightGreen,
              ),
              SizedBox(
                width: 10,
              ),
              GFButton(
                onPressed: null,
                text: "لا",
                color: ColorAPP.lightGreen,
                shape: GFButtonShape.square,
                type: GFButtonType.transparent,
              ),
            ]))
      ],
    );
  }

  DBProviderUser db = new DBProviderUser();
  ProplemApiProvider ProplemApi;

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  _printLatestValue() {}

  getdataaccount() async {
    UserAccountData = await DB.fetchUserAccount();
    if (UserAccountData.length > 0) {
      setState(() {
        //PRINT(UserAccountData.length);
      });
    }
  }

  List _testList = [
    // {'no': 1, 'keyword': 'مدرسة الباحة'},
    // {'no': 2, 'keyword': 'مدرسة الرياض'},
    // {'no': 3, 'keyword': 'مدرسة جدة'}
  ];
  DBProviderUser DB;
  SchoolApiProvider schoolapi;

  fetchAllschool() async {
    var testListNo = [];
    var testListkeyword = [];

    if (Data.dataSchool.length > 0) {
      for (int i = 0; i < Data.dataSchool.length; i++) {
        testListNo.add({
          "no": Data.dataSchool[i].id,
          "keyword": Data.dataSchool[i].School_Name,
        });
      }

      setState(() {
        Data.dataSchool = Data.dataSchool;
        _testList = testListNo;

        _dropdownTestItems = buildDropdownTestItems(_testList);

        //PRINT(Data.dataSchool);
      });

      _testList.clear();
      testListNo.clear();
    }
    schoolapi = new SchoolApiProvider();
    Data.dataSchool = await schoolapi.fechAllSchool();
    // _testList.setRange(0,Data.dataSchool.length,Data.dataSchool);
    for (int i = 0; i < Data.dataSchool.length; i++) {
      testListNo.add({
        "no": Data.dataSchool[i].id,
        "keyword": Data.dataSchool[i].School_Name,
      });
    }

    setState(() {
      Data.dataSchool = Data.dataSchool;
      _testList = testListNo;

      _dropdownTestItems = buildDropdownTestItems(_testList);

      //PRINT(Data.dataSchool);
    });

    _testList.clear();
    testListNo.clear();
  }

  @override
  initState() {
    fetchAllschool();
    getInfoDivice.getDeviceDetails();
    DataUserLocal.getdataaccount();
    super.initState();
    //_dropdownTestItems = buildDropdownTestItems(_testList);
    getlocation();
    ProplemApi = new ProplemApiProvider();

    DB = new DBProviderUser();
    getdataaccount();
  }

  bool _obscureText = true;
  String _username, _proplemTitel, _dateTimeSolveProplem;
  bool _isSubmitting;
  bool _isVrifyOtp = false;
  final _formKey = GlobalKey<FormState>();
  final DateTime timestamp = DateTime.now();
  Color colorIcon = ColorAPP.lightGreen;
  bool visablebassowrd = true;
  Icon iconVisableandnonvisable = Icon(Icons.visibility);
  bool checkforconvortImage = true;
  final ProplemController = TextEditingController();
  final DateTimeSolveProplemController = TextEditingController();

  final userNamedController = TextEditingController();
  final phoneNoController = TextEditingController();

  String _phoneNoWithKey = null;

  double pi = 3.1415926535897932;
  PhoneNumber number = PhoneNumber(isoCode: 'SA');

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'SA');

    setState(() {
      this.number = number;
    });
  }

  bool onTapState = false;
  bool toggleState = false;
  static const Color colorRed = Colors.red;
  static const Color colorGreen = Color(0xfff6f6f6);

  void _handleTap(bool newState) {
    setState(() {
      onTapState = newState;
    });
  }

  void _handleToggle() {
    setState(() {
      toggleState = !toggleState;
    });
  }

  final _styledBox = ({
    @required Widget child,
    @required bool tapState,
    @required bool toggleState,
  }) =>
      child
          .padding(all: 10)
          .constrained(height: 50, width: 90)
          .ripple(splashColor: Colors.white.withOpacity(0.1))
          .clipRRect(all: 30)
          .decorated(
            color: toggleState ? colorGreen : ColorAPP.lightGreen,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: toggleState
                    ? ColorAPP.lightGreen.withOpacity(0.3)
                    : ColorAPP.lightGreen.withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 15),
              ),
            ],
            animate: true,
          )
          .scale(all: tapState ? 0.95 : 1, animate: true);

  final _styledOuterCircle = ({
    @required Widget child,
    @required bool toggleState,
  }) =>
      child
          .decorated(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          )
          .constrained(width: toggleState ? 10 : 30, height: 30, animate: true)
          .padding(right: toggleState ? 10 : 0, animate: true)
          .alignment(
            toggleState ? Alignment.centerRight : Alignment.centerLeft,
            animate: true,
          );

  final _styledInnerCircle = ({
    @required bool toggleState,
  }) =>
      Styled.widget()
          .decorated(
            color: toggleState ? colorGreen : ColorAPP.lightGreen,
            borderRadius: BorderRadius.circular(6),
            animate: true,
          )
          .constrained(width: toggleState ? 0 : 12, height: 12, animate: true)
          .alignment(Alignment.center);

  Widget Togle(BuildContext context) {
    return _styledInnerCircle(toggleState: toggleState)
        .parent(({Widget child}) =>
            _styledOuterCircle(child: child, toggleState: toggleState))
        .parent(({Widget child}) => _styledBox(
            child: child, tapState: onTapState, toggleState: toggleState))
        .gestures(onTapChange: _handleTap, onTap: _handleToggle)
        .alignment(Alignment.center)
        //     .backgroundColor(
        //   toggleState ? ColorAPP.lightGreen : Color(0xffF7EEEE),
        //   animate: true,
        // )
        .animate(Duration(milliseconds: 300), Curves.easeOut);
  }

  var datenow = new DateTime.now();
  List UserAccountData;

  Widget build(BuildContext context) {
    // TODO: implement build

    return new Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          key: _scaffoldKey,
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
                    child: SingleChildScrollView(
                      dragStartBehavior: DragStartBehavior.down,
                      child: Form(
                        key: _formKey,
                        child: Container(
                            // height: MediaQuery.of(context).size.height+30,
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
                                SizedBox(
                                  height: 5,
                                ),
                                TextInputTextCard(
                                  labelTxt: "ماهي المشكلة",
                                  hintTxt: "أدخل المشكلة",
                                  textinputaction: TextInputAction.done,
                                  isPassword: false,
                                  controller: this.ProplemController,
                                  iconsTextFild: Icon(
                                    Icons.person,
                                    color: colorIcon,
                                  ),
                                  textinputtype: TextInputType.text,
                                  inputFormatter: [],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: 0,
                                          left: 10,
                                          right: 10,
                                          top: 0),
                                      child: Text(
                                        "هل تم اصلاح المشكلة",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: ColorAPP.lightGreen,
                                            decorationColor:
                                                ColorAPP.lightGreen),
                                      ),
                                    ),
                                    CheekBoox(),
                                  ],
                                ),
                                groupValue == 0
                                    ? BasicDateTimeField(
                                        labelTxt: "  وقت اصلاح المشكلة",
                                        hintTxt: "قم بأدخال وقت اصلاح المشكلة",
                                        textinputaction: TextInputAction.done,
                                        controller:
                                            this.DateTimeSolveProplemController,
                                        iconsTextFild: Icon(
                                          Icons.date_range,
                                          color: colorIcon,
                                        ),
                                        textinputtype: TextInputType.datetime)
                                    : Container(),
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 0, left: 10, right: 10, top: 0),
                                  child: Text(
                                    "اختار موقع حدوث المشكلة",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: ColorAPP.lightGreen,
                                        decorationColor: ColorAPP.lightGreen),
                                  ),
                                ),
                                Map(),
                                Container(
                                    child: Container(
                                  margin: EdgeInsets.all(15),
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
                                  child: TextButton(
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.focused))
                                          return Colors.red;
                                        if (states
                                            .contains(MaterialState.hovered))
                                          return Colors.green;
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
                                          Icons.report_problem,
                                          color: Colors.white,
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.only(left: 15)),
                                        Text(
                                          "نشر المشكلة",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    onPressed: () async {
                                      await getlocation();
                                      String Message = "";
                                      String getRondom = getRandomString(27);

                                      _proplemTitel =
                                          ProplemController.value.text;
                                      _dateTimeSolveProplem =
                                          DateTimeSolveProplemController
                                              .value.text;
                                      _username =
                                          userNamedController.value.text;

                                      // SnackBarShow();
                                      if (_proplemTitel.isEmpty ||
                                          _proplemTitel == null) {
                                        //  SnackBarShow();
                                        Message = "أدخل تفاصيل امشكلة ";
                                        //  showInSnackBar(Message);
                                        showInSnackBar(Message);
                                      } else if (_dateTimeSolveProplem
                                              .isEmpty ||
                                          _dateTimeSolveProplem == null) {
                                        Message = "أدخل تاريخ حل المشكلة  ";
                                        //  showInSnackBar(Message);
                                        showInSnackBar(Message);
                                      } else if (Name_Location == null) {
                                        Message = "أدخل بتحديد الموقع  ";
                                        //  showInSnackBar(Message);
                                        showInSnackBar(Message);
                                      } else if (widget.lat == null) {
                                        Message = "أدخل بتحديد الموقع  ";
                                        showInSnackBar(Message);
                                      } else if (widget.long == null) {
                                        Message = "قم بتحديد الموقع  ";
                                        showInSnackBar(Message);
                                      } else {
                                        Proplem newProplemApi = new Proplem(
                                            Couse: ProplemController.value.text,
                                            Name_Location: Name_Location,
                                            Driver:
                                                "https://mubus.pythonanywhere.com/api/v1/DriverBus/${await DataUserLocal.getIdDriverFromDataBase()}/",
                                            latitude: widget.lat,
                                            Solved_the_problem: true,
                                            Data_Solved_The_Problem:
                                                DateTimeSolveProplemController
                                                    .value.text,
                                            IMEI_device:
                                                getInfoDivice.identifier,
                                            longitude: widget.long);

                                        Proplem Messages =
                                            await ProplemApi.addProplem(
                                                newProplemApi);

                                        print(Messages.Name_Location);
                                        print(Messages.longitude);
                                        print(Messages.latitude);
                                        //var jdsjd=await  db.newUser(newUserDB);

                                        if (Messages != null) {
                                          setState(() {
                                            _isSubmitting = true;
                                          });
                                        }
                                        if (Messages != null) {
                                          Message = "تم أنشاء المشكلة   ";

                                          // OtpEmile.sendOtp(EmileController.value.text);

                                          showInSnackBar(Message);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      HomeDriverScrean(
                                                          /* Full_Name:  FullNameController.value.text,
                                                  id:  4545,
                                                  Date_Added: datenow,
                                                      IMEI_device: 2,
                                                      password: PassowrdController.value.text,
                                                      Data_Update: datenow,
                                                      Email: EmileController.value.text,
                                                      images_user: null,
                                                      isVerify: false,
                                                      keyVerify: "",
                                                      KeyActiveStatus: true,
                                                      session_no: getRandomString(27),
                                                      PhoneNo: phoneNoController.value.text,
                                                      UserName: userNamedController.value.text,*/

                                                          )));
                                        }
                                        showInSnackBar(Message);
                                      }

                                      /*       var alluser =db.  getAllInLocaParent();
                                            for(int i=0;i<=alluser;i++){
                                              print(alluser[i]);
                                            }*/

                                      //  _submit();

                                      // _supmate(context,EmileController.value.toString(),PassowrdController.value.toString());
                                    },
                                  ),
                                ))
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  BuildContext scaffoldContext;

/*
  void createSnackBar(String message) {
    final snackBar = new SnackBar(content: new Text(message),
        backgroundColor: ColorAPP.lightGreen);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }
*/

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  List<TextInputFormatter> UserinputFormatters = [
    FilteringTextInputFormatter.deny(' ', replacementString: ''),
    FilteringTextInputFormatter.deny('ا', replacementString: ''),
    FilteringTextInputFormatter.deny('أ', replacementString: ''),
    FilteringTextInputFormatter.deny('ب', replacementString: ''),
    FilteringTextInputFormatter.deny('ت', replacementString: ''),
    FilteringTextInputFormatter.deny('ث', replacementString: ''),
    FilteringTextInputFormatter.deny('ج', replacementString: ''),
    FilteringTextInputFormatter.deny('ح', replacementString: ''),
    FilteringTextInputFormatter.deny('خ', replacementString: ''),
    FilteringTextInputFormatter.deny('د', replacementString: ''),
    FilteringTextInputFormatter.deny('ذ', replacementString: ''),
    FilteringTextInputFormatter.deny('ر', replacementString: ''),
    FilteringTextInputFormatter.deny('ز', replacementString: ''),
    FilteringTextInputFormatter.deny('س', replacementString: ''),
    FilteringTextInputFormatter.deny('ش', replacementString: ''),
    FilteringTextInputFormatter.deny('ص', replacementString: ''),
    FilteringTextInputFormatter.deny('ض', replacementString: ''),
    FilteringTextInputFormatter.deny('ط', replacementString: ''),
    FilteringTextInputFormatter.deny('ض', replacementString: ''),
    FilteringTextInputFormatter.deny('ع', replacementString: ''),
    FilteringTextInputFormatter.deny('غ', replacementString: ''),
    FilteringTextInputFormatter.deny('ف', replacementString: ''),
    FilteringTextInputFormatter.deny('ق', replacementString: ''),
    FilteringTextInputFormatter.deny('ك', replacementString: ''),
    FilteringTextInputFormatter.deny('ل', replacementString: ''),
    FilteringTextInputFormatter.deny('م', replacementString: ''),
    FilteringTextInputFormatter.deny('ن', replacementString: ''),
    FilteringTextInputFormatter.deny('ه', replacementString: ''),
    FilteringTextInputFormatter.deny('و', replacementString: ''),
    FilteringTextInputFormatter.deny('ي', replacementString: ''),
  ];

//6

//7

//When User "Signed Up", success snack will display.
  _showSuccessSnack(String message) {
    final snackbar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        "$message",
        style: TextStyle(color: Colors.green),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
/*    await Navigator.of(context).push(MaterialPageRoute
      (builder: (context) =>
        ProfilePage(

        )));*/
  }

//When FirebaseAuth Catches error, error snack will display.
  _showErrorSnack(String message) {
    final snackbar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        "$message",
        style: TextStyle(color: Colors.red),
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  var snackBar;

  SnackBarShow() {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildButtonProfileImage(BuildContext context) {
    return InkWell(
      // style: ButtonStyle(
      //   foregroundColor: MaterialStateProperty(Color(0xFF697D9C)),
      // ),

      onTap: () {
        getImage(2);
      },

      // onTap: (){
      //
      //
      //
      //Navigator.of(context,rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (ctx) =>
      // mainCityListPage(HaveAccount:HaveAccount)));
      // },
      child: Container(
          color: Colors.white,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              color: Colors.brown,
              shadowColor: Color(0xFF442E2E),
              child: InkWell(
                // style: ButtonStyle(
                //   foregroundColor: MaterialStateProperty(Color(0xFF697D9C)),
                // ),

                onTap: () {
                  getImage(3);
                },

                child: _image == null
                    ? Image.asset(
                        "assets/images/person.jpg",
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ),
              ))),
    );
  }

  addToRefrence() async {
    DB = await new DBProviderUser();

    List UserAccountData = await DB.fetchUserAccount();

    print("list.length   list.length  list.length list.length ");

    print(UserAccountData.length);
    if (UserAccountData.length > 0) {
      // print("User Data : ${UserAccountData}");
      // print("User Data : ${UserAccountData[0]['id']}");
      //
      // print("ID : ${UserAccountData[0][UserTextTable.ID_USER_TEXT]}");
      // print("Full_Name : ${UserAccountData[0][UserTextTable.FULL_NAME_TEXT]}");
      // print("UserName : ${UserAccountData[0][UserTextTable.USERNAME_TEXT]}");
      // print("password : ${UserAccountData[0][UserTextTable.PASSWORD_TEXT]}");
      // print("KEY_VERIFY_TEXT : ${UserAccountData[0][UserTextTable.KEY_VERIFY_TEXT]}");
      //
      // print("Data : ${DB.fetchUserAccount()}");

      sharedPrefInit(
          true,
          true,
          UserAccountData[0][UserTextTable.EMAILE_TEXT],
          UserAccountData[0][UserTextTable.SEESION_TEXT],
          UserAccountData[0][UserTextTable.FULL_NAME_TEXT],
          UserAccountData[0][UserTextTable.PASSWORD_TEXT],
          UserAccountData[0][UserTextTable.PHONE_NO_TEXT],
          UserAccountData[0][UserTextTable.IMEI_device_TEXT],
          UserAccountData[0][UserTextTable.KEY_VERIFY_TEXT],
          UserAccountData[0][UserTextTable.USERNAME_TEXT],
          UserAccountData[0][UserTextTable.ID_USER_TEXT]);
      prefs.setBool("HaveAccount", true);
      prefs.setBool(UserTextTable.IS_VERIFY_TEXT, true);
      prefs.setString(UserTextTable.EMAILE_TEXT,
          UserAccountData[0][UserTextTable.EMAILE_TEXT]);

      prefs.setString(UserTextTable.SEESION_TEXT,
          UserAccountData[0][UserTextTable.SEESION_TEXT]);
      prefs.setString(UserTextTable.FULL_NAME_TEXT,
          UserAccountData[0][UserTextTable.FULL_NAME_TEXT]);
      prefs.setString(UserTextTable.PASSWORD_TEXT,
          UserAccountData[0][UserTextTable.PASSWORD_TEXT]);
      prefs.setString(UserTextTable.PHONE_NO_TEXT,
          UserAccountData[0][UserTextTable.PHONE_NO_TEXT]);

      prefs.setString(UserTextTable.KEY_VERIFY_TEXT,
          UserAccountData[0][UserTextTable.KEY_VERIFY_TEXT]);
      prefs.setString(UserTextTable.USERNAME_TEXT,
          UserAccountData[0][UserTextTable.USERNAME_TEXT]);
      prefs.setInt(UserTextTable.ID_USER_TEXT,
          UserAccountData[0][UserTextTable.ID_USER_TEXT]);
      prefs.setString(UserTextTable.IMEI_device_TEXT,
          UserAccountData[0][UserTextTable.IMEI_device_TEXT]);

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
    } else {
      prefs.setBool("HaveAccount", false);
      sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
    }
  }
}
