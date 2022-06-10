import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:school_ksa/lib/ApiProvider/ApiSchool.dart';
import 'package:school_ksa/lib/ApiProvider/api_driver_buses.dart';
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Widget/dropdown_below_widget.dart';

import 'Proplem.dart';

class AddLocationProplemScreen extends StatefulWidget {
  @override
  _AddLocationProplemScreenPageState createState() =>
      _AddLocationProplemScreenPageState();
}

class _AddLocationProplemScreenPageState
    extends State<AddLocationProplemScreen> {
  int _counter = 0;
  var location;

  List dataImage = [];
  MediaPage imagePage;
  List<Album> imageAlbumss;
  List<Medium> allMedia;
  List<File> allPathImage = [];
  File file;
  List<Album> _albums;
  bool _loading = false;

  List<Medium> _media;

  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.42291670082779, 39.82589776995795),
    zoom: 11.4746,
  );

  var coordinates;

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

  var _valuseChoseTetcher = null;
  List<DropdownMenuItem<Object>> _dropdownTestItems = [];
  List<DropdownMenuItem<Object>> _dropdownTetcherItems = [];
  var _selectedTest;
  var _selectedTetcher;

  DriverBusesApiProvider driverbusis;

  onChangeDropdownTetcher(selectedTetcher) {
    //PRINT(selectedTetcher);
    setState(() {
      _selectedTetcher = selectedTetcher;

      _valuseChoseTetcher = selectedTetcher['no'];
    });

    DataScoolAndDriverChooseLocal.addDriverChooseToRefrences(
        selectedTetcher['no'], selectedTetcher['keyword']);
    DataScoolAndDriverChooseLocal.getDriverIdFromRefrences();
    DataScoolAndDriverChooseLocal.getDriverNameFromRefrences();
    DataScoolAndDriverChooseLocal.getSchooIdFromRefrences();
    DataScoolAndDriverChooseLocal.getSchooNameFromRefrences();

    if (DataScoolAndDriverChooseLocal.getDriverIdFromRefrences() != null &&
        DataScoolAndDriverChooseLocal.getDriverNameFromRefrences() != null &&
        DataScoolAndDriverChooseLocal.getSchooIdFromRefrences() != null &&
        DataScoolAndDriverChooseLocal.getSchooNameFromRefrences() != null) {
      //   Navigator.of(context)
      //       .pushReplacement(MaterialPageRoute(builder: (ctx) => AddLocationProplemScreen()));
      // }
    }
  }

  var _valuseChoseChhool = null;

  onChangeDropdownTests(selectedTest) async {
    setState(() {
      _selectedTest = selectedTest;

      _valuseChoseChhool = selectedTest['no'];

      DataScoolAndDriverChooseLocal.addSchooLToRefrences(
          selectedTest['no'], selectedTest['keyword']);
      DataScoolAndDriverChooseLocal.getSchooIdFromRefrences();
      DataScoolAndDriverChooseLocal.getSchooNameFromRefrences();
    });

    fetchAllDriver(selectedTest['no']);
    // fetchAllschool();
  }

  List<DropdownMenuItem> buildDropdownTetcherItems(List _testList) {
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

  DBProviderUser DB;
  List _tetcherList = [
    // {'no': 1, 'keyword': 'مدرسة الباحة'},
    // {'no': 2, 'keyword': 'مدرسة الرياض'},
    // {'no': 3, 'keyword': 'مدرسة جدة'}
  ];
  List _testList = [
    // {'no': 1, 'keyword': 'مدرسة الباحة'},
    // {'no': 2, 'keyword': 'مدرسة الرياض'},
    // {'no': 3, 'keyword': 'مدرسة جدة'}
  ];

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

  fetchAllDriver(int _valuseChoseChhool) async {
    var testListTetcherNo = [];
    var selectedTest;

    setState(() {
      _tetcherList.clear();
      testListTetcherNo.clear();
      Data.dataDriverBusesinSchool = [];
      _selectedTetcher = null;
    });

    driverbusis = await new DriverBusesApiProvider();
    Data.dataDriverBusesinSchool =
        await driverbusis.fechAllDriverBusesInSchool(_valuseChoseChhool);
    //PRINT(Data.dataDriverBusesinSchool);
    if (Data.dataDriverBusesinSchool.length > 0)
      for (int i = 0; i < Data.dataDriverBusesinSchool.length; i++) {
        testListTetcherNo.add({
          "no": Data.dataDriverBusesinSchool[i].id,
          "keyword": Data.dataDriverBusesinSchool[i].Full_Name,
        });
      }

    setState(() {
      Data.dataDriverBusesinSchool = Data.dataDriverBusesinSchool;
      _tetcherList = testListTetcherNo;
      _dropdownTetcherItems = buildDropdownTetcherItems(_tetcherList);
      _selectedTetcher = selectedTest;

      //PRINT(Data.dataSchool);
    });

    _tetcherList.clear();
    testListTetcherNo.clear();

    // _tetcherList.clear();
    // testListNo.clear();

    //Data.dataDriverBusesinSchool=[];
  }

  buildChooseSchoolAndBisesDriver() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        textDirection: TextDirection.rtl,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: DropdownBelowWidget(
              tital: "اختر المدرسة",
              selectedTest: _selectedTest,
              dropdownTestItems: _dropdownTestItems,
              onChangeDropdownTests: onChangeDropdownTests,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: DropdownBelowWidget(
              tital: "اختر السائق",
              selectedTest: _selectedTetcher,
              dropdownTestItems: _dropdownTetcherItems,
              onChangeDropdownTests: onChangeDropdownTetcher,
            ),
          )
        ],
      ),
    );
  }

  double height = 0.0;
  double width = 0.0;

  @override
  initState() {
    // initAsync();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      height = _globalKey.currentContext.size.height;
      width = _globalKey.currentContext.size.width;
      //PRINT('the new height is $height');
      setState(() {});
    });
    super.initState();

    _loading = true;

    if (_valuseChoseChhool == null) fetchAllschool();
    getlocation();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var addresses;
  var addresesLan;

  var first;
  double lat;
  double long;
  int i = 0;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000;

  CountdownTimerController controller;

  void onEnd() {
    setState(() {
      first = addresses.first;

      //PRINT(i);
      i += 1;

      // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
    });

    //PRINT('onEnd');
  }

  int _start = 10;
  int _current = 10;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer();
  }

  Widget _buildProfileImage() {
    return Container(
      height: height,
      width: width,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70.0,
              height: 70.0,
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
            Column(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "My Bus",
                  style: (TextStyle(
                    color: ColorAPP.backgroundColor,
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "MyBus@MyBus.com",
                  style: (TextStyle(
                    color: ColorAPP.backgroundColor,
                  )),
                ),
              ],
            ),
          ]),
    );
  }

  Set<Marker> _markers = {};
  setMarkser(lat, long) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("id"),
        // a string for marker unique id
        icon: BitmapDescriptor.defaultMarker,
        // options for hues and custom imgs
        position: LatLng(lat, long),
      ));
    });
  }

  GlobalKey _globalKey = GlobalKey();
  bool isAdd = false;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _kGooglePlex = _kGooglePlex;
    });
    //PRINT(i);

    if (DataScoolAndDriverChooseLocal.getDriverIdFromRefrences() == null &&
        DataScoolAndDriverChooseLocal.getDriverNameFromRefrences() == null &&
        DataScoolAndDriverChooseLocal.getSchooIdFromRefrences() == null &&
        DataScoolAndDriverChooseLocal.getSchooNameFromRefrences() == null) {
      return Center(
          child: CircularProgressIndicator(
              backgroundColor: ColorAPP.colorWhite,
              valueColor: AlwaysStoppedAnimation<Color>(ColorAPP.lightGreen)));
    } else
      //getlocation();

      // This method is rerun every time setState is called, for instance as done
      // by the _incrementCounter method above.
      //
      // The Flutter framework has been optimized to make rerunning build methods
      // fast, so that you can just rebuild anything that needs updating rather
      // than having to individually change instances of widgets.
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                initialCameraPosition: _kGooglePlex,
                markers: _markers,
                onTap: (latlong) {
                  setState(() {
                    lat = latlong.latitude;
                    long = latlong.longitude;

                    setMarkser(latlong.latitude, latlong.longitude);
                    isAdd = true;
                  });
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),

            Align(
              alignment: Alignment(0.0, 0.9),
              child: Container(
                  height: 50,
                  // color: ColorAPP.lightGreen,
                  width: 120,
                  decoration: BoxDecoration(
                    color: ColorAPP.lightGreen,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ColorAPP.lightGreen.withOpacity(0.8),
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: Row(children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: ColorAPP.lightGreen,
                          onSurface: ColorAPP.BlackColor,
                        ),
                        onPressed: () {
                          if (lat != null && long != null)
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (ctx) => AddProblemScreen(
                                          lat: lat,
                                          long: long,
                                        )));
                          else {
                            Fluttertoast.showToast(
                                msg: "الرجاء قم بأختيار موقع",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: ColorAPP.lightGreen,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_location_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              "تاكيد الموقع ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        )),
                  ])),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ]),
        ),
      );
  }
}
