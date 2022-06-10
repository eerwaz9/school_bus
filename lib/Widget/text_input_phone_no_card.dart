import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

class TextInputPhoneNoCard extends StatelessWidget {
  Widget suffixIcon;
  final String labelTxt;
  final String hintTxt;
  final TextInputType textinputtype;
  final Icon iconsTextFild;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatter;
  final TextInputAction textinputaction;

  final ValueChanged<PhoneNumber> onInputChanged;

  final PhoneNumber initialValue;
  bool onSubmit = false;
  TextInputPhoneNoCard(
      {this.initialValue,
      @required this.onInputChanged,
      @required this.labelTxt,
      @required this.hintTxt,
      @required this.textinputtype,
      @required this.iconsTextFild,
      @required this.controller,
      @required this.inputFormatter,
      @required this.textinputaction});
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
        border: Border.all(
          color: onSubmit
              ? ColorAPP.lightGreen
              : ColorAPP.colorWhite.withOpacity(0.0),
          width: 2.0,
        ),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0),
            topLeft: Radius.circular(50.0),
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0)),
      ),
      margin: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
      child: InternationalPhoneNumberInput(
        //countries: ["يمن","saudia"],

        spaceBetweenSelectorAndTextField: 0,
        onInputChanged: (PhoneNumber number) {
          onInputChanged(number);
        },
        onSubmit: () {
          onSubmit = true;
        },
        onInputValidated: (bool value) {
          print(value);
        },
        isEnabled: true,
        hintText: hintTxt,
        textAlignVertical: TextAlignVertical.bottom,

        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
        ),
        ignoreBlank: true,

        inputDecoration: InputDecoration(
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
        keyboardAction: textinputaction,
        cursorColor: ColorAPP.lightGreen,

        textStyle: TextStyle(color: ColorAPP.lightGreen),

        searchBoxDecoration: InputDecoration(
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
          fillColor: Colors.white,
        ),

        autoValidateMode: AutovalidateMode.onUserInteraction,
        errorMessage: "قم بأدخل رقم صحيح",
        autoFocusSearch: false,
        //selectorButtonOnErrorPadding: 10,
        locale: "SA",
        autoFocus: false,
        textAlign: TextAlign.left,

        selectorTextStyle: TextStyle(color: ColorAPP.lightGreen, fontSize: 10),
        countrySelectorScrollControlled: false,

        initialValue: initialValue,

        textFieldController: this.controller,
        formatInput: true,

        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: ColorAPP.lightGreen),
            borderRadius: BorderRadius.circular(80.0)),
        onSaved: (PhoneNumber number) {
          print('On Saved: $number');
        },
      ),

      // TextField(
      //
      //   inputFormatters: inputFormatter,
      //
      //   controller: controller,
      //   decoration: InputDecoration(
      //       suffixIcon: isPassword?suffixIcon:null,
      //       filled: true,
      //       enabledBorder:OutlineInputBorder(
      //
      //           borderSide:BorderSide(width: 2,color: ColorAPP.lightGreen),
      //           borderRadius: BorderRadius.circular(80.0)
      //       ),
      //       prefixIcon: iconsTextFild,
      //       labelText: labelTxt,
      //       hoverColor: ColorAPP.lightGreen,
      //       focusColor: ColorAPP.lightGreen,
      //       labelStyle: TextStyle(fontSize: 20,color:ColorAPP.lightGreen,decorationColor: ColorAPP.lightGreen),
      //       hintText: hintTxt,
      //       hintStyle: TextStyle(fontSize: 20,color:ColorAPP.lightGreen ,decorationColor:ColorAPP.lightGreen),
      //       fillColor: Colors.white
      //   ),
      //   keyboardType: textinputtype,
      //   cursorColor: ColorAPP.lightGreen,
      //   cursorRadius: Radius.circular(5.0),
      //   style: TextStyle(color:ColorAPP.lightGreen),
      //
      //   textInputAction: textinputaction,
      //   obscureText: visablebassowrd==null?false:visablebassowrd,
      //
      // ),
    );
  }
}
