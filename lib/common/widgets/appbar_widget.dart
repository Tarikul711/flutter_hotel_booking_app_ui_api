import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/screen/sign_in_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget appBarWidget(context) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    title: Image.asset(
      "assets/images/ic_app_icon.png",
      width: 80,
      height: 40,
    ),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        },
        icon: Icon(FontAwesomeIcons.user),
        color: Color(0xFF323232),
      ),
    ],
  );
}
