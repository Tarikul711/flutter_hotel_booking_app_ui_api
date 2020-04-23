import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/common/components/Section.dart';
import 'package:flutterhotelbookingapp/model/destination.dart';
import 'package:flutterhotelbookingapp/utils/constants.dart';

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
              width: 24,
              height: 24,
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
  final List<Destination> destinations = [
    Destination(
      image: "assets/images/popular_destination/cox_bazar.jpg",
      title: 'Cox Bazar',
      slug: '5 min',
    ),
    Destination(
      image: "assets/images/popular_destination/sylet.jpg",
      title: 'Sylhet',
      slug: '10 min',
    ),
    Destination(
      image: "assets/images/popular_destination/saint_martin.jpg",
      title: 'Saint Martin',
      slug: '25 min',
    ),
    Destination(
      image: "assets/images/popular_destination/sundarban.jpg",
      title: 'Sundarban',
      slug: '5 min',
    ),
    Destination(
      image: "assets/images/popular_destination/london.jpg",
      title: 'London',
      slug: '25 min',
    ),
  
  ];

  List<Widget> generateList(BuildContext context) {
    List<Widget> list = [];
    int count = 0;
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
    return Section(
      horizontalList: this.generateList(context),
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
    Size size = MediaQuery
        .of(context)
        .size;
    double localWidth = size.width * 0.75;
    return Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.all(20),
        width: 220,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(widget.destination.image),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Text(
                widget.destination.title,
                style: kTitleTextStyle,
              ),
            ),
          ),
        ));
  }
}
