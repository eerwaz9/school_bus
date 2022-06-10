import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

class ButtonCreateAccountAndLoginInHead extends StatelessWidget {
  Function onPreasCreateAccount;
  Function onPreasLogIn;
  final bool isCreateAccount;
  ButtonCreateAccountAndLoginInHead(
      {@required this.isCreateAccount,
      @required this.onPreasCreateAccount,
      @required this.onPreasLogIn});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 100, right: 30, left: 40),
      //width: MediaQuery.of(context).size.width,
      height: 70,
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
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)),
      ),

      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2 - 35,
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                    color: ColorAPP.lightGreen,
                    blurRadius: 300,
                    offset: Offset.infinite,
                    spreadRadius: 0),
              ],
              color: isCreateAccount ? Colors.white : null,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused)) return Colors.red;
                  if (states.contains(MaterialState.hovered))
                    return Colors.green;
                  if (states.contains(MaterialState.pressed))
                    return ColorAPP.lightGreen;
                  return null; // Defer to the widget's default.
                }),
              ),
              child: Row(children: [
                Icon(
                  CupertinoIcons.add_circled_solid,
                  size: 17,
                  color: isCreateAccount ? ColorAPP.lightGreen : Colors.white70,
                ),
                Text(
                  "انشاء الحساب",
                  style: TextStyle(
                      fontSize: 17.0,
                      color: isCreateAccount ? Colors.black : Colors.white70),
                ),
              ]),
              onPressed: () {
                onPreasCreateAccount();
              },
            ),
            padding: EdgeInsets.all(10),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2 - 35,
            decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: ColorAPP.lightGreen,
                  blurRadius: 100,
                  offset: Offset.infinite,
                  //spreadRadius: 100000
                ),
              ],
              color: isCreateAccount ? null : Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused)) return Colors.red;
                  if (states.contains(MaterialState.hovered))
                    return Colors.green;
                  if (states.contains(MaterialState.pressed))
                    return ColorAPP.lightGreen;
                  return null; // Defer to the widget's default.
                }),
              ),
              child: Row(children: [
                Icon(
                  Icons.login,
                  size: 15,
                  color: isCreateAccount ? Colors.white70 : ColorAPP.lightGreen,
                ),
                Text(
                  "  تسجيل الدخول",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: isCreateAccount ? Colors.white70 : Colors.black),
                ),
              ]),
              onPressed: () {
                onPreasLogIn();
              },
            ),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    ));
  }
}
