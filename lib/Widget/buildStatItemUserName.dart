import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildStatItemUserName extends StatelessWidget {
  final IconData Icons;
  final String count;

  BuildStatItemUserName({
    @required this.Icons,
  @required this.count

  });







  TextStyle _statCountTextStyle = TextStyle(
    color: Colors.black54,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {



    return   Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Icon(Icons,size: 20,color: Colors.black54,),
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
}
