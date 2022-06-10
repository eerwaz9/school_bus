import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_ksa/lib/Model/Data.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';
import 'package:school_ksa/lib/Widget/buildStatItemUserName.dart';
import 'package:school_ksa/lib/Widget/build_profile_image.dart';

class ProfileParentScreen extends StatefulWidget {
  @override
  _ProfileParentScreenState createState() => _ProfileParentScreenState();
}

class _ProfileParentScreenState extends State<ProfileParentScreen> {
  String _fullName;
  String _status;
  String _bio;

  String _followers;
  String _posts;
  String _username;

  MySharedPreferences MSharedPreferences = new MySharedPreferences();

  Future<List> datauser;
  String Messege;

  int IS_VERIFY_TEXT = 0;
  int linghUser = 0;
  int linghDriver = 0;
  initState() {
    // TODO: implement initState
    super.initState();

    _fullName = "MyBus";
    _status = "MyBus";
    _bio = "Ibrahim Alzoriqi";
    _followers = "+966 532270314";
    _username = "MyBus";
    _posts = "MyBus@MyBus.com";
    IS_VERIFY_TEXT = 1;
    _status = " ";
    _bio = " ";

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
