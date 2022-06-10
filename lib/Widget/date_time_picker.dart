import 'dart:ui' as ui;

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

class BasicDateTimeField extends StatelessWidget {
  Widget suffixIcon;
  final String labelTxt;
  final String hintTxt;
  final TextInputType textinputtype;
  final Icon iconsTextFild;
  final TextEditingController controller;
  final TextInputAction textinputaction;

  BasicDateTimeField({
    @required this.labelTxt,
    @required this.hintTxt,
    @required this.textinputtype,
    @required this.iconsTextFild,
    @required this.controller,
    @required this.textinputaction,
  });
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
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
        child: DateTimeField(
          controller: controller,
          decoration: InputDecoration(
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
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                textDirection: ui.TextDirection.rtl,
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
        ),
      ),
    ]);
  }
}
