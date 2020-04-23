import 'package:flutter/material.dart';

Widget appBarWidget(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Image.asset("assets/images/icons/ic_home_menu.png",width: 24,height: 24,color: Colors.black87,),
      Image.asset("assets/images/icons/user.png",width: 34,height: 34,),
    ],
  );
}
