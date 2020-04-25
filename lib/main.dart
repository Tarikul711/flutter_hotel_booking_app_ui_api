import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/screen/main_screen_controller.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'PlayfairDisplay', hintColor: Color(0xFFd0cece)),
      home: MainScreenController(),

    ));
