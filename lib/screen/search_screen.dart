import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/common/widgets/appbar_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBarWidget(context),
            Align(
              alignment: Alignment.center,
              child: Text("Coming Soon"),
            ),
          ],
        ),
      ),
    );
  }
}
