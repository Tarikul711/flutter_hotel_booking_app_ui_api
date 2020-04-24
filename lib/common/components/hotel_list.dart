import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/common/components/circular_progress.dart';
import 'package:flutterhotelbookingapp/model/hotel_model.dart';
import 'package:flutterhotelbookingapp/utils/Urls.dart';
import 'package:flutterhotelbookingapp/utils/constants.dart';
import 'package:http/http.dart';

class HotelListComponent extends StatefulWidget {
  @override
  _HotelListComponentState createState() => _HotelListComponentState();
}

class _HotelListComponentState extends State<HotelListComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset("assets/images/icons/ic_room.png",
                width: 20, height: 20, color: Color(0xFF3443fa)),
            SizedBox(
              width: 10,
            ),
            Text(
              "Featured for you",
              style: kHeadingextStyle,
            ),
          ],
        ),
        FutureBuilder(
          future: getHotelList(),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgress();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return createListView(context, snapshot);
            }
          },
        )
      ],
    );
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  HotelModel hotelModel = snapshot.data;
  List<Hotel> hotels = hotelModel.hotels;
  print("Hotel Length ${hotels.length}");
  return GridView.count(
    crossAxisCount: 2,
    physics: ScrollPhysics(),
    // to disable GridView's scrolling
    shrinkWrap: true,
    padding: EdgeInsets.all(1.0),
    /*childAspectRatio: 8.0 / 9.0,*/
    children: List<Widget>.generate(hotels.length, (index) {
      return GridTile(
          child: HotelItemCard(
        hotel: hotels[index],
      ));
    }),
  );
}

class HotelItemCard extends StatefulWidget {
  Hotel hotel;

  HotelItemCard({this.hotel});

  @override
  _HotelItemCardState createState() => _HotelItemCardState();
}

class _HotelItemCardState extends State<HotelItemCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double localWidth = size.width * 0.75;
    return Container(
        margin: EdgeInsets.only(right: 15, top: 15, bottom: 15),
        padding: EdgeInsets.all(20),
        width: 140,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(widget.hotel.thumbnail),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 35),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.black87.withOpacity(0.12),
                  child: Text(
                    widget.hotel.name,
                    style: kTitleTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

HotelModel hotelModel;

Future<HotelModel> getHotelList() async {
  if (hotelModel == null) {
    Response response;
    response = await get(Urls.HOTEL_SAMPLE_LIST);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    if (statusCode == 200) {
      hotelModel = HotelModel.fromJson(body);
      return hotelModel;
    } else {
      return hotelModel = HotelModel();
    }
  } else {
    return hotelModel;
  }
}
