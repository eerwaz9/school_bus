import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

class TextInputTextCard extends StatelessWidget {
  Widget suffixIcon;
  final String labelTxt;
  final String hintTxt;
  final TextInputType textinputtype;
  final Icon iconsTextFild;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatter;
  final TextInputAction textinputaction;
  final bool isPassword;
  bool visablebassowrd;
  TextInputTextCard(
      {@required this.labelTxt,
      @required this.hintTxt,
      @required this.textinputtype,
      @required this.iconsTextFild,
      @required this.controller,
      @required this.inputFormatter,
      @required this.textinputaction,
      @required this.isPassword,
      this.suffixIcon,
      this.visablebassowrd});
  @override
  Widget build(BuildContext context) {
    controller.text.toLowerCase();
    controller.text.toLowerCase();
    return Container(
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
        color: ColorAPP.lightGreen,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0),
            topLeft: Radius.circular(50.0),
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0)),
      ),
      margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
      child: TextField(
        inputFormatters: inputFormatter,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: isPassword ? suffixIcon : null,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: ColorAPP.lightGreen),
                borderRadius: BorderRadius.circular(80.0)),
            prefixIcon: iconsTextFild,
            labelText: labelTxt,
            hoverColor: ColorAPP.lightGreen,
            focusColor: ColorAPP.lightGreen,
            labelStyle: TextStyle(
                fontSize: 20,
                color: ColorAPP.lightGreen,
                decorationColor: ColorAPP.lightGreen),
            hintText: hintTxt,
            hintStyle: TextStyle(
                fontSize: 20,
                color: ColorAPP.lightGreen,
                decorationColor: ColorAPP.lightGreen),
            fillColor: Colors.white),
        keyboardType: textinputtype,
        cursorColor: ColorAPP.lightGreen,
        cursorRadius: Radius.circular(5.0),
        style: TextStyle(color: ColorAPP.lightGreen),
        textInputAction: textinputaction,
        obscureText: visablebassowrd == null ? false : visablebassowrd,
      ),
    );
  }
}
