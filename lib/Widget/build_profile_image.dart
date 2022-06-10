import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'buildFullName.dart';
import 'buildStatItemUserName.dart';

class BuildProfileImage extends StatelessWidget {
  final String username;
  final String fullName;
  BuildProfileImage(this.username, this.fullName);
  @override
  Widget build(BuildContext context) {
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
            buildFullName(
              fullName: fullName,
            ),
            BuildStatItemUserName(
              Icons: Icons.person,
              count: username,
            )
          ]),
        ),
      ],
    );
  }
}
