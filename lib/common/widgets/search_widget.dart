import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/utils/constants.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: <Widget>[
            Image.asset("assets/images/icons/ic_search.png",color: kSearchIconColor,),
            SizedBox(width: 16),
            Text(
              "Search your destination / hotel",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF444444),
              ),
            )
          ],
        ),
      ),
    );
  }
}
