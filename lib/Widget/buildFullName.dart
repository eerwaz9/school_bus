import 'package:flutter/material.dart';

class buildFullName extends StatelessWidget {
  final fullName;
  buildFullName({

    @required this.fullName,
    });
  @override
  Widget build(BuildContext context) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return


       Text(
        fullName.split(" ")[0],
        style: _nameTextStyle,
      );
    }

}
