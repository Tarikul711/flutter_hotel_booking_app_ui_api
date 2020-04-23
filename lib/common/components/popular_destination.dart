import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/common/components/Section.dart';
import 'package:flutterhotelbookingapp/common/components/circular_progress.dart';
import 'package:flutterhotelbookingapp/model/destination.dart';
import 'package:flutterhotelbookingapp/utils/Urls.dart';
import 'package:flutterhotelbookingapp/utils/constants.dart';
import 'package:http/http.dart';

class PopularDestination extends StatefulWidget {
  @override
  _PopularDestinationState createState() => _PopularDestinationState();
}

class _PopularDestinationState extends State<PopularDestination> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              "assets/images/icons/ic_popular.png",
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Popular Destinations",
              style: kHeadingextStyle,
            ),
          ],
        ),
        DestinationList(),
      ],
    );
  }
}

class DestinationList extends StatelessWidget {
  List<Widget> generateList(BuildContext context, AsyncSnapshot snapshot) {
    List<Widget> list = [];
    int count = 0;
    List<Destination> destinations = snapshot.data;
    destinations.forEach((destination) {
      Widget element = Container(
        margin: EdgeInsets.only(right: 0.0),
        child: GestureDetector(
          child: PopularDestinationCard(
            destination: destination,
          ),
          onTap: () {},
        ),
      );
      list.add(element);
      count++;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDestinationList(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgress();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return Section(
                horizontalList: this.generateList(context, snapshot),
              );
        }
      },
    );
  }
}

class PopularDestinationCard extends StatefulWidget {
  Destination destination;

  PopularDestinationCard({this.destination});

  @override
  _PopularDestinationCardState createState() => _PopularDestinationCardState();
}

class _PopularDestinationCardState extends State<PopularDestinationCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double localWidth = size.width * 0.75;
    return Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(20),
        width: 160,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(widget.destination.image),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 55),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.black87.withOpacity(0.12),
                  child: Text(
                    widget.destination.name,
                    style: kTitleTextStyle.copyWith(
                      fontSize: 18,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 30.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.black87.withOpacity(0.12),
                  child: Text(
                    "${widget.destination.hotelCount} Hotels",
                    style: kTitleTextStyle.copyWith(
                      fontSize: 14,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 30.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

List<Destination> categories;

Future<List<Destination>> getDestinationList() async {
  if (categories == null) {
    Response response;
    response = await get(Urls.POPULAR_DESTINATION);
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    if (statusCode == 200) {
      categories = (body as List).map((i) => Destination.fromJson(i)).toList();

      return categories;
    } else {
      return categories = List();
    }
  } else {
    return categories;
  }
}
