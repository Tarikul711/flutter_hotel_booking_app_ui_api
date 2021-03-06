import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/common/components/hotel_list.dart';
import 'package:flutterhotelbookingapp/common/components/popular_destination.dart';
import 'package:flutterhotelbookingapp/common/components/special_offer.dart';
import 'package:flutterhotelbookingapp/common/widgets/appbar_widget.dart';
import 'package:flutterhotelbookingapp/common/widgets/search_widget.dart';
import 'package:flutterhotelbookingapp/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBarWidget(context),
            SizedBox(height: 10),
            Text("Hi Tarikul!", style: kHeadingextStyle),
            Row(
              children: <Widget>[
                Text("You are in ".toUpperCase(), style: kSubheadingextStyle),
                Text("Dhaka, Bangladesh".toUpperCase(),
                    style: kHighlitedSubheadingTextStyle),
              ],
            ),
            SizedBox(height: 10),
            SearchWidget(),
            SizedBox(height: 10),
            PopularDestination(),
            SizedBox(height: 15),
            SpecialOfferComponent(),
            SizedBox(height: 15),
            HotelListComponent(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
