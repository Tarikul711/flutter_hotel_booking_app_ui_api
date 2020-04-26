import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/common/components/circular_progress.dart';
import 'package:flutterhotelbookingapp/model/hotel_model.dart';
import 'package:flutterhotelbookingapp/screen/place_detail_screen.dart';
import 'package:flutterhotelbookingapp/utils/Urls.dart';
import 'package:flutterhotelbookingapp/utils/constants.dart';
import 'package:http/http.dart';

class HotelListComponent extends StatefulWidget {
  @override
  _HotelListComponentState createState() => _HotelListComponentState();
}

List<Hotel> hotels = List();

class _HotelListComponentState extends State<HotelListComponent> {
  bool isLoading = false;
  int pageNumber = 1;

  Widget requestForData(String pageNumber) {
    print("tarikul requestForData");
    return FutureBuilder(
      future: getHotelList(pageNumber),
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
    );
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 2));
    print("load more");
    setState(() {
      requestForData("2");
    });
  }

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
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            print(scrollInfo.metrics.maxScrollExtent);
            if (!isLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              print("tarikul pre noti");
              _loadData();
              // start loading data
              setState(() {
                print("tarikul noti");
                isLoading = true;
              });
            }
          },
          child: requestForData("$pageNumber"),
        ),
        Container(
          height: isLoading ? 50.0 : 0,
          color: Colors.transparent,
          child: Center(
            child: new CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  HotelModel hotelModel = snapshot.data;
//  hotels = hotelModel.hotels;
  hotels.addAll(hotelModel.hotels);
  return GridView.count(
    crossAxisCount: 2,
    physics: ScrollPhysics(),
    // to disable GridView's scrolling
    shrinkWrap: true,
    childAspectRatio: 8.0 / 8.0,
    children: List<Widget>.generate(hotels.length, (index) {
      return GridTile(
        child: InkResponse(
          child: HotelItemCard(
            hotel: hotels[index],
          ),
          onTap: () {

          },
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
  Widget hotelItemDesign(BuildContext context) {
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
    return hotelItemDesign(context);
  }
}

HotelModel hotelModel;

Future<HotelModel> getHotelList(String pageNumber) async {
  if (hotelModel == null) {
    Response response;
    response = await get(Urls.HOTEL_SAMPLE_LIST + pageNumber);
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
