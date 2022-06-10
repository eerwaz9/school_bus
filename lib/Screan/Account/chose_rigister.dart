import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_ksa/lib/ApiProvider/APiInlocoParentis.dart';
import 'package:school_ksa/lib/DataBase/DBProviderUser.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Model/input_format.dart';
import 'package:school_ksa/lib/Widget/ButtonChoseCreateAccount.dart';
import 'package:school_ksa/lib/Widget/button_create_account_and_logIn_in_head.dart';
import 'package:school_ksa/lib/Widget/text_field_card.dart';

import '../../../main.dart';
import 'RigisterBusDriver.dart';
import 'RigisterParent.dart';
import 'logIn.dart';

class ChoseCreateAccount extends StatefulWidget {
  _ChoseCreateAccountState createState() => _ChoseCreateAccountState();
}

class _ChoseCreateAccountState extends State<ChoseCreateAccount> {
  File _image;

  Future _getImage() async {
    //var image = await ImagePicker.(source: ImageSource.gallery);
    setState(() {
      //  _image = image;
    });
  }

  final picker = ImagePicker();

  var image;

  var pickedFile;

  Future getImage() async {
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

  DBProviderUser db = new DBProviderUser();
  ParentApiProvider userApi;

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

  DBProviderUser DB;

  @override
  initState() {
    super.initState();

    userApi = new ParentApiProvider();

    EmileController.addListener(_printLatestValue);
    PassowrdController.addListener(_printLatestValue);
    DB = new DBProviderUser();
    getdataaccount();
  }

  bool _obscureText = true;
  String _username, _email, _password;
  bool _isSubmitting;
  bool _isVrifyOtp = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final DateTime timestamp = DateTime.now();
  Color colorIcon = ColorAPP.lightGreen;
  bool visablebassowrd = true;
  Icon iconVisableandnonvisable = Icon(Icons.visibility);
  bool checkforconvortImage = true;
  final EmileController = TextEditingController();
  final PassowrdController = TextEditingController();
  final FullNameController = TextEditingController();
  final userNamedController = TextEditingController();
  final phoneNoController = TextEditingController();
  double pi = 3.1415926535897932;
  var datenow = new DateTime.now();
  List<Map> UserAccountData;

  Widget build(BuildContext context) {
    // TODO: implement build
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                ButtonCreateAccountAndLoginInHead(
                  isCreateAccount: true,
                  onPreasCreateAccount: () {},
                  onPreasLogIn: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => LogInScrean()));
                  },
                ),
                Container(
                  child: Container(
                    padding: EdgeInsets.only(top: 180),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
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
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 10.0, sigmaY: 10.0),

                                    // filter: ImageFilter.blur(
                                    //    sigmaX: 10.0,
                                    //    sigmaY: 10.0,
                                    //  ),
                                    child: Container(
                                      color: Colors.black.withOpacity(0),
                                      child: Column(
                                        children: <Widget>[
                                          TextButton(
                                            child: Container(
                                                child: Container(
                                              //width: MediaQuery.of(context).size.width,
                                              height: 150,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: ColorAPP.lightGreen,
                                                    blurRadius: 100,
                                                    offset: Offset.infinite,
                                                    //spreadRadius: 100000
                                                  ),
                                                ],
                                                color: Colors.white38,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(20.0),
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                    bottomRight:
                                                        Radius.circular(20.0)),
                                              ),

                                              child: buildButtonProfileImage(
                                                  context),
                                            )),

                                            onPressed: getImage,

                                            //onTap: getImage,
                                          ),
                                          TextInputTextCard(
                                            labelTxt: "الأسم كاملأ",
                                            hintTxt: "أدخل اسمك الرباعي",
                                            textinputaction:
                                                TextInputAction.done,
                                            isPassword: false,
                                            controller: this.FullNameController,
                                            iconsTextFild: Icon(
                                              Icons.person,
                                              color: colorIcon,
                                            ),
                                            textinputtype: TextInputType.text,
                                            inputFormatter: InputFormat
                                                .FullNameInputFormatters,
                                          ),
                                          TextInputTextCard(
                                            labelTxt: "الايميل",
                                            hintTxt: "ادخل الايميل",
                                            textinputaction:
                                                TextInputAction.done,
                                            isPassword: false,
                                            controller: this.EmileController,
                                            iconsTextFild: Icon(
                                              Icons.email,
                                              color: colorIcon,
                                            ),
                                            textinputtype:
                                                TextInputType.emailAddress,
                                            inputFormatter: InputFormat
                                                .EmileinputFormatters,
                                          ),
                                          TextInputTextCard(
                                            labelTxt: "رقم التلفون",
                                            hintTxt: "ادخل رقم التلفون",
                                            textinputaction:
                                                TextInputAction.done,
                                            isPassword: false,
                                            controller: this.phoneNoController,
                                            iconsTextFild: Icon(
                                              Icons.phone_android,
                                              color: colorIcon,
                                            ),
                                            textinputtype: TextInputType.phone,
                                            inputFormatter: InputFormat
                                                .PhoneInputFormatters,
                                          ),
                                          TextInputTextCard(
                                            labelTxt: " اسم المستخدم",
                                            hintTxt: "أدخل اسم المستخدم",
                                            textinputaction:
                                                TextInputAction.done,
                                            isPassword: false,
                                            controller:
                                                this.userNamedController,
                                            iconsTextFild: Icon(
                                              Icons.person,
                                              color: colorIcon,
                                            ),
                                            textinputtype: TextInputType.name,
                                            inputFormatter: InputFormat
                                                .UserNameInputFormatters,
                                          ),
                                          TextInputTextCard(
                                            labelTxt: "كلمة المرور",
                                            hintTxt: "أدخل كلمة المرور",
                                            textinputaction:
                                                TextInputAction.done,
                                            isPassword: true,
                                            controller: this.PassowrdController,
                                            iconsTextFild: Icon(
                                              Icons.vpn_key,
                                              color: colorIcon,
                                            ),
                                            textinputtype:
                                                TextInputType.visiblePassword,
                                            visablebassowrd: visablebassowrd,
                                            inputFormatter: [],
                                            suffixIcon: IconButton(
                                                icon: iconVisableandnonvisable,
                                                onPressed: () {
                                                  setState(() {
                                                    if (checkforconvortImage) {
                                                      visablebassowrd = false;
                                                      checkforconvortImage =
                                                          false;
                                                      iconVisableandnonvisable =
                                                          Icon(
                                                              Icons
                                                                  .visibility_off,
                                                              color: ColorAPP
                                                                  .lightGreen);
                                                    } else {
                                                      visablebassowrd = true;
                                                      checkforconvortImage =
                                                          true;
                                                      iconVisableandnonvisable =
                                                          Icon(
                                                        Icons.visibility,
                                                        color:
                                                            ColorAPP.lightGreen,
                                                      );
                                                    }
                                                  });
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 4.0, sigmaY: 4.0),
                                  child: Container(
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Container(
                                          padding:
                                              EdgeInsets.only(top: width / 2),
                                          child: Center(
                                            child: Column(children: <Widget>[
                                              ButtonChoseAccount(
                                                textTitle:
                                                    "أنشاء حساب كسائق باص ",
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  CreateAccountBusDriver()));
                                                },
                                              ),
                                              ButtonChoseAccount(
                                                textTitle:
                                                    "أنشاء حساب كولي أمر  ",
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  CreateAccountParent()));
                                                },
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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

      onTap: () => getImage,

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

                onTap: () => getImage,

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

    List<Map> UserAccountData = await DB.fetchUserAccount();

    //PRINT("list.length   list.length  list.length list.length ");

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
