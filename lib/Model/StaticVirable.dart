import 'dart:io';
import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../main.dart';

class PathAPI {
  //static final String  PATH_MAIN_API="10.0.2.2:8000";

  static final String PATH_MAIN_API = "mubus.pythonanywhere.com";

  static final String Path_Media_From_Image = "https://${PATH_MAIN_API}/media/";
  static final String Path_Image_FromInternet =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREGn_koDG-N_HHuKu1zocU_GyY61yFLwyS5GRCrXpdT7cNB8yFjGAAKRH0n0RDU22r4Ds&usqp=CAU";
}

class OtpEmile {
  static bool data;

  static var _chars = '1234567890';
  static Random _rnd = Random();

  // String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
  //     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  static String getRondom;

  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.

  static void sendOtp(String Emiles) async {
    String username = 'project.my.bus@gmail.com';

    String password = "asd\$12345";

    getRondom = getRandomString(6);
    //prefs.setString("KeyVerifiEmile")

    prefs.setString("KeyVerifiEmile", getRondom);
    ////PRINT(getRondom);
    ////PRINT(prefs.getString("KeyVerifiEmile"));

    SmtpServer smtpServer = gmail(username, password);

    // try {
    //   // Setting up Google SignIn
    //   final googleSignIn = GoogleSignIn.standard(scopes: [
    //     'email',
    //     'https://www.googleapis.com/auth/gmail.send'
    //   ]);
    //
    //   // Signing in
    //   final account = await googleSignIn.signIn();
    //
    //   if (account == null) {
    //     // User didn't authorize
    //     return;
    //   }

    //final auth = await account.authentication;
    //   ////PRINT("auth.accessToken");
    //   ////PRINT(auth.accessToken);
    //   // Creating SMTP server from the access token
    //   smtpServer = gmailSaslXoauth2(username,);
    // } on PlatformException catch (e) {
    //   // TODO: Handle auth error
    //   ////PRINT(e);
    // }
    //

    // Create our message.
    final message = Message()
      ..from = Address(username, 'MyBus Project')
      ..recipients.add(Emiles)
      ..bccRecipients.add("ibrahim.alzoriqi@gmail.com")
      ..ccRecipients.add("ibrahim.alzoriqi@gmail.com")
      ..headers = {"ibrahim.alzoriqi@gmail.com": "ibrahim.alzoriqi@gmail.com"}
      ..subject =
          'التحقق من الأيميل عبر تطبيق حافلتي :: 😀 :: ${DateTime.now()}'
      ..text = 'كود التجقق هو ' + prefs.getString("KeyVerifiEmile")
      ..html =
          "<h1> حافلتي  </h1>\n<p>كود التحقق هو </p>  \n <h1>  ${prefs.getString("KeyVerifiEmile")} </h1>";
// Ready to send a message now
    //final sendReport = await send(message, smtpServer);

    // ///Accessing the OtpEmile class from the package
    // OtpEmile.sessionName = "My_Guide_At_My_Phone";
    // ///a boolean value will be returned if the OTP is sent successfully
    //
    // data= await OtpEmile.sendOtp(receiverMail: Emiles);
    //
    // if(!data){
    //   ////PRINT("ERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRROOOOOOOOORRR1");
    // }

    //final smtpServer = gmail(username, password);

    // Create our message.
    // final message = Message()
    //   ..from = Address(username, 'حافلتي')
    //   ..recipients.add(Emiles)
    //
    //   ..subject =
    //       'التحقق من الأيميل عبر تطبيق حافلتي :: 😀 :: ${DateTime.now()}'
    //   ..text =
    //       'كود التجقق هو ' + prefs.getString("KeyVerifiEmile")
    //   ..html =
    //       "<h1> حافلتي  </h1>\n<p>كود التحقق هو </p>  \n <h1>  ${prefs.getString("KeyVerifiEmile")} </h1>";

    try {
      final sendReport =
          await send(message, smtpServer, timeout: Duration(seconds: 15));
      ////PRINT(sendReport);

      ////PRINT(Emiles);
      ////PRINT('Message sent: ' + sendReport.toString());
      data = true;
    } on MailerException catch (e) {
      ////PRINT('Message not sent.');

      data = false;
      for (var p in e.problems) {
        data = false;
        ////PRINT('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  ///create a bool method to validate if the OTP is true
  static bool verify(String Emile, String userOTP) {
    bool veri = false;
    if (prefs.getString("KeyVerifiEmile") == userOTP) {
      ////PRINT(userOTP);

      ////PRINT(prefs.getString("KeyVerifiEmile"));
      veri = true;
    } else {
      // return(OtpEmile.validate(
      //     receiverMail:Emile, //to make sure the email ID is not changed
      //     userOTP: userOTP)); //pass in the OTP typed in
      ////PRINT(userOTP);

      ////PRINT(prefs.getString("KeyVerifiEmile"));

      veri = false;

      ///This will return you a bool, and you can proceed further after that, add a fail case and a success case (result will be true/false)
    }

    return veri;
  }
}

class MySharedPreferences {}

class FontApp {
  static var title_splash_font_wieght = FontWeight.bold;
  static var title_splash_font_Size = 20.0;
}

class ColorAPP {
  static final Color COLOR_TEXT_SPLASH_SCREAN_RGB =
      Color.fromARGB(255, 255, 255, 255);
  static final Color COLOR_TEXT_SPLASH_SCREAN_RGB_Whith_opcity =
      Color.fromARGB(255, 255, 255, 255).withOpacity(0.5);
  static final Color COLOR_TEXT_SPLASH_SCREAN = Color(0xFFFFFFFF);

  static var Color_side_bar = Color(0xFFFC0000).withOpacity(0.9);
  static var Color_Clip_Path = Color(0xFFFC0000).withOpacity(0.7);
  static var Color_Clip_Path_icon = Color(0xFFFFFFFF).withOpacity(0.9);

  static Color lightGreen = Color(0xFF2F1853);

  //static Color lightGreen = Color(0xFF90278E);
  //static Color lightGreen = Color(0xFFAC0056);

  // static Color lightGreen = Color(0xff4a40a1);
  static Color lightBlueIsh = Color(0xFF66BF61);
  static Color darkGreen = Color(0xFF66BF61);
  static Color backgroundColor = Color(0xFFFFFFFF).withOpacity(0.9);
  static Color colorWhite = Color(0xFFFFFFFF).withOpacity(0.3);
  static Color BlackColorWithOpacity = Color(0xFF000000).withOpacity(0.2);
  static Color BlackColor = Color(0xFF000000);

  static Color SkyColor = Color.fromARGB(255, 144, 143, 143);
}

class TypeAreaTextTable {
  static final String TABLE_TypeArea_NAME = "TypeArea";
  static final String ID_TYPE_AREA_TEXT = "id";
  static final String TYPE_TEXT = "Type";
  static final String DATE_UPDATE_TEXT = "Data_Update";
  static final String DATE_ADDED_TEXT = "Date_Added";
}

class DATABASE {
  static final String DB_NAME = "MyBuses.db";
  static final int OLD_DB_VERSION = 14;

  static final int DB_VERSION = 18;
}

class AreaTextTable {
  static final String AvrageRate_Text = "avrageRate";
  static final String CountUserRate_Text = "CountUserRated";
  static final String TotalStarRate_Text = "TotalStarRate";
  static final String TABLE_AREA_NAME = "Areas";
  static final String ID_AREA_TEXT = "id";
  static final String ID_CITY = "city";
  static final String area_name_TEXT = "area_name";
  static final String latitude_TEXT = "latitude";
  static final String longitude_TEXT = "longitude";
  static final String area_Discryption_TEXT = "area_Discryption";
  static final String NumberOfViews_TEXT = "NumberOfViews";
  static final String ID_Type_Area_TEXT = "Type_Area";
  static final String Image1_TEXT = "image1";
  static final String Image2_TEXT = "image2";
  static final String Image3_TEXT = "image3";
  static final String Image4_TEXT = "image4";

  static final String DATE_UPDATE_TEXT = "Data_Update";
  static final String DATE_ADDED_TEXT = "Date_Added";
}

class DriverBusesTextTable {
  static final String TABLE_DriverBuses_NAME = "DriverBuses";
  static final String ID_DriverBuses_TEXT = "idUserLocal";
  static final String ID_DriverBuses_API_TEXT = "id";

  static final String School_TEXT = "school";

  static final String FULL_NAME_TEXT = "Full_Name";
  static final String USERNAME_TEXT = "UserName";
  static final String PASSWORD_TEXT = "password";
  static final String EMAILE_TEXT = "Email";
  static final String KEY_VERIFY_TEXT = "keyVerify";
  static final String IS_VERIFY_TEXT = "isVerify";
  static final String SEESION_TEXT = "session_no";
  static final String PHONE_NO_TEXT = "PhoneNo";
  static final String IMEI_device_TEXT = "IMEI_device";
  static final String KEY_ACTIVE_STATUS_TEXT = "KeyActiveStatus";
  static final String DATE_UPDATE_TEXT = "Data_Update";
  static final String DATE_ADDED_TEXT = "Date_Added";
  static final String IMAGES_DriverBuses_TEXT = "images_user";
}

class UserTextTable {
  static final String TABLE_USER_NAME = "User";
  static final String ID_USER_TEXT = "idUserLocal";
  static final String ID_USER_API_TEXT = "id";

  static final String FULL_NAME_TEXT = "Full_Name";
  static final String USERNAME_TEXT = "UserName";
  static final String PASSWORD_TEXT = "password";
  static final String EMAILE_TEXT = "Email";
  static final String KEY_VERIFY_TEXT = "keyVerify";
  static final String IS_VERIFY_TEXT = "isVerify";
  static final String SEESION_TEXT = "session_no";
  static final String PHONE_NO_TEXT = "PhoneNo";
  static final String IMEI_device_TEXT = "IMEI_device";
  static final String KEY_ACTIVE_STATUS_TEXT = "KeyActiveStatus";
  static final String DATE_UPDATE_TEXT = "Data_Update";
  static final String DATE_ADDED_TEXT = "Date_Added";
  static final String IMAGES_USER_TEXT = "images_user";
}

class CityTextTable {
  static final String URL_IMAGE_CITY = "url";

  static final String TABLE_City_NAME = "City";
  static final String Id_City_TEXT = "id";
  static final String Name_City_TEXT = "City_Name";
  static final String Discryption_City_Text = "City_Discryption";
  static final String Images_city_TEXT = "images_city";
  static final String Data_Update_TEXT = "Data_Update";
  static final String Date_Added_TEXT = "Date_Added";
}

class ImageTextTable {
  static final String URL_IMAGE_AREA = "url";

  static final String TABLE_Image_NAME = "image";
  static final String Image_TEXT = "images";
  static final String Id_Image_TEXT = "id";
  static final String ID_Area_TEXT = "area";
  static final String Data_Update_TEXT = "Data_Update";
  static final String Date_Added_TEXT = "Date_Added";
}

class getInfoDivice {
  static String deviceName;
  static String deviceVersion;
  static String identifier;
  static String sysname;
  static String bootloader;
  static String securityPatch;
  static String sdkInt;
  static String release;
  static String previewSdkInt;
  static String incremental;
  static String manufacturer;
  static String tags;
  static String codeName;
  static String TypeDivice;
  static List<String> systemFeatures = [];

  static Future<String> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        TypeDivice = "isAndroid";
        deviceName = build.model;
        deviceVersion = build.id;
        identifier = build.androidId;
        sysname = build.fingerprint;
        bootloader = build.bootloader;
        bootloader = build.hardware;
        securityPatch = build.version.securityPatch;
        sdkInt = build.version.sdkInt.toString();
        release = build.version.release;
        previewSdkInt = build.version.previewSdkInt.toString();
        incremental = build.version.incremental;
        codeName = build.version.codename;
        /*  'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,*/
        /*'id': build.id,*/
        manufacturer = build.manufacturer;
        /*'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,*/
        tags = build.tags;
        /* 'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,*/

        for (int i = 0; i <= build.systemFeatures.length - 1; i++) {
          systemFeatures.add(build.systemFeatures.elementAt(i));
          //  ////PRINT("build.systemFeatures[i] $i ${build.systemFeatures[i]}");
        }
      } else if (Platform.isIOS) {
        TypeDivice = "isIOS";
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;

        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor;
        deviceVersion = data.utsname.version;
        sysname = data.utsname.sysname; //UUID for iOS
      }
    } on PlatformException {
      ////PRINT('Failed to get platform version');
    }
    // ////PRINT("release ${release}");
    // ////PRINT("sdkInt ${sdkInt}");
    // ////PRINT("identifier ${identifier}");
    // ////PRINT("deviceVersion ${deviceVersion}");
    // ////PRINT("deviceName ${deviceName}");
    // ////PRINT("sysname ${sysname}");
    // //PRINT("bootloader ${bootloader}");
    return identifier;
  }
}
