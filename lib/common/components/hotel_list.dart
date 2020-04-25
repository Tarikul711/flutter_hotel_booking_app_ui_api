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
    childAspectRatio: 8.0 / 8.0,
    children: List<Widget>.generate(hotels.length, (index) {
      return GridTile(
        child: HotelItemCard(
          hotel: hotels[index],
        ),
      );
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
  Widget newAbc(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, top: 10, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.network(
                widget.hotel.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${widget.hotel.name}",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF))),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "BDT ${widget.hotel.rate.toInt()}",
                         style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* return Container(
        margin: EdgeInsets.only(right: 20, top: 15, bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(widget.hotel.thumbnail),
            fit: BoxFit.fill,
          ),
        ),
        child: Text(""));*/
    return newAbc(context);
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
