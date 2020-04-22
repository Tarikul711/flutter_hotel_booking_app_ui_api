import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/screen/home_screen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'PlayfairDisplay', hintColor: Color(0xFFd0cece)),
      home: HomeScreen(),
    ));
