import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:permission_handler/permission_handler.dart';

import 'package:http/http.dart' as http;
import 'package:location/location.dart' as locations;
import 'package:permission_handler/permission_handler.dart';
import 'package:school_ksa/lib/ApiProvider/ApiLocationDriver.dart';
import 'package:school_ksa/lib/ApiProvider/ApiSchool.dart';
import 'package:school_ksa/lib/ApiProvider/api_driver_buses.dart';
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/LocationDriver.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Widget/dropdown_below_widget.dart';
import 'package:school_ksa/lib/appColors/app_colors.dart';

import 'Account/Profile/bus_driver_screan.dart';
import 'Account/Profile/profile_parent.dart';
import 'Account/logIn.dart';
import 'ChooseScool.dart';
import 'Proplem.dart';

class HomeScrean extends StatefulWidget {
  @override
  _HomeScreanPageState createState() => _HomeScreanPageState();
}

Iterable<T> removeDuplicates<T>(Iterable<T> iterable) sync* {
  Set<T> items = {};
  for (T item in iterable) {
    if (!items.contains(item)) yield item;
    items.add(item);
  }
}

final greenPin =
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
final bluePin =
    BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);

class _HomeScreanPageState extends State<HomeScrean> {
  int _counter = 0;

  LocationDriver _locationDriver;

  Future<void> initAsync() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      //   // Permission.camera,
      //   // Permission.bluetooth,
      //   // Permission.contacts,
    ].request();

    if (await Permission.storage.request().isGranted) {
      //  DataScoolAndDriverChooseLocal.loadImageList();

      setState(() {
        // _loading = false;
      });
    } else {
      //////PRINT(statuses[Permission.storage]);
    }

// You can request multiple permissions at once.
  }

  double latitudeMyLocation = 28.2762667;
  double longitudeMyLocation = 43.04941;
  double latitudeDriver = 28.2762667;
  double longitudeDriver = 43.04941;
  Completer<GoogleMapController> _controller = Completer();

  // final  CameraPosition _kGooglePlex =  CameraPosition(
  //   target:LatLng(latitudeMyLocation,longitudeMyLocation),
  //   zoom: 11.4746,
  //
  // );

  var coordinates;

  var pinList = [
    MarkerDetails(1, LatLng(28.2762667, 43.04941),
        bigIcon: greenPin, smallIcon: bluePin),
    // MarkerDetails(3, LatLng(52, 1.2), bigIcon: greenPin, smallIcon: bluePin),
    // MarkerDetails(4, LatLng(52, 1.3), bigIcon: greenPin, smallIcon: bluePin),
  ];
  var markerList;

  // List<Marker> _generateMarkerList(
  //     List<MarkerDetails> detailsList, int selectedKey) {
  //   return detailsList
  //       .map((place) => Marker(
  //             position:
  //                 LatLng(place.position.latitude, place.position.longitude),
  //             markerId: MarkerId(place.key.toString()),
  //             infoWindow: InfoWindow(
  //                 title: place.key.toString(), snippet: place.toString()),
  //             onTap: () => setState(() =>
  //                 markerList = _generateMarkerList(detailsList, place.key)),
  //             icon: selectedKey == place.key ? place.bigIcon : place.smallIcon,
  //           ))
  //       .toList();
  // }

  locations.LocationData _currentPosition;
  String _address, _dateTime;
  GoogleMapController mapController;
  Marker marker;
  locations.Location locatio = locations.Location();

  GoogleMapController _controllerssssss;

  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  void _addMarker(LatLng location, String address) {
    // _markers.add(Marker(
    //     markerId: MarkerId(address),
    //     position: location,
    //     infoWindow: InfoWindow(title: address, snippet: "go here"),
    //     icon: BitmapDescriptor.defaultMarker));
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void _onMapCreateds(GoogleMapController controller) {
    _controller.complete(controller);
  }

  bool loading = true;

  Future<BitmapDescriptor> setImageAsset() {
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context, size: Size.square(48));

    final bluePin =
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);

    return BitmapDescriptor.fromAssetImage(
        imageConfiguration, 'assets/images/map.png');
  }

  getLocation() async {
    var location = new locations.Location();

    location.onLocationChanged.listen((currentLocation) async {
      ////PRINT(currentLocation.latitude);
      ////PRINT(currentLocation.longitude);
      // await  SaveLocation();

      // latLng = LatLng(currentLocation.latitude, currentLocation.longitude);

      //    await allActionMap();

      // _onAddMarkerButtonPressed();

      //
      // ////PRINT("getLocation:$latLng");
      loading = false;
    });
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    ////PRINT(lList.toString());
    return lList;
  }

  GoogleMapsServices _googleMapsServices = GoogleMapsServices();

  void sendRequest(LatLng latlnggdgd) async {
    //
    // double latitudeMyLocation =28.2762667;
    // double longitudeMyLocation = 43.04941;

    // LatLng destination = LatLng(29.079923446220345, 39.63187141223197);//latlnggdgd;
//    String route = await _googleMapsServices.getRouteCoordinates(destination, latlnggdgd);
    //createRoute(route);
    // _addMarker(latlnggdgd,"firest");
    // _addMarker(destination,"latlnggdgd");
  }

  Set<Polyline> _polyLines = {};

  Set<Polyline> get polyLines => _polyLines;

  //_polyLines

  Set<Polyline> polyLinesss = {};

  void createRoute(String encondedPoly, LatLng latLng, List points) {
    polyLinesss.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        //points: _convertToLatLng(_decodePoly(encondedPoly)),
        points: points,
        color: ColorAPP.lightGreen));
  }

  //
  // getLoc() async {
  //   setState(() {
  //     Data.dataLocationDriver = Data.dataLocationDriver;
  //     ////PRINT(Data.dataLocationDriver);
  //     // first = value.first;
  //     // _address = "${value.first.addressLine}";
  //     ////PRINT(Data.dataLocationDriver);
  //   });
  // }
  var apiKey = "AIzaSyBOnp_PY0tImyFRmPa62MgLlfFt5TP2doM";

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add = await Geocoder.google(apiKey, language: "AR")
        .findAddressesFromCoordinates(coordinates);
    addresses = add;
    return add;
  }

  var loc;

  getlocations() async {
    _locationDriver = await DataUserLocal.getLocationUser();

    final Coordinates coordinates =
        new Coordinates(_locationDriver.latitude, _locationDriver.longitude);
    addresses = await Geocoder.google(apiKey, language: "AR")
        .findAddressesFromCoordinates(coordinates);
    //addresses=await Geocoder.google("AIzaSyBOnp_PY0tImyFRmPa62MgLlfFt5TP2doM",language: "Ar").findAddressesFromCoordinates(coordinates);
    setState(() {
      latitudeMyLocation = _locationDriver.latitude;
      longitudeMyLocation = _locationDriver.longitude;
      setMarkser(latitudeMyLocation, longitudeMyLocation);
      first =
          "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
          " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
      loc = first;

      first =
          "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
          " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
      loc = first;

      // first = addresses[0];
      // ////PRINT(i);

      // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
    });
  }

  Set<Marker> _markers = {
    // Marker  (
    //   // markerId: MarkerId("sklskssksks"),
    //   // position: LatLng(28.2762667,43.04941),
    //   // icon:bluePin,
    //
    // )
  };

  GoogleMapController controller;
  BitmapDescriptor _markerIcon;
  BitmapDescriptor _markerLastIcon;

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size.square(48));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/images/map.png')
          .then(_updateBitmap);
    }

    // _createMarkerImageLastFromAsset(context);
  }

  Future<void> _createMarkerImageLastFromAsset(BuildContext context) async {
    if (_markerLastIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size.square(48));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/images/mapLast.png')
          .then(_updateLasBitmap);
    }
  }

  void _updateLasBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerLastIcon = bitmap;
    });
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  double i = 0.0551453646;

  setMarkser(lat, long) {
    // setState(() {
    //   i=i+0.654616598749;
    //   _markers.add( Marker(
    //     markerId: MarkerId("${lat+i+long+i}+"),
    //     // a string for marker unique id
    //     icon: BitmapDescriptor.defaultMarker,
    //
    //     // options for hues and custom imgs
    //     position: LatLng(lat, long),
    //   ));
    // });
  }

  String DataLast;
  LocationDriverApiProvider _locationDriverApiProvider =
      new LocationDriverApiProvider();
  List<LatLng> pointsssss = [];

  int init = 0;
  int initTow = 0;

  getLocationDriverBuset() async {
    getInfoDivice.getDeviceDetails();
    //
    // pointsssss.clear();
    // _markers.clear();

    setState(() {
      Data.dataLocationDriver = [];
    });
    Data.dataLocationDriver =
        await _locationDriverApiProvider.fetchLocationByDriver(
            await DataScoolAndDriverChooseLocal.getDriverIdFromRefrences());

    LatLng latLngFir;
    double lastLat = 000.000;
    double lastlong = 0.0000;

    setState(() {
      Data.dataLocationDriver = Data.dataLocationDriver;
    });

    if (Data.dataLocationDriver.length > 0) {
      for (int TTTT = 0; TTTT < Data.dataLocationDriver.length / 2; TTTT++) {
        print(TTTT);
        print(Data.dataLocationDriver[TTTT].id);
        print(Data.dataLocationDriver[TTTT].longitude);
        print(Data.dataLocationDriver[TTTT].Name_Location);
        // lastLat = Data.dataLocationDriver[TTTT].latitude;

        if (TTTT == 0) {
          pointsssss = [];
          setState(() {
            latLng = LatLng(Data.dataLocationDriver[TTTT].latitude,
                Data.dataLocationDriver[TTTT].longitude);
            first = Data.dataLocationDriver[TTTT].Name_Location;
            DataLast = Data.dataLocationDriver[TTTT].Date_Added;
            _createLastMarker(
                LatLng(Data.dataLocationDriver[TTTT].latitude,
                    Data.dataLocationDriver[TTTT].longitude),
                "اخر موقف " + "\t" + DataLast);

            _createLastMarker(
                LatLng(Data.dataLocationDriver[TTTT].latitude,
                    Data.dataLocationDriver[TTTT].longitude),
                "اخر موقف " + "\t" + DataLast);
            _createLastMarker(
                LatLng(Data.dataLocationDriver[TTTT].latitude,
                    Data.dataLocationDriver[TTTT].longitude),
                "اخر موقف " + "\t" + DataLast);
            _createLastMarker(
                LatLng(Data.dataLocationDriver[TTTT].latitude,
                    Data.dataLocationDriver[TTTT].longitude),
                "اخر موقف " + "\t" + DataLast);
            _createLastMarker(
                LatLng(Data.dataLocationDriver[TTTT].latitude,
                    Data.dataLocationDriver[TTTT].longitude),
                "اخر موقف " + "\t" + DataLast);
            _createLastMarker(
                LatLng(Data.dataLocationDriver[TTTT].latitude,
                    Data.dataLocationDriver[TTTT].longitude),
                "اخر موقف " + "\t" + DataLast);
            _createLastMarker(
                LatLng(Data.dataLocationDriver[TTTT].latitude,
                    Data.dataLocationDriver[TTTT].longitude),
                "اخر موقف " + "\t" + DataLast);

            // createRoute(pointsssss.toString(),latLng,pointsssss);

            // pointsssss.clear();
            //  pointsssss = [];

            _position = new CameraPosition(
              target: latLng,
              tilt: 56.440717697143555,
              zoom: 19.151926040649414,

              bearing: 192.8334901395799,

              // zoom: 16,
            );

            // if(mapController!=null)
            //   mapController.moveCamera(CameraUpdate.newCameraPosition(_position));
          });
          //
          // _markers={
          //
          //     Marker(
          //
          //     markerId: MarkerId("firest"),
          //     position: latLngFir,
          //     icon: _markerIcon,
          //
          //
          //   ),

          //     Marker(
          //   markerId: MarkerId("last")
          //   ,
          //   position: latLng,
          //
          //   icon: _markerLastIcon,
          // )
          // };
        }
        await initTow++;
        setState(() {
          if (TTTT == Data.dataLocationDriver.length - 1) {
            initTow = 0;

            pointsssss = [];
            _markers = {};
          }

          first = Data.dataLocationDriver[TTTT].Name_Location;
          DataLast = Data.dataLocationDriver[TTTT].Date_Added;

          latitudeDriver = Data.dataLocationDriver[TTTT].latitude;
          longitudeDriver = Data.dataLocationDriver[TTTT].longitude;

          // if (mapController != null)
          //   mapController
          //       .moveCamera(CameraUpdate.newCameraPosition(_position));

          //pointsssss.add(LatLng(Data.dataLocationDriver[TTTT].latitude, Data.dataLocationDriver[TTTT].longitude));
          setState(() {
            latLng = LatLng(Data.dataLocationDriver[TTTT].latitude,
                Data.dataLocationDriver[TTTT].longitude);

            pointsssss.add(latLng);
            createRoute(pointsssss.toString(), latLng, pointsssss);
          });

          // if (initTow != 1) {
          //   setState(() {
          //
          //   });
          // }
          // LatLng(Data.dataLocationDriver[TTTT].latitude,
          //     Data.dataLocationDriver[TTTT].longitude),
          // "نقطة البداية " + "\t" + DataLast);

          if (TTTT != Data.dataLocationDriver.length - 1) {
            //
            setState(() {
              //   _markers.clear();
              //   latLngFir=LatLng(latitudeDriver, longitudeDriver);
              _createFirestMarker(
                  LatLng(Data.dataLocationDriver[TTTT].latitude,
                      Data.dataLocationDriver[TTTT].longitude),
                  "نقطة البداية " + "\t" + DataLast);

              //   _createLastMarker(LatLng(Data.dataLocationDriver[TTTT].latitude, Data.dataLocationDriver[TTTT].longitude),first);
            });
            //pointsssss.clear();
            //pointsssss = [];
          }
        });

        // if (pointsssss.length <= 200) {
        //   pointsssss.add(LatLng(latitudeDriver, longitudeDriver));
        // }

        // if (TTTT == 0) {
        //   pointsssss=[];
        // }

        // if (TTTT == Data.dataLocationDriver.length) {
        //   pointsssss.add(LatLng(latitudeDriver, longitudeDriver));
        // }

        ///  _addMarker(LatLng(latitudeDriver,longitudeDriver),"${TTTT}");
        ///
        ///
        // if (TTTT == 0) {
        //   _polyLines.add(Polyline(
        //     color: ColorAPP.lightGreen,
        //     width: 10,
        //
        //     points: pointsssss,
        //     polylineId: PolylineId("firest"),
        //   ));
        // }

        // _polyLines.add(Polyline(
        //   color: ColorAPP.lightGreen,
        //   width: 10,
        //   points: pointsssss,
        //
        //   polylineId: PolylineId("last"),
        // ));

        // pinList.add(
        //   MarkerDetails(Data.dataLocationDriver[TTTT].id,
        //       LatLng(latitudeMyLocation, longitudeMyLocation),
        //       bigIcon: greenPin, smallIcon: bluePin),
        // );
        //saMarkerDetails(i, LatLng(latitudeDriver, longitudeMyLocation), bigIcon: greenPin, smallIcon: bluePin);

        //setMarkser(Data.dataLocationDriver[TTTT].latitude, Data.dataLocationDriver[TTTT].longitude);

      }
    }

    Future.delayed(Duration(milliseconds: 100000),
        () async => await getLocationDriverBuset());
    setState(() {});
    setState(() {
      // Data.dataLocationDriver=[];
      //  _markers = _markers;
      //   pinList=pinList;
      // //PRINT(Data.dataLocationDriver[i].latitude);
      // //PRINT(Data.dataLocationDriver[i].longitude);
      // //PRINT(Data.dataLocationDriver[i].Name_Location);
      //
      //
      // latitudeDriver=latitudeDriver;
      // longitudeDriver=longitudeDriver;
      // first=first;
      // DataLast=DataLast;
    });
  }

  int idLocMark = 0;

  static var location = locations.Location();
  static StreamController<LocationDriver> _locationController =
      StreamController<LocationDriver>();

  Stream<LocationDriver> get locationStream => _locationController.stream;
  var first;

  Map<Permission, PermissionStatus> statuses;

  LocationService() async {
    statuses = await [
      Permission.storage,
      Permission.location,
      //   // Permission.camera,
      //   // Permission.bluetooth,
      //   // Permission.contacts,
    ].request();

    setState(() {
      statuses = statuses;
    });

    // Request permission to use location
    location.requestPermission().then((permissionStatus) async {
      if (permissionStatus == PermissionStatus.granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller

        location.onLocationChanged.listen((locationData) async {
          if (locationData != null) {
            final Coordinates coordinates =
                new Coordinates(locationData.latitude, locationData.longitude);
            addresses = await Geocoder.google(apiKey, language: "AR")
                .findAddressesFromCoordinates(coordinates);

            first = addresses;

            _locationController.add(LocationDriver(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
              IMEI_device: getInfoDivice.identifier,
              Name_Location:
                  "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode},'
                      " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '" : "NULLNULL"}",
            ));

            // print( "countryName ${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, subLocality ${addresses[0].subLocality == null ? " " : addresses[0].subLocality},'
            //     " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
            // _locationDriverApiProvider.addLocationDriver(_locationDriver);
            //
            // print( "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, adminArea ${addresses[0].adminArea == null ? " " : addresses[0].adminArea},'
            //     "featureName ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} , addressLine  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
          }
        });
      } else {
        location.requestPermission();
        location.requestService();

        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
          Permission.location,
          //   // Permission.camera,
          //   // Permission.bluetooth,
          //   // Permission.contacts,
        ].request();

        if (await Permission.storage.request().isGranted) {}
      }
    });

    //print(' ${first.locality},${first.subLocality},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
  }

  List<Address> addresses = [];

  Future<LocationDriver> getLocationLast() async {
    LocationService();
    getInfoDivice.getDeviceDetails();

    try {
      var userLocation = await location.getLocation();

      location.enableBackgroundMode(
        enable: true,
      );
      //location.isBackgroundModeEnabled();

      final Coordinates coordinates =
          new Coordinates(userLocation.latitude, userLocation.longitude);
      addresses =
          //await Geocoder.local.findAddressesFromCoordinates(coordinates);
          await Geocoder.google(apiKey, language: "ar")
              .findAddressesFromCoordinates(coordinates);

      print(await addresses);
      setState(() {
        _locationDriver = new LocationDriver(
          longitude: userLocation.longitude,
          latitude: userLocation.latitude,
          Driver:
              "https://mubus.pythonanywhere.com/api/v1/DriverBus/${DataUserLocal.getIdDriverFromDataBase()}/",
          IMEI_device: getInfoDivice.identifier,
          Name_Location: addresses.isNotEmpty && addresses != null
              ? "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].adminArea}, ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subAdminArea},"
                  " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryCode} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine},  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,"
                  " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode}  , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality} , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subLocality}"
              : " NULL ",
        );

        if (_locationDriver != null) {
          _locationDriverApiProvider.addLocationDriver(_locationDriver);
          print(_locationDriver.toJson());
          print("Done Save 2");
        }
        // print("${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].adminArea}, ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subAdminArea},"
        //     " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryCode} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine},  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality}",
        // );

        _position = new CameraPosition(
          target: latLng,
          //  bearing: 45 ,

          //  tilt: 50 ,
          tilt: 59.440717697143555,
          zoom: 19.151926040649414,
          bearing: 192.8334901395799,

          // zoom: 16,
        );
      });

      // print( "countryName ${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, subLocality ${addresses[0].subLocality == null ? " " : addresses[0].subLocality},'
      //     " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
      // _locationDriverApiProvider.addLocationDriver(_locationDriver);
      //
      // print( "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, adminArea ${addresses[0].adminArea == null ? " " : addresses[0].adminArea},'
      //     "featureName ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} , addressLine  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");

      //
      // print( "countryName ${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, subLocality ${addresses[0].subLocality == null ? " " : addresses[0].subLocality},'
      //     " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
      // _locationDriverApiProvider.addLocationDriver(_locationDriver);
      //
      // print( "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, adminArea ${addresses[0].adminArea == null ? " " : addresses[0].adminArea},'
      //     "featureName ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} , addressLine  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");

      // Data.dataLocationDriver.add(
      //     await _locationDriverApiProvider.addLocationDriver(
      //         _locationDriver));

      //  print('Could not get location:');
      await SaveLocation(_locationDriver);

      await getLocationLast();
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _locationDriver;
  }

  SaveLocation(LocationDriver _locationDriver) async {
    double _lastLattude = 0.02656;
    double _lastLongtude = 0.02656;

    // _locationDriver = await DataUserLocal.getLocationUser();

    if (_locationDriver != null) {
      _locationDriverApiProvider.addLocationDriver(_locationDriver);
      print(_locationDriver.toJson());
      print("Done Save 1");
    }

    _lastLattude = _locationDriver.latitude;
    _lastLongtude = _locationDriver.longitude;
    final Coordinates coordinates =
        new Coordinates(_locationDriver.latitude, _locationDriver.longitude);
    // addresses =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
    addresses = await Geocoder.google(apiKey, language: "ar")
        .findAddressesFromCoordinates(coordinates);
    //addresses=await Geocoder.google("AIzaSyBOnp_PY0tImyFRmPa62MgLlfFt5TP2doM",language: "Ar").findAddressesFromCoordinates(coordinates);
    var latLngahj;
    setState(() {
      idLocMark + 1;
      latitudeMyLocation = _locationDriver.latitude;
      longitudeMyLocation = _locationDriver.longitude;

      latLng = LatLng(latitudeMyLocation, longitudeMyLocation);

      latLng = LatLng(latitudeMyLocation, longitudeMyLocation);

      first =
          "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
          " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
      loc = first;
      if (idLocMark == 1) {
        _createLastMarker(latLng, "نقطة البداية " + "\t" + DataLast);

        mapController.moveCamera(CameraUpdate.newLatLngZoom(
          latLng,
          19.151926040649414,
        ));
      }
      // _createFirestMarker(
      //     LatLng(latitudeMyLocation, longitudeMyLocation),first);
      // _createFirestMarker(latLng,"نقطة البداية "+"\n"+DataLast);

      // _createLastMarker(LatLng(latitudeMyLocation, longitudeMyLocation),first);

      // _addMarker(latLng, "${idLocMark}");

      pointsssss.add(latLng);
      createRoute(pointsssss.toString(), latLng, pointsssss);

      ///  _addMarker(LatLng(latitudeDriver,longitudeDriver),"${TTTT}");
      ///
      // _polyLines.add(Polyline(
      //   color: ColorAPP.lightGreen,
      //   width: 10,
      //   points: pointsssss,
      //   polylineId: PolylineId("id"),
      // ));

      DataLast = DateTime.now().year.toString() +
          " - " +
          DateTime.now().month.toString() +
          " - " +
          DateTime.now().day.toString() +
          " - ";
      DataLast = DateTime.now().toString();

      setMarkser(latitudeMyLocation, longitudeMyLocation);

      // pinList.add(
      //   MarkerDetails(
      //       idLocMark, LatLng(latitudeMyLocation, longitudeMyLocation),
      //       bigIcon: greenPin, smallIcon: bluePin),
      // );

      first =
          "${addresses == null || addresses.length <= 0 ? "NULL" : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
          " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
      loc = first;

      _position = new CameraPosition(
        target: latLng,
        tilt: 56.440717697143555,
        zoom: 19.151926040649414,

        bearing: 192.8334901395799,

        // zoom: 16,
      );

      if (idLocMark != 1) {
        //   _markers.clear();
        //   latLngFir=LatLng(latitudeDriver, longitudeDriver);
        _createFirestMarker(latLng, "اخر موقف " + "\t" + DataLast);
      }
      // first = addresses[0];
      // //PRINT(i);

      // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
      // markerList = _generateMarkerList(pinList, idLocMark);
      // _mapVertex =  MapVertex.fromLatLng(LatLng(latitudeMyLocation, longitudeMyLocation));
      // _overlays.add(TileOverlay(
      //   tileOverlayId: TileOverlayId('tile_overlay_${idLocMark}'),
      //   tileProvider: PointsTileProvider([_mapVertex]),
      // ));
      //
      // _overlays.add(TileOverlay(
      //   tileOverlayId: TileOverlayId('tile_overlay_1}'),
      //   tileProvider: PointsTileProvider([_mapVertex]),
      // ));
    });
    // _locationDriver= await DataUserLocal.getLocationUser();

    await sendRequest(latLng);

    setState(() {
      _markers = _markers;

      //
      // latitudeMyLocation=_locationDriver.latitude;
      // longitudeMyLocation=_locationDriver.longitude;
      // setMarkser(latitudeMyLocation,longitudeMyLocation);
      //
      // first = addresses[0];
      // //PRINT(i);
      //
      //
      //
      // latitudeMyLocation=_locationDriver.latitude;
      // longitudeMyLocation=_locationDriver.longitude;
      // setMarkser(latitudeMyLocation, longitudeMyLocation);

      //endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
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
      //       .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScrean()));
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
        textDirection: ui.TextDirection.rtl,
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

  void initAccount() async {
    await DataUserLocal.checkTypeAndHaveAccount();

    setState(() {
      DataUserLocal.checkTypeAndHaveAccount();
    });
  }

  // final interval = const Duration(seconds: 1);
  //
  // final int timerMaxSeconds = 10;
  //
  // int currentSeconds = 0;
  //
  // String get timerText =>
  //     '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  //
  // startTimeout([int milliseconds]) {
  //   var duration = interval;
  //   Timer.periodic(duration, (timer) async {
  //     if (timer.tick >= timerMaxSeconds) {
  //       if (DataUserLocal.isDriver)
  //         await SaveLocation();
  //       else
  //         await getLocationDriverBuset();
  //     }
  //     setState(() {
  //       //PRINT(timer.tick);
  //       currentSeconds = timer.tick;
  //       if (timer.tick >= timerMaxSeconds) {
  //         startTimeout();
  //       }
  //     });
  //   });
  // }
  //
  // Timer _timer;
  // int _start = 5;
  //
  // void startTimer() async {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_start == 0) {
  //         setState(() {
  //           //PRINT(_start);
  //           //PRINT("_start");
  //           print("_startTow");
  //
  //           setState(() {
  //             _timer.cancel();
  //             _start = 5;
  //           });
  //         });
  //       } else {
  //         setState(() {
  //           _start--;
  //
  //           // setState(() {
  //           //
  //           //   if(DataUserLocal.isDriver)
  //           //     SaveLocation();
  //           //   else
  //           //     getLocationDriverBuset();
  //           // });
  //           print(_start);
  //           print("_startThree");
  //         });
  //       }
  //     },
  //   );
  // }

  //
  // void serviceEnabledMethod(
  //     locations.LocationData getLoc, BuildContext context, Function getMapData,
  //     {Function updatePosition}) async {
  //   getLoc = await location.getLocation();
  //   Provider.of<MapProvider>(context, listen: false).updateCurrentLocation(
  //       LatLng(getLoc.latitude!.toDouble(), getLoc.longitude!.toDouble()));
  //   updatePosition!(CameraPosition(
  //       zoom: 0,
  //       target:
  //       LatLng(getLoc.latitude!.toDouble(), getLoc.longitude!.toDouble())));
  //   if (Provider.of<MapProvider>(context, listen: false).currentLatLng !=
  //       null) {
  //     await getMapData();
  //     _getLocationUpdates(context, getLoc, getMapData);
  //   }
  // }

  // Future<void> _getUserLocation(BuildContext context) async {
  //   PermissionUtils.requestPermission(Permission.location, context,
  //       isOpenSettings: true, permissionGrant: () async {
  //         await LocationService().fetchCurrentLocation(context, _getPharmacyList,
  //             updatePosition: updateCameraPosition);
  //       }, permissionDenied: () async {});
  // }

  CheckPermission() async {
    statuses = await [
      Permission.storage,
      Permission.location,
      //   // Permission.camera,
      //   // Permission.bluetooth,
      //   // Permission.contacts,
    ].request();

    // If granted listen to the onLocationChanged stream and emit over our controller

    var userLocation = await location.getLocation();
    if (userLocation != null) {
      print("Location Changed 3");

      setState(() {
        idLocMark + 1;
        _locationDriver = new LocationDriver(
          longitude: userLocation.longitude,
          latitude: userLocation.latitude,
          Driver:
              "https://mubus.pythonanywhere.com/api/v1/DriverBus/${DataUserLocal.getIdDriverFromDataBase()}/",
          IMEI_device: getInfoDivice.identifier,
          Name_Location: addresses.length > 0 && addresses != null
              ? "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].adminArea}, ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subAdminArea},"
                  " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryCode} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine},  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,"
                  " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode}  , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality} , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subLocality}"
              : " NULL ",
        );

        latitudeMyLocation = userLocation.latitude;
        longitudeMyLocation = userLocation.longitude;
        first =
            "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
            " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
        loc = first;

        latLng = LatLng(latitudeMyLocation, longitudeMyLocation);
        if (idLocMark == 1)
          // _createFirestMarker(
          //     LatLng(latitudeMyLocation, longitudeMyLocation),first);
          _createFirestMarker(latLng, "نقطة البداية " + "\n" + DataLast);

        // _createLastMarker(LatLng(latitudeMyLocation, longitudeMyLocation),first);

        if (idLocMark == 1)
          latLng = LatLng(latitudeMyLocation, longitudeMyLocation);
        // _addMarker(latLng, "${idLocMark}");

        pointsssss.add(latLng);

        ///  _addMarker(LatLng(latitudeDriver,longitudeDriver),"${TTTT}");
        ///
        // _polyLines.add(Polyline(
        //   color: ColorAPP.lightGreen,
        //   width: 10,
        //   points: pointsssss,
        //   polylineId: PolylineId("id"),
        // ));

        DataLast = DateTime.now().year.toString() +
            " - " +
            DateTime.now().month.toString() +
            " - " +
            DateTime.now().day.toString() +
            " - ";
        DataLast = DateTime.now().toString();

        setMarkser(latitudeMyLocation, longitudeMyLocation);

        // pinList.add(
        //   MarkerDetails(
        //       idLocMark, LatLng(latitudeMyLocation, longitudeMyLocation),
        //       bigIcon: greenPin, smallIcon: bluePin),
        // );

        first =
            "${addresses == null || addresses.length <= 0 ? "NULL" : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
            " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
        loc = first;

        _createLastMarker(latLng, "نقطة البداية " + "\t" + DataLast);

        _position = new CameraPosition(
          target: latLng,
          tilt: 56.440717697143555,
          zoom: 19.151926040649414,

          bearing: 192.8334901395799,

          // zoom: 16,
        );

        if (idLocMark != 1) {
          //   _markers.clear();
          //   latLngFir=LatLng(latitudeDriver, longitudeDriver);
          _createLastMarker(latLng, "اخر موقف " + "\t" + DataLast);
        }
        // first = addresses[0];
        // //PRINT(i);

        // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
        // markerList = _generateMarkerList(pinList, idLocMark);
        // _mapVertex =  MapVertex.fromLatLng(LatLng(latitudeMyLocation, longitudeMyLocation));
        // _overlays.add(TileOverlay(
        //   tileOverlayId: TileOverlayId('tile_overlay_${idLocMark}'),
        //   tileProvider: PointsTileProvider([_mapVertex]),
        // ));
        //
        // _overlays.add(TileOverlay(
        //   tileOverlayId: TileOverlayId('tile_overlay_1}'),
        //   tileProvider: PointsTileProvider([_mapVertex]),
        // ));
      });

      final Coordinates coordinates =
          new Coordinates(userLocation.latitude, userLocation.longitude);
      // addresses =
      // await Geocoder.google(apiKey,language: "AR").findAddressesFromCoordinates(coordinates);
      setState(() {
        first = addresses;
        setAdd(userLocation.latitude, userLocation.longitude);
        _locationDriver = LocationDriver(
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
          IMEI_device: getInfoDivice.identifier,
          Name_Location:
              "${addresses != null || addresses.length > 0 ? '${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode},'
                  " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '" : " "}",
        );

        _locationController.add(_locationDriver);

        if (_locationDriver != null) {
          _locationDriverApiProvider.addLocationDriver(_locationDriver);
          print(_locationDriver.toJson());
          print("Done Save 1");
        }
        //  SaveLocation(_locationDriver);
      });
      // print( "countryName ${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, subLocality ${addresses[0].subLocality == null ? " " : addresses[0].subLocality},'
      //     " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
      // _locationDriverApiProvider.addLocationDriver(_locationDriver);
      //
      // print( "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, adminArea ${addresses[0].adminArea == null ? " " : addresses[0].adminArea},'
      //     "featureName ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} , addressLine  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
    }
    location.enableBackgroundMode(enable: true);
    //location.changeSettings(accuracy: locations.LocationAccuracy.high,
    //interval: 100,
    //     distanceFilter: 5
    // );
    //location.changeSettings(accuracy: locations.LocationAccuracy.high,distanceFilter: 10,interval: 500  );
    location.onLocationChanged.listen((locationData) {
      if (locationData != null) {
        print("Location Changed 1");

        setState(() {
          idLocMark + 1;
          _locationDriver = new LocationDriver(
            longitude: locationData.longitude,
            latitude: locationData.latitude,
            Driver:
                "https://mubus.pythonanywhere.com/api/v1/DriverBus/${DataUserLocal.getIdDriverFromDataBase()}/",
            IMEI_device: getInfoDivice.identifier,
            Name_Location: addresses.isNotEmpty && addresses != null
                ? "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].adminArea}, ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subAdminArea},"
                    " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryCode} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine},  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,"
                    " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode}  , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality} , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subLocality}"
                : " NULL ",
          );
          latitudeMyLocation = locationData.latitude;
          longitudeMyLocation = locationData.longitude;
          first =
              "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
              " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
          loc = first;

          latLng = LatLng(latitudeMyLocation, longitudeMyLocation);
          if (idLocMark == 1)
            // _createFirestMarker(
            //     LatLng(latitudeMyLocation, longitudeMyLocation),first);
            _createFirestMarker(latLng, "نقطة البداية " + "\n" + DataLast);

          // _createLastMarker(LatLng(latitudeMyLocation, longitudeMyLocation),first);

          if (idLocMark == 1)
            latLng = LatLng(latitudeMyLocation, longitudeMyLocation);
          // _addMarker(latLng, "${idLocMark}");

          pointsssss.add(latLng);

          ///  _addMarker(LatLng(latitudeDriver,longitudeDriver),"${TTTT}");
          ///
          // _polyLines.add(Polyline(
          //   color: ColorAPP.lightGreen,
          //   width: 10,
          //   points: pointsssss,
          //   polylineId: PolylineId("id"),
          // ));

          DataLast = DateTime.now().year.toString() +
              " - " +
              DateTime.now().month.toString() +
              " - " +
              DateTime.now().day.toString() +
              " - ";
          DataLast = DateTime.now().toString();

          setMarkser(latitudeMyLocation, longitudeMyLocation);

          // pinList.add(
          //   MarkerDetails(
          //       idLocMark, LatLng(latitudeMyLocation, longitudeMyLocation),
          //       bigIcon: greenPin, smallIcon: bluePin),
          // );

          first =
              "${addresses == null || addresses.length <= 0 ? "NULL" : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
              " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
          loc = first;

          _createLastMarker(latLng, "نقطة البداية " + "\t" + DataLast);

          _position = new CameraPosition(
            target: latLng,
            tilt: 56.440717697143555,
            zoom: 19.151926040649414,

            bearing: 192.8334901395799,

            // zoom: 16,
          );

          if (idLocMark != 1) {
            //   _markers.clear();
            //   latLngFir=LatLng(latitudeDriver, longitudeDriver);
            _createLastMarker(latLng, "اخر موقف " + "\t" + DataLast);
          }
          // first = addresses[0];
          // //PRINT(i);

          // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
          // markerList = _generateMarkerList(pinList, idLocMark);
          // _mapVertex =  MapVertex.fromLatLng(LatLng(latitudeMyLocation, longitudeMyLocation));
          // _overlays.add(TileOverlay(
          //   tileOverlayId: TileOverlayId('tile_overlay_${idLocMark}'),
          //   tileProvider: PointsTileProvider([_mapVertex]),
          // ));
          //
          // _overlays.add(TileOverlay(
          //   tileOverlayId: TileOverlayId('tile_overlay_1}'),
          //   tileProvider: PointsTileProvider([_mapVertex]),
          // ));
        });

        final Coordinates coordinates =
            new Coordinates(locationData.latitude, locationData.longitude);
        // addresses =
        // await Geocoder.google(apiKey,language: "AR").findAddressesFromCoordinates(coordinates);
        setState(() {
          first = addresses;

          _locationDriver = LocationDriver(
            latitude: locationData.latitude,
            longitude: locationData.longitude,
            IMEI_device: getInfoDivice.identifier,
            Name_Location:
                "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode},'
                    " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '" : " "}",
          );

          _locationController.add(_locationDriver);
          if (_locationDriver != null) {
            _locationDriverApiProvider.addLocationDriver(_locationDriver);
            print(_locationDriver.toJson());
            print("Done Save 1");
          }
          //     SaveLocation(_locationDriver);
        });
        // print( "countryName ${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, subLocality ${addresses[0].subLocality == null ? " " : addresses[0].subLocality},'
        //     " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
        // _locationDriverApiProvider.addLocationDriver(_locationDriver);
        //
        // print( "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, adminArea ${addresses[0].adminArea == null ? " " : addresses[0].adminArea},'
        //     "featureName ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} , addressLine  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
      }
    });

    setState(() {
      statuses = statuses;
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller.complete(_cntlr);
    //
    // mapController.moveCamera(CameraUpdate.newLatLngZoom(latLng, 10.0
    //   // 19.151926040649414,
    // ));

    mapController.moveCamera(CameraUpdate.newCameraPosition(_position));
    // _controller = _controller;
  }

  setAdd(double latitude, double longitude) async {
    final Coordinates coordinates = new Coordinates(latitude, longitude);
    // addresses = await Geocoder.local
    //   .findAddressesFromCoordinates(coordinates);

    addresses = await Geocoder.google(apiKey, language: "AR")
        .findAddressesFromCoordinates(coordinates);
    setState(() {
      addresses = addresses;
    });
  }

  @override
  initState() {
    setState(() {
      init = 0;
      idLocMark = 0;
      initAccount();
      //
      // checkPermetion();
      // chechAndSave();
      //
      // location.enableBackgroundMode(enable: true);
      //
      //location.changeSettings(accuracy: locations.LocationAccuracy.high,
      //interval: 100,
      //     distanceFilter: 5
      // );

      // markerList = _generateMarkerList(pinList, 0);

      // _overlays.add(TileOverlay(
      //   tileOverlayId: TileOverlayId('tile_overlay_1'),
      //   tileProvider: PointsTileProvider([_mapVertex]),
      // ));

      // getlocation();

      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   height = _globalKey.currentContext.size.height;
      //   width = _globalKey.currentContext.size.width;
      //   print('the new height is $height');
      //   setState(() {});
    });
    super.initState();

    getInfoDivice.getDeviceDetails();
    // Future.delayed(Duration(milliseconds: counterTow == 1 ? 10 : 200),
    //         () async => await getLocationDriverBuset());

    // setState(() {
    //   Data.dataLocationDriver = Data.dataLocationDriver;
    // });
    // getLocationDriverBuset();

    location.enableBackgroundMode(enable: true);

    //location.changeSettings(accuracy: locations.LocationAccuracy.high,
    //interval: 100,
    //     distanceFilter: 5
    // );

    location.changeSettings(
        accuracy: locations.LocationAccuracy.high,
        distanceFilter: 0,
        interval: 1000);
    location.onLocationChanged.listen((locationData) async {
      print("Location Changed 2");
      if (locationData != null) {
        setAdd(locationData.altitude, locationData.longitude);
        print("Location Changed 2");

        _locationDriver = new LocationDriver(
          longitude: locationData.longitude,
          latitude: locationData.latitude,
          IMEI_device: getInfoDivice.identifier,
          Name_Location: addresses == null || addresses.length <= 0
              ? " NULL "
              : "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].adminArea}, ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subAdminArea},"
                  " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryCode} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine},  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,"
                  " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode}  , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality} , ${addresses == null || addresses.length <= 0 ? " " : addresses[0].subLocality}",
        );
        setState(() {
          latitudeMyLocation = locationData.latitude;
          longitudeMyLocation = locationData.longitude;
        });

        setState(() {
          setAdd(
            locationData.latitude,
            locationData.longitude,
          );
          //  first=addresses;
        });

        getLocationDriverBuset();

        _locationDriver = LocationDriver(
          latitude: locationData.latitude,
          longitude: locationData.longitude,
          IMEI_device: getInfoDivice.identifier,
          Name_Location:
              "${addresses == null || addresses.length <= 0 ? "NULL" : '${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].postalCode},'
                  " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '"}",
        );

        setState(() {
          _locationController.add(_locationDriver);
          getLocationDriverBuset();
          if (_locationDriver != null) {
            _locationDriverApiProvider.addLocationDriver(_locationDriver);
            print(_locationDriver.toJson());
            print("Done Save 1");
          }

          //     SaveLocation(_locationDriver);
        });
      }
    });

    Future.delayed(Duration(milliseconds: 200),
        () async => await getLocationDriverBuset());

    // if (DataUserLocal.isParent) {
    //   Future.delayed(Duration(milliseconds: counterTow == 1 ? 10 : 200),
    //       () async => await getLocationDriverBuset());
    print("Is Parent");

    setState(() {
      initAccount();
      //  CheckPermission();
    });

    // getInfoDivice.getDeviceDetails();
    // if (DataUserLocal.isParent)
    //   Future.delayed(Duration(milliseconds: 500),
    //           () async => await getLocationDriverBuset()());

    // getlocation();
// setState(() {
//
//   if(DataUserLocal.isDriver)
//   SaveLocation();
//   else
//   getLocationDriverBuset();
// });

    //  getlocation();

    setState(() {
      initAccount();
    });

    // getLocation();
    //  allActionMap();

    // getLocation();

    // allActionMap();
    initAsync();
    //startTimeout();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var addresesLan;

  // final double lat = 21.420525330514568;
  // double long = 39.82268717139959;

  double lat = 0.000000;
  double long = 0.000000;

  int mmmm = 0;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000;

  // CountdownTimerController controller;
  // CountdownTimerController controller;

  // int _start = 10;
  // int _current = 10;
  //
  // void startTimer() {
  //   CountdownTimer countDownTimer = new CountdownTimer();
  // }

  Widget _buildProfileImage() {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          textBaseline: TextBaseline.alphabetic,
          textDirection: ui.TextDirection.rtl,
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
              textDirection: ui.TextDirection.rtl,
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

  GlobalKey _globalKey = GlobalKey();
  bool isAdd = false;

  double count = 0.56056456;

  _createFirestMarker(LatLng _kMapCenter, String tital) {
    if (_markerIcon != null) {
      _markers.add(Marker(
        markerId: MarkerId('first'),
        position: _kMapCenter,
        infoWindow: InfoWindow(
          title: tital,
        ),
        icon: _markerIcon,
      ));

      // pointsssss=[];

    } else {
      // setState(() {
      //   // _markers.add(Marker(
      //   //   markerId: MarkerId("${id}"),
      //   //   position: _kMapCenter,
      //   // ));
      // });
    }
  }

  _createLastMarker(LatLng _kMapCenter, String tital) {
    // count + 0.05465489479;

    //_addMarker(_kMapCenter, "${count}");
    // double id = _kMapCenter.longitude * _kMapCenter.latitude * count;

    if (_markerLastIcon != null) {
      _markers.add(Marker(
        markerId: MarkerId("last"),
        position: _kMapCenter,
        infoWindow: InfoWindow(
          title: tital,
        ),
        icon: _markerLastIcon,
      ));
    } else {}
  }

  static LatLng latLng = new LatLng(28.2762667, 43.04941);

  // void _onAddMarkerButtonPressed() {
  //   setState(() {
  //     _markers.add(Marker(
  //       markerId: MarkerId("111"),
  //       position: latLng,
  //       icon: BitmapDescriptor.defaultMarker,
  //     ));
  //   });
  // }

  Completer<GoogleMapController> _controllers = Completer();

  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  void startTimer() async {
    // if (DataUserLocal.isDriver)
    // Future.delayed(Duration(milliseconds: counterTow == 1 ? 10 : 500),
    //     () async => await SaveLocation());
//    else
//       Future.delayed(Duration(milliseconds: counterTow == 1 ? 10 : 200),
//           () async => await getLocationDriverBuset());
    setState(() {
      counterTow++;
      // createRoute(pointsssss.toString(), latLng, pointsssss);
    });
  }

  bool _driverMode = false;

  onTapDriveMode() {
    setState(() {
      _driverMode == true ? _driverMode = true : _driverMode = false;
    });

    // setState(() {
    //   _driverMode = true;
    // });
    // if (iiiiiiiiiiiiiii == 1) {
    //   _position = new CameraPosition(
    //     target: latLng,
    //     tilt: 56.440717697143555,
    //     zoom: 19.151926040649414,
    //
    //     bearing: 192.8334901395799,
    //
    //     // zoom: 16,
    //   );
    //   if (mapController != null)
    //     mapController.moveCamera(CameraUpdate.newCameraPosition(_position));
    // }

    setState(() {
      // _position = new CameraPosition(
      //   target: latLng,
      //   tilt: 56.440717697143555,
      //   zoom: 19.151926040649414,
      //
      //   bearing: 192.8334901395799,
      //
      //   // zoom: 16,
      // );

      if (mapController != null)
        mapController.moveCamera(CameraUpdate.newCameraPosition(_position));
    });
  }

  CameraPosition _position = new CameraPosition(
    target: latLng,
    tilt: 45,
    zoom: 19.151926040649414,
    bearing: 192.8334901395799,
  );
  int counter = 1;
  int counterTow = 1;

  void allActionMap() async {
    //  await initAccount();
    counter++;
    // Future.delayed(Duration(milliseconds: counter == 1 ? 10 : 500),
    //     () async => await getLocationDriverBuset());

    setState(() {
      //  counter++;
      _polyLines = _polyLines;

      latLng = latLng;
      latitudeDriver = latitudeDriver;
      longitudeDriver = longitudeDriver;
      longitudeMyLocation = longitudeMyLocation;
      latitudeMyLocation = latitudeMyLocation;

      //  counter++;
    });
  }

  String faris;
  final seen = Set<String>();
  List splite = [];
  List unique = [];
  int iiiiiiiiiiiiiii = 0;

  Future<List<Address>> _getAddresssss(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }

  //@override
  Widget build(BuildContext context) {
    setState(() {
      // allActionMap();
      //getLocationLast();
      // initAccount();
      //  CheckPermission();

      //  allActionMap();
    });
    setState(() {
      // If granted listen to the onLocationChanged stream and emit over our controller

      // location.enableBackgroundMode(enable: true);
      //location.changeSettings(accuracy: locations.LocationAccuracy.high,
      //interval: 100,
      //     distanceFilter: 5
      // );
      //location.changeSettings(accuracy: locations.LocationAccuracy.high,distanceFilter: 10,interval: 500  );
      // location.onLocationChanged.listen((locationData)  {
      //
      //   // if (locationData != null) {
      //   //
      //   //
      //   //
      //   //   print("Location Changed");
      //   //
      //   //   setState(() {
      //   //     idLocMark + 1;
      //   //     latitudeMyLocation = locationData.latitude;
      //   //     longitudeMyLocation = locationData.longitude;
      //   //     first =
      //   //     "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
      //   //         " ${addresses == null || addresses.length <= 0 ?" " : addresses[0].featureName}";
      //   //     loc = first;
      //   //
      //   //     latLng=LatLng(latitudeMyLocation, longitudeMyLocation);
      //   //     if (idLocMark ==1)
      //   //       // _createFirestMarker(
      //   //       //     LatLng(latitudeMyLocation, longitudeMyLocation),first);
      //   //       _createFirestMarker(latLng,"نقطة البداية "+"\n"+DataLast);
      //   //
      //   //     // _createLastMarker(LatLng(latitudeMyLocation, longitudeMyLocation),first);
      //   //
      //   //
      //   //
      //   //
      //   //       latLng = LatLng(latitudeMyLocation, longitudeMyLocation);
      //   //     // _addMarker(latLng, "${idLocMark}");
      //   //
      //   //     pointsssss.add(latLng);
      //   //
      //   //     ///  _addMarker(LatLng(latitudeDriver,longitudeDriver),"${TTTT}");
      //   //     ///
      //   //     // _polyLines.add(Polyline(
      //   //     //   color: ColorAPP.lightGreen,
      //   //     //   width: 10,
      //   //     //   points: pointsssss,
      //   //     //   polylineId: PolylineId("id"),
      //   //     // ));
      //   //
      //   //     DataLast = DateTime.now().year.toString() +
      //   //         " - " +
      //   //         DateTime.now().month.toString() +
      //   //         " - " +
      //   //         DateTime.now().day.toString() +
      //   //         " - ";
      //   //     DataLast = DateTime.now().toString();
      //   //
      //   //     setMarkser(latitudeMyLocation, longitudeMyLocation);
      //   //
      //   //     // pinList.add(
      //   //     //   MarkerDetails(
      //   //     //       idLocMark, LatLng(latitudeMyLocation, longitudeMyLocation),
      //   //     //       bigIcon: greenPin, smallIcon: bluePin),
      //   //     // );
      //   //
      //   //     first =
      //   //     "${addresses == null || addresses.length <= 0 ? "NULL" : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
      //   //         " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
      //   //     loc = first;
      //   //
      //   //     _createLastMarker(latLng, "نقطة البداية " + "\t" + DataLast);
      //   //
      //   //
      //   //     _position = new CameraPosition(
      //   //       target: latLng,
      //   //       tilt: 56.440717697143555,
      //   //       zoom: 19.151926040649414,
      //   //
      //   //       bearing: 192.8334901395799,
      //   //
      //   //       // zoom: 16,
      //   //     );
      //   //
      //   //
      //   //
      //   //     if (idLocMark != 1) {
      //   //       //   _markers.clear();
      //   //       //   latLngFir=LatLng(latitudeDriver, longitudeDriver);
      //   //       _createFirestMarker(latLng, "اخر موقف " + "\t" + DataLast);
      //   //     }
      //   //     // first = addresses[0];
      //   //     // //PRINT(i);
      //   //
      //   //     // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
      //   //     // markerList = _generateMarkerList(pinList, idLocMark);
      //   //     // _mapVertex =  MapVertex.fromLatLng(LatLng(latitudeMyLocation, longitudeMyLocation));
      //   //     // _overlays.add(TileOverlay(
      //   //     //   tileOverlayId: TileOverlayId('tile_overlay_${idLocMark}'),
      //   //     //   tileProvider: PointsTileProvider([_mapVertex]),
      //   //     // ));
      //   //     //
      //   //     // _overlays.add(TileOverlay(
      //   //     //   tileOverlayId: TileOverlayId('tile_overlay_1}'),
      //   //     //   tileProvider: PointsTileProvider([_mapVertex]),
      //   //     // ));
      //   //   });
      //   //
      //   //   final Coordinates coordinates = new Coordinates(
      //   //       locationData.latitude, locationData.longitude);
      //   //   // addresses =
      //   //   // await Geocoder.google(apiKey,language: "AR").findAddressesFromCoordinates(coordinates);
      //   //   setState(() {
      //   //
      //   //
      //   //     first=addresses;
      //   //
      //   //     _locationDriver =
      //   //
      //   //         LocationDriver(
      //   //           latitude: locationData.latitude,
      //   //           longitude: locationData.longitude,
      //   //           IMEI_device: getInfoDivice.identifier,
      //   //           Name_Location:  "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0  ? " " : addresses[0].postalCode},'
      //   //               " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}",);
      //   //
      //   //     _locationController.add(_locationDriver);
      //   //
      //   //    // SaveLocation(_locationDriver);
      //   //
      //   //
      //   //   });
      //   //   // print( "countryName ${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, subLocality ${addresses[0].subLocality == null ? " " : addresses[0].subLocality},'
      //   //   //     " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
      //   //   // _locationDriverApiProvider.addLocationDriver(_locationDriver);
      //   //   //
      //   //   // print( "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, adminArea ${addresses[0].adminArea == null ? " " : addresses[0].adminArea},'
      //   //   //     "featureName ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} , addressLine  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
      //   // }
      //   // else{
      //   //   print("locationData != null");
      //   //   print(locationData != null);
      //   // }
      // });

      setState(() {
        statuses = statuses;
      });
      // print("PermissionStatus.granted.isGranted");
      //  print(PermissionStatus.granted.isGranted);

      //   initAccount();
    });
    // location.enableBackgroundMode(enable: true);
    //  location.changeSettings(accuracy: locations.LocationAccuracy.high,
    //      interval: 100,
    //      distanceFilter: 5
    //  );
    //  if (statuses == PermissionStatus.granted) {
    //    // If granted listen to the onLocationChanged stream and emit over our controller
    //
    //
    //
    //    //location.changeSettings(accuracy: locations.LocationAccuracy.high,distanceFilter: 10,interval: 500  );
    //    location.onLocationChanged.listen((locationData)  {
    //
    //      if (locationData != null) {
    //
    //
    //
    //        print("Location Changed");
    //
    //        setState(() {
    //          idLocMark + 1;
    //          latitudeMyLocation = _locationDriver.latitude;
    //          longitudeMyLocation = _locationDriver.longitude;
    //          first =
    //          "${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
    //              " ${addresses == null || addresses.length <= 0 ?" " : addresses[0].featureName}";
    //          loc = first;
    //
    //          latLng=LatLng(latitudeMyLocation, longitudeMyLocation);
    //          if (idLocMark ==1)
    //            // _createFirestMarker(
    //            //     LatLng(latitudeMyLocation, longitudeMyLocation),first);
    //            _createFirestMarker(latLng,"نقطة البداية "+"\n"+DataLast);
    //
    //          // _createLastMarker(LatLng(latitudeMyLocation, longitudeMyLocation),first);
    //
    //          if (idLocMark == 1)
    //
    //
    //            latLng = LatLng(latitudeMyLocation, longitudeMyLocation);
    //          // _addMarker(latLng, "${idLocMark}");
    //
    //          pointsssss.add(latLng);
    //
    //          ///  _addMarker(LatLng(latitudeDriver,longitudeDriver),"${TTTT}");
    //          ///
    //          // _polyLines.add(Polyline(
    //          //   color: ColorAPP.lightGreen,
    //          //   width: 10,
    //          //   points: pointsssss,
    //          //   polylineId: PolylineId("id"),
    //          // ));
    //
    //          DataLast = DateTime.now().year.toString() +
    //              " - " +
    //              DateTime.now().month.toString() +
    //              " - " +
    //              DateTime.now().day.toString() +
    //              " - ";
    //          DataLast = DateTime.now().toString();
    //
    //          setMarkser(latitudeMyLocation, longitudeMyLocation);
    //
    //          // pinList.add(
    //          //   MarkerDetails(
    //          //       idLocMark, LatLng(latitudeMyLocation, longitudeMyLocation),
    //          //       bigIcon: greenPin, smallIcon: bluePin),
    //          // );
    //
    //          first =
    //          "${addresses == null || addresses.length <= 0 ? "NULL" : addresses[0].countryName},${addresses == null || addresses.length <= 0 ? " " : addresses[0].locality},"
    //              " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName}";
    //          loc = first;
    //
    //          _createLastMarker(latLng, "نقطة البداية " + "\t" + DataLast);
    //
    //
    //          _position = new CameraPosition(
    //            target: latLng,
    //            tilt: 56.440717697143555,
    //            zoom: 19.151926040649414,
    //
    //            bearing: 192.8334901395799,
    //
    //            // zoom: 16,
    //          );
    //
    //
    //
    //          if (idLocMark != 1) {
    //            //   _markers.clear();
    //            //   latLngFir=LatLng(latitudeDriver, longitudeDriver);
    //            _createFirestMarker(latLng, "اخر موقف " + "\t" + DataLast);
    //          }
    //          // first = addresses[0];
    //          // //PRINT(i);
    //
    //          // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
    //          // markerList = _generateMarkerList(pinList, idLocMark);
    //          // _mapVertex =  MapVertex.fromLatLng(LatLng(latitudeMyLocation, longitudeMyLocation));
    //          // _overlays.add(TileOverlay(
    //          //   tileOverlayId: TileOverlayId('tile_overlay_${idLocMark}'),
    //          //   tileProvider: PointsTileProvider([_mapVertex]),
    //          // ));
    //          //
    //          // _overlays.add(TileOverlay(
    //          //   tileOverlayId: TileOverlayId('tile_overlay_1}'),
    //          //   tileProvider: PointsTileProvider([_mapVertex]),
    //          // ));
    //        });
    //
    //        final Coordinates coordinates = new Coordinates(
    //            locationData.latitude, locationData.longitude);
    //        // addresses =
    //        // await Geocoder.google(apiKey,language: "AR").findAddressesFromCoordinates(coordinates);
    //        setState(() {
    //
    //
    //          first=addresses;
    //
    //          _locationDriver =
    //
    //              LocationDriver(
    //                latitude: locationData.latitude,
    //                longitude: locationData.longitude,
    //                IMEI_device: getInfoDivice.identifier,
    //                Name_Location:  "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0 ? " " : addresses[0].countryName},${addresses == null || addresses.length <= 0  ? " " : addresses[0].postalCode},'
    //                    " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}",);
    //
    //          _locationController.add(_locationDriver);
    //
    //          SaveLocation(_locationDriver);
    //
    //
    //        });
    //        // print( "countryName ${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, subLocality ${addresses[0].subLocality == null ? " " : addresses[0].subLocality},'
    //        //     " ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} ,  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
    //        // _locationDriverApiProvider.addLocationDriver(_locationDriver);
    //        //
    //        // print( "${addresses == null || addresses.length <= 0 ? '${addresses == null || addresses.length <= 0  ? " " : addresses[0].countryName}, adminArea ${addresses[0].adminArea == null ? " " : addresses[0].adminArea},'
    //        //     "featureName ${addresses == null || addresses.length <= 0 ? " " : addresses[0].featureName} , addressLine  ${addresses == null || addresses.length <= 0 ? " " : addresses[0].addressLine} '":" "}");
    //      }
    //    });
    //  }
    if (first != null && first.length > 0) {
      setState(() {
        faris = first.toString().replaceAll("null", " ");
        faris = first.toString().replaceAll(",", " ");
        // print(faris);

        // print(first);

        splite = faris.toString().split(" ");
        splite = faris.toString().split("  ");

        splite = faris.split(" ").toList();
        var distinctIds = splite.toSet().toList();
        //  print("splite : ${splite}");
        //  print("distinctIds : ${distinctIds}");

        distinctIds = distinctIds.toSet().toList();
        faris = distinctIds.toString();
        faris = faris.toString().replaceAll("[", "");
        faris = faris.toString().replaceAll("]", "");
        faris = faris.toString().replaceAll(",", " ");
        faris = faris.toString().replaceAll("null", "");

        faris = faris.toString().replaceAll("null", "");
        // print("faris : ${faris}");

        if (faris.length > 50) {
          faris = faris.substring(0, 50);
        }
      });

      setState(() {
        first = faris;
        //  print(first.toString().length);
      });
    } else {
      setState(() {
        first = "";
      });
    }
    setState(() {
      // getLocation();

      _createMarkerImageFromAsset(context);
      _createMarkerImageLastFromAsset(context);
    });

    setState(() {
      // _kGooglePlex = _kGooglePlex;

      // startTimer();

      // if (DataUserLocal.isDriver)
      // SaveLocation();

      // getLocationDriverBuset();

      //
      // if(DataUserLocal.isDriver==true)
      //   SaveLocation();
      // else
      //   getLocationDriverBuset();
      //
      //
      //

      if (DataUserLocal.isDriver == false) {
        counterTow++;
        // Future.delayed(Duration(milliseconds: counterTow == 1 ? 10 : 200),
        //         () async => await getLocationDriverBuset());
        // print("Is Parent");
      }
    });

    // getlocation();
    // if (DataScoolAndDriverChooseLocal.getDriverIdFromRefrences() == null &&
    //     DataScoolAndDriverChooseLocal.getDriverNameFromRefrences() == null &&
    //     DataScoolAndDriverChooseLocal.getSchooIdFromRefrences() == null &&
    //     DataScoolAndDriverChooseLocal.getSchooNameFromRefrences() == null) {
    //   //getlocation();
    //   return Center(
    //       child: CircularProgressIndicator(
    //           backgroundColor: ColorAPP.colorWhite,
    //           valueColor: AlwaysStoppedAnimation<Color>(ColorAPP.lightGreen)));
    // }

    // if(DataUserLocal.isDriver){
    //
    //
    // }

    setState(() {
      // if(DataUserLocal.isParent) {
      //   iiiiiiiiiiiiiii++;
      //   Future.delayed(Duration(milliseconds: iiiiiiiiiiiiiii == 1 ? 10 : 1000),
      //           () async => await allActionMap());
      // }
      // Future.delayed(Duration(milliseconds: iiiiiiiiiiiiiii == 1 ? 10 : 500),
      //         () async => await SaveLocation());

      // ();
      // if(iiiiiiiiiiiiiii.isEven){
      //   ();
      // }
      latLng = latLng;
      latitudeMyLocation = latitudeMyLocation;
      longitudeMyLocation = longitudeMyLocation;
      latLng = latLng;
      latitudeDriver = latitudeDriver;
      longitudeDriver = longitudeDriver;
      longitudeMyLocation = longitudeMyLocation;
      latitudeMyLocation = latitudeMyLocation;
      polyLinesss = polyLinesss;
      iiiiiiiiiiiiiii++;
      latLng = latLng;

      // if(mapController!= null)
      // mapController.moveCamera(CameraUpdate.newLatLngZoom(latLng,  19.151926040649414,));
      //
    });

    //getlocation();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: SizedBox(
          width: double.infinity,
          child: Drawer(
            elevation: 16,
            child: Container(
              color: Colors.black,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                      title: Text('Some context here',
                          style: TextStyle(color: Colors.white))),
                  ListTile(
                      title: Text('Some context here',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ),
        ),
        endDrawerEnableOpenDragGesture: false,
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            dragStartBehavior: DragStartBehavior.start,

            children: [
              DrawerHeader(
                key: _globalKey,
                decoration: BoxDecoration(
                  gradient: RadialGradient(tileMode: TileMode.clamp, colors: [
                    ColorAPP.BlackColor.withOpacity(0.2),
                    ColorAPP.BlackColor.withOpacity(0.2),
                    ColorAPP.BlackColor.withOpacity(0.2),
                    ColorAPP.BlackColor.withOpacity(0.2),
                    ColorAPP.BlackColor.withOpacity(0.2),
                    ColorAPP.BlackColor.withOpacity(0.2),
                    ColorAPP.BlackColor.withOpacity(0.2),
                  ]),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/personProfile.jpg'),
                  ),
                  color: AppColors.baseDarkPinkColor,
                ),
                child: Container(
                  // height: height,
                  // width: width,
                  child: _buildProfileImage(),
                ),
              ),
              Divider(
                height: 1,
                thickness: 10,
                color: ColorAPP.lightGreen,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: AppColors.baseDarkPinkColor,
                ),
                enabled: true,
                title: const Text(
                  'الرئيسية',
                  style: TextStyle(
                    color: AppColors.baseDarkPinkColor,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => HomeScrean()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: AppColors.baseDarkPinkColor,
                ),
                enabled: true,
                title: const Text(
                  'الصفحة الشخصية',
                  style: TextStyle(
                    color: AppColors.baseDarkPinkColor,
                  ),
                ),
                onTap: () {
                  DataUserLocal.isDriver == false
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ProfileParentScreen()))
                      : DataUserLocal.isDriver
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => ProfileBusDriverScreen()))
                          : null;
                },
              ),
              DataUserLocal.isParent
                  ? ListTile(
                      leading: Icon(
                        Icons.directions_railway,
                        color: AppColors.baseDarkPinkColor,
                      ),
                      enabled: true,
                      title: const Text(
                        'صفحة السائق',
                        style: TextStyle(
                          color: AppColors.baseDarkPinkColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ProfileBusDriverScreen()));
                      },
                    )
                  : Container(),
              Divider(
                height: 1,
                thickness: 3,
                color: ColorAPP.lightGreen,
              ),
              DataUserLocal.isParent
                  ? ListTile(
                      leading: Icon(
                        Icons.school,
                        color: AppColors.baseDarkPinkColor,
                      ),
                      enabled: true,
                      title: const Text(
                        'تغير المدرسة',
                        style: TextStyle(
                          color: AppColors.baseDarkPinkColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => ChooseSchoolScrean()));
                      },
                    )
                  : Container(),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: AppColors.baseDarkPinkColor,
                ),
                enabled: true,
                title: const Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    color: AppColors.baseDarkPinkColor,
                  ),
                ),
                onTap: () async {
                  await DataUserLocal.Logout();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => LogInScrean()));
                },
              ),
              Divider(
                height: 1,
                thickness: 3,
                color: ColorAPP.lightGreen,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: AppColors.baseDarkPinkColor,
                ),
                enabled: false,
                title: const Text(
                  'الاعدادات',
                  style: TextStyle(
                    color: AppColors.baseDarkPinkColor,
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: AppColors.baseDarkPinkColor,
                ),
                enabled: false,
                title: const Text(
                  'حول التطبيق',
                  style: TextStyle(
                    color: AppColors.baseDarkPinkColor,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.baseWhiteColor,

          actionsIconTheme:
              IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("موقع السائق"),

          leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: Icon(
              Icons.menu, // add custom icons also
            ),
          ),

          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.more_vert),
                )),
          ],
        ),
        body: DataUserLocal.isDriver == false
            ?
            //Data.dataLocationDriver.length<=0?
            //      Center(
            // child: CircularProgressIndicator(
            // backgroundColor: ColorAPP.colorWhite,
            //     valueColor: AlwaysStoppedAnimation<Color>(ColorAPP.lightGreen)))

            Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                      polylines: polyLinesss,
                      indoorViewEnabled: true,
                      mapType: MapType.hybrid,
                      markers: _markers,
                      onCameraMoveStarted: () {
                        setState(() {
                          _position = new CameraPosition(
                            target: latLng,
                            //  bearing: 45 ,

                            //  tilt: 50 ,
                            tilt: 59.440717697143555,
                            zoom: 19.151926040649414,
                            bearing: 192.8334901395799,

                            // zoom: 16,
                          );
                        });
                      },
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      buildingsEnabled: true,
                      //tiltGesturesEnabled: true,

                      initialCameraPosition: _position,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        // _controller.complete(controller);
                        //_onMapCreated(controller);

                        setState(() {
                          mapController = controller;

                          // controller.animateCamera(CameraUpdate.newLatLngZoom(
                          //     latLng, 19.151926040649414));
                          // mapController = controller;
                          //   mapController.moveCamera(CameraUpdate.newLatLngZoom(
                          //     latLng,
                          //     19.151926040649414,
                          //   ));
                          //
                          //   mapController.moveCamera(
                          //       CameraUpdate.newCameraPosition(_position));
                        });
                        //_onMapCreated(controller);
                      }),
                ),
                Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.report_problem,
                              color: Colors.grey,
                            ),
                            Column(
                              children: [
                                Text(
                                    "         حدوث عطل في السيارة بطريق عبد العزيز        "),
                                SingleChildScrollView(
                                  child: Text(
                                    " تم اصلاح العطل",
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
                  //buildChooseSchoolAndBisesDriver(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            Column(children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              Text(
                                "أخر ظهور",
                                style: TextStyle(fontSize: 14),
                              ),
                            ]),
                            Column(
                              children: [
                                Text(
                                  "${first},",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  " ",
                                  style: TextStyle(fontSize: 10),
                                ),
                                SingleChildScrollView(
                                  child: Text(
                                    " ${DataLast}",
                                    style: TextStyle(fontSize: 14),
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
                ]),
                // Center(
                //   child: Container(
                //     child: IconButton(
                //       icon: Icon(
                //         Icons.location_on,
                //         color: AppColors.baseDarkPinkColor,
                //       ),
                //       color: AppColors.baseDarkPinkColor,
                //       iconSize: 40,
                //     ),
                //   ),
                // ),

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
                                setState(() {
                                  onTapDriveMode();

                                  if (mapController != null)
                                    mapController.moveCamera(
                                        CameraUpdate.newCameraPosition(
                                            _position));
                                });

                                // Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         builder: (ctx) =>
                                //             AddProblemScreen()));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.drive_eta_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  Text(
                                    " وضع القيادة ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              ))
                        ]))),
                // DataUserLocal.isDriver
                //     ? Align(
                //         alignment: Alignment(0.0, 0.9),
                //         child: Container(
                //             height: 50,
                //             // color: ColorAPP.lightGreen,
                //             width: 120,
                //             decoration: BoxDecoration(
                //               color: ColorAPP.lightGreen,
                //               borderRadius: BorderRadius.circular(20),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: ColorAPP.lightGreen.withOpacity(0.8),
                //                   blurRadius: 4,
                //                   offset: Offset(4, 8), // Shadow position
                //                 ),
                //               ],
                //             ),
                //             child: Row(children: [
                //               TextButton(
                //                   style: TextButton.styleFrom(
                //                     primary: ColorAPP.lightGreen,
                //                     onSurface: ColorAPP.BlackColor,
                //                   ),
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                         MaterialPageRoute(
                //                             builder: (ctx) =>
                //                                 AddProblemScreen()));
                //                   },
                //                   child: Row(
                //                     children: [
                //                       Icon(
                //                         Icons.add_location_alt,
                //                         color: Colors.white,
                //                         size: 20,
                //                       ),
                //                       Text(
                //                         " إضافة مشكلة ",
                //                         style: TextStyle(
                //                             color: Colors.white, fontSize: 16),
                //                       )
                //                     ],
                //                   ))
                //             ])))
                //     : Container(),
              ])
            : Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    polylines: polyLinesss,
                    indoorViewEnabled: true,

                    mapType: MapType.hybrid,
                    markers: _markers,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,

                    onCameraMoveStarted: () {
                      setState(() {
                        //   CheckPermission();

                        //SaveLocation(_locationDriver);
                        _position = new CameraPosition(
                          target: latLng,
                          //  bearing: 45 ,

                          //  tilt: 50 ,
                          tilt: 59.440717697143555,
                          zoom: 19.151926040649414,
                          bearing: 192.8334901395799,

                          // zoom: 16,
                        );
                      });
                    },

                    zoomControlsEnabled: true,

                    zoomGesturesEnabled: true,

                    buildingsEnabled: true,
                    //tiltGesturesEnabled: true,

                    initialCameraPosition: _position,

                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      //_onMapCreated(controller);
                      mapController = controller;

                      setState(() {
                        // controller.animateCamera(CameraUpdate.newLatLngZoom(
                        //     latLng, 19.151926040649414));
                        // mapController = controller;
                        mapController.moveCamera(CameraUpdate.newLatLngZoom(
                          latLng,
                          19.151926040649414,
                        ));

                        mapController.moveCamera(
                            CameraUpdate.newCameraPosition(_position));
                      });
                    },
                  ),
                ),
                Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.report_problem,
                              color: Colors.grey,
                            ),
                            Column(
                              children: [
                                Text(
                                    "         حدوث عطل في السيارة بطريق عبد العزيز        "),
                                SingleChildScrollView(
                                  child: Text(
                                    " تم اصلاح العطل",
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
                  //buildChooseSchoolAndBisesDriver(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            Column(children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey,
                              ),
                              Text(
                                "أخر ظهور",
                                style: TextStyle(fontSize: 14),
                              ),
                            ]),
                            Column(
                              children: [
                                Text(
                                  "${first},",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  " ",
                                  style: TextStyle(fontSize: 10),
                                ),
                                SingleChildScrollView(
                                  child: Text(
                                    " ${DataLast}",
                                    style: TextStyle(fontSize: 14),
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
                ]),
                // Center(
                //   child: Container(
                //     child: IconButton(
                //       icon: Icon(
                //         Icons.location_on,
                //         color: AppColors.baseDarkPinkColor,
                //       ),
                //       color: AppColors.baseDarkPinkColor,
                //       iconSize: 40,
                //     ),
                //   ),
                // ),
                DataUserLocal.isDriver
                    ? Align(
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                AddProblemScreen()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_location_alt,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      Text(
                                        " إضافة مشكلة ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ))
                            ])))
                    : Align(
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
                                    onTapDriveMode();

                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (ctx) =>
                                    //             AddProblemScreen()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.drive_eta_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      Text(
                                        " وضع القيادة ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ))
                            ]))),

                DataUserLocal.isDriver == false
                    ? Align(
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
                                    onTapDriveMode();

                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (ctx) =>
                                    //             AddProblemScreen()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.drive_eta_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      Text(
                                        " وضع القيادة ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ))
                            ])))
                    : Align(
                        alignment: Alignment(-1.0, 0.9),
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
                                    onTapDriveMode();
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (ctx) =>
                                    //             AddProblemScreen()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_location_alt,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      Text(
                                        " وضع القيادة ",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )
                                    ],
                                  ))
                            ])))
              ]),
      ),
    );
  }
}

class MarkerDetails {
  final int key;
  final LatLng position;
  final BitmapDescriptor bigIcon;
  final BitmapDescriptor smallIcon;

  MarkerDetails(this.key, this.position,
      {@required this.bigIcon, @required this.smallIcon});
}

//const apiKey = "AIzaSyBOnp_PY0tImyFRmPa62MgLlfFt5TP2doM";
const apiKey = "AIzaSyBOnp_PY0tImyFRmPa62MgLlfFt5TP2doM";

// print("${PathAPI.PATH_MAIN_API}/api/v1/LocationDriverBus/${IMEI_device}/");

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    // String urls = "https://?=,${l1.longitude}&destination=${},${l2.longitude}&key=$apiKey";
    var unencodedPath = '/maps/api/directions/json';

    Map<String, dynamic> queryParameters = {
      "origin": "${l1.latitude},${l1.longitude}",
      "destination": "${l2.latitude},${l2.longitude}",
      "key": "${apiKey}",
    };
    var url = Uri.https("maps.googleapis.com", unencodedPath, queryParameters);

    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    // print(values);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}

// class MapVertex {
//   final LatLng latLng;
//   final Offset worldCoordinate;
//
//   MapVertex(this.latLng, this.worldCoordinate);
//
//   static const int tile_size = 256;
//   static const _origin = tile_size / 2;
//   static const double _pixelsPerLonDegree = tile_size / 360;
//   static const double _pixelsPerLonRadian = tile_size / (2 * pi);
//
//   factory MapVertex.fromLatLng(LatLng latLng) {
//     double siny = sin((latLng.latitude * pi) / 180);
//     siny = min(max(siny, -0.9999), 0.9999);
//     double wX = tile_size * (0.5 + latLng.longitude / 360);
//     double wY = tile_size * (0.5 - log((1 + siny) / (1 - siny)) / (4 * pi));
//     return MapVertex(latLng, Offset(wX, wY));
//   }
//
//   factory MapVertex.fromWorldCoordinate(Offset worldCoordinate) {
//     var lng = (worldCoordinate.dx - _origin) / _pixelsPerLonDegree;
//     var latRadians = (worldCoordinate.dy - _origin) / -_pixelsPerLonRadian;
//     var lat = (2 * atan(exp(latRadians)) - pi / 2) / (pi / 180);
//     return MapVertex(LatLng(lat, lng), worldCoordinate);
//   }
//
//
//   Offset inTileCoordinate(int zoom) {
//     final int scale = 1 << zoom;
//     final wc = worldCoordinate * scale.toDouble();
//     final int x = (wc.dx / MapVertex.tile_size).floor();
//     final int y = (wc.dy / MapVertex.tile_size).floor();
//     final dx = (wc.dx - MapVertex.tile_size * x);
//     final dy = (wc.dy - MapVertex.tile_size * y);
//
//     return Offset(dx, dy);
//   }
//
// }
//
// extension GMapExtensions on MapVertex {
//   Offset pixelCoordinateForZoom(int zoom) {
//     final int scale = 1 << zoom;
//     return worldCoordinate * scale.toDouble();
//   }
//
//
//   Point<int> tileCoordinateForZoom(int zoom) {
//     final large = pixelCoordinateForZoom(zoom);
//     return Point((large.dx / MapVertex.tile_size).floor(),
//         (large.dy / MapVertex.tile_size).floor());
//   }
//
//   bool isInTile(int zoom, int x, int y) {
//     Point<int> tile = tileCoordinateForZoom(zoom);
//     return tile.x == x && tile.y == y;
//   }
// }
//
// class PointsTileProvider implements TileProvider {
//   final List<MapVertex> verticies;
//   final paint = Paint()..color = Colors.red;
//
//   PointsTileProvider(this.verticies);
//
//   @override
//   Future<Tile> getTile(int x, int y, int zoom) async {
//     if (zoom == null) {
//       return TileProvider.noTile;
//     }
//     final filteredVerticies = verticies.where((v) => v.isInTile(zoom, x, y));
//
//     if (filteredVerticies.isNotEmpty) {
//       final ui.PictureRecorder recorder = ui.PictureRecorder();
//       final Canvas canvas = Canvas(recorder);
//       for (var v in filteredVerticies) {
//         canvas.drawCircle(
//             v.inTileCoordinate(zoom), 3, paint);
//       }
//       final ui.Picture picture = recorder.endRecording();
//       final Uint8List byteData = await picture
//           .toImage(MapVertex.tile_size, MapVertex.tile_size)
//           .then((ui.Image image) =>
//           image.toByteData(format: ui.ImageByteFormat.png))
//           .then((ByteData byteData) => byteData.buffer.asUint8List());
//       return Tile(MapVertex.tile_size, MapVertex.tile_size, byteData);
//     }
//     return TileProvider.noTile;
//   }
// }
