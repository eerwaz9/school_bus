import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_ksa/lib/Model/StaticVirable.dart';

class ButtonChoseAccount extends StatelessWidget {
  Function onPressed;
  final textTitle;
  ButtonChoseAccount({@required this.textTitle, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      margin: EdgeInsets.all(15),
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
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) return Colors.red;
            if (states.contains(MaterialState.hovered)) return Colors.green;
            if (states.contains(MaterialState.pressed))
              return ColorAPP.lightGreen;
            return null; // Defer to the widget's default.
          }),
        ),
        child: Row(
          children: <Widget>[
            new Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height / 12)),
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            new Padding(padding: EdgeInsets.only(left: 15)),
            Text(
              textTitle,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )
          ],
        ),
        onPressed: () async {
          await onPressed();
        },
      ),
    ));
  }
}
