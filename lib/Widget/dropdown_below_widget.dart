import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

class DropdownBelowWidget extends StatelessWidget {
  final selectedTest;
  final dropdownTestItems;
  final onChangeDropdownTests;
  final tital;
//https://mubus.pythonanywhere.com/api/v1/DriverBus/?id=&Full_Name=&school=1&Email=&IMEI_device=&password=&session_no=&UserName=&PhoneNo=&keyVerify=&Data_Update=&Date_Added=&KeyActiveStatus=&school__School_Name=&school__id=&school__Name_Location=
  DropdownBelowWidget(
      {@required this.selectedTest,
      @required this.dropdownTestItems,
      @required this.onChangeDropdownTests,
      @required this.tital});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        //width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 100,
              offset: Offset.lerp(Offset.zero, Offset.infinite, 30),
              //spreadRadius: 100000
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.0),
              topLeft: Radius.circular(50.0),
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0)),
        ),
        margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
        child: DropdownBelow(
          itemWidth: 350,

          itemTextstyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: ColorAPP.lightGreen),
          boxTextstyle: TextStyle(
              fontSize: 20,
              color: ColorAPP.lightGreen,
              decorationColor: ColorAPP.lightGreen),

          // elevation: 100,
          boxHeight: 70,
          icon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: ColorAPP.lightGreen,
          ),
          boxWidth: 400,

          hint: Text(
            tital,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 20,
                color: ColorAPP.lightGreen,
                decorationColor: ColorAPP.lightGreen),
          ),
          value: selectedTest,

          isDense: true,
          boxDecoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.grey,
                blurRadius: 100,
                offset: Offset.lerp(Offset.zero, Offset.infinite, 30),
                //spreadRadius: 100000
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50.0),
                topLeft: Radius.circular(50.0),
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0)),
          ),
          items: dropdownTestItems,

          onChanged: onChangeDropdownTests,
        ),
      ),
    );
  }
}
