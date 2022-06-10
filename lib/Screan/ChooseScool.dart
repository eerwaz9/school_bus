import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_ksa/lib/ApiProvider/ApiSchool.dart';
import 'package:school_ksa/lib/ApiProvider/api_driver_buses.dart';
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Widget/dropdown_below_widget.dart';

import 'home.dart';

class ChooseSchoolScrean extends StatefulWidget {
  @override
  _ChooseSchoolScreanPageState createState() => _ChooseSchoolScreanPageState();
}

class _ChooseSchoolScreanPageState extends State<ChooseSchoolScrean> {
  int _counter = 0;
  var location;

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.42291670082779, 39.82589776995795),
    zoom: 14.4746,
  );

  // getlocation() async {
  //   final coordinates = new Coordinates(lat, long);
  //   addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   setState(() {
  //     first = addresses.first;
  //     location = first;
  //   });
  // }
  var _valuseChoseTetcher = null;
  List<DropdownMenuItem<Object>> _dropdownTestItems = [];
  List<DropdownMenuItem<Object>> _dropdownTetcherItems = [];
  var _selectedTest;
  var _selectedTetcher;

  DriverBusesApiProvider driverbusis;

  onChangeDropdownTetcher(selectedTetcher) {
    Data.dataLocationDriver = [];

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScrean()));

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
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder:
      //         (ctx) => HomeScrean(
      //
      //     )));
    }
  }

  var _valuseChoseChhool = null;
  onChangeDropdownTests(selectedTest) async {
    setState(() {
      _selectedTest = selectedTest;

      _valuseChoseChhool = selectedTest['no'];

      DataScoolAndDriverChooseLocal.addSchooLToRefrences(
          selectedTest['no'], selectedTest['keyword']);
      //DataScoolAndDriverChooseLocal.getSchooIdFromRefrences();
      // DataScoolAndDriverChooseLocal.getSchooNameFromRefrences();
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

  fetchSchool() async {
    schoolapi = new SchoolApiProvider();
    Data.dataSchool = await schoolapi.fechAllSchool();

    setState(() {
      Data.dataSchool = Data.dataSchool;
    });
  }

  SchoolApiProvider schoolapi;
  fetchAllschool() async {
    await fetchSchool();
    var testListNo = [];
    var testListkeyword = [];
    // schoolapi=new SchoolApiProvider();
    // Data.dataSchool= await schoolapi.fechAllSchool();
    schoolapi = new SchoolApiProvider();
    // Data.dataSchool= await schoolapi.fechAllSchool();

    setState(() {
      Data.dataSchool = Data.dataSchool;
      testListNo = testListNo;
    });
    if (Data.dataSchool.length > 0) {
      for (int i = 0; i < Data.dataSchool.length; i++) {
        testListNo.add({
          "no": Data.dataSchool[i].id,
          "keyword": Data.dataSchool[i].School_Name,
        });
      }
    }
    setState(() {
      testListNo = testListNo;

      //   _selectedTest = selectedTest;

      _testList = testListNo;

      _dropdownTestItems = buildDropdownTestItems(_testList);

      ////PRINT(Data.dataSchool);

      //_testList.clear();

      // _testList.setRange(0,Data.dataSchool.length,Data.dataSchool);
      // for (int i=0;i<Data.dataSchool.length;i++){
      //   testListNo.add({"no":Data.dataSchool[i].id,
      //     "keyword":Data.dataSchool[i].School_Name,
      //
      //   });
    });

    if (testListNo.length > 0) {
      testListNo = [];
      _testList = [];
      Data.dataSchool = [];
    }
    // setState(() {
    //   Data.dataSchool=Data.dataSchool;
    //   _testList=testListNo;
    //
    //   _dropdownTestItems = buildDropdownTestItems(_testList);
    //
    //   ////PRINT(Data.dataSchool);
    // });

    // _testList.clear();
    // testListNo.clear();
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

      ////PRINT(Data.dataSchool);
    });

    _tetcherList.clear();
    testListTetcherNo.clear();

    // _tetcherList.clear();
    // testListNo.clear();

    //Data.dataDriverBusesinSchool=[];
  }

  @override
  initState() {
    super.initState();
    if (_valuseChoseChhool == null)
      //   schoolapi=new SchoolApiProvider();
      // Data.dataSchool= await schoolapi.fechAllSchool();
      fetchAllschool();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  var addresses;
  var first;
  double lat = 21.42291670082779;
  double long = 39.82589776995795;

  @override
  Widget build(BuildContext context) {
    // getlocation();
    // fetchAllschool();
    fetchSchool();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(children: [
        Stack(children: [
          GoogleMap(initialCameraPosition: _kGooglePlex),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        Text(
                            "${first == null ? " " : first.countryName},${first == null ? " " : first.locality},"
                            " ${first == null ? " " : first.featureName}"),
                        SingleChildScrollView(
                          child: Text(
                            " ${first == null ? " " : first.addressLine}",
                            style: TextStyle(fontSize: 10),
                          ),
                          scrollDirection: Axis.vertical,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.amber,
                ),
                color: Colors.amber,
                iconSize: 40,
              ),
            ),
          ),
        ]),
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
                child: Center(
              child: buildChooseSchoolAndBisesDriver(),
            )))
      ]),
      // This trailing comma makes auto-formatting nicer for build methods.
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  String _ratingController;
  String _sizeController;

  buildChooseSchoolAndBisesDriver() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownBelowWidget(
              tital: "اختر المدرسة",
              selectedTest: _selectedTest,
              dropdownTestItems: _dropdownTestItems,
              onChangeDropdownTests: onChangeDropdownTests,
            ),
            DropdownBelowWidget(
              tital: "اختر السائق",
              selectedTest: _selectedTetcher,
              dropdownTestItems: _dropdownTetcherItems,
              onChangeDropdownTests: onChangeDropdownTetcher,
            )
          ],
        ),
      ),
    );
  }
}
