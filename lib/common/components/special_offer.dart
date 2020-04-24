import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/common/components/Section.dart';
import 'package:flutterhotelbookingapp/model/deal.dart';
import 'package:flutterhotelbookingapp/utils/constants.dart';

class SpecialOfferComponent extends StatefulWidget {
  @override
  _SpecialOfferComponentState createState() => _SpecialOfferComponentState();
}

class _SpecialOfferComponentState extends State<SpecialOfferComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              "assets/images/icons/ic_discount.png",
              width: 20,
              height: 20,
              color: Color(0xFF3443fa),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Special Offer",
              style: kHeadingextStyle,
            ),
            Spacer(),
            Text(
              "See All",
              style: kSubheadingextStyle.copyWith(
                  color: Color(0xFF282b3a), fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 7),
              child: Icon(
                Icons.arrow_forward,
                color: Color(0xFF3443fa),
                size: 20,
              ),
            )
          ],
        ),
        SpecialOfferList()
      ],
    );
  }
}

class SpecialOfferList extends StatelessWidget {
  List<Widget> generateList(BuildContext context) {
    List<Widget> list = [];
    int count = 0;
    List<DealModel> dealModels = [
      DealModel("1", "assets/images/deal/deal1.jpg"),
      DealModel("2", "assets/images/deal/deal2.jpg"),
      DealModel("2", "assets/images/deal/deal3.jpg"),
      DealModel("2", "assets/images/deal/deal4.jpg"),
      DealModel("2", "assets/images/deal/deal5.jpg"),
      DealModel("2", "assets/images/deal/deal6.jpg"),
      DealModel("2", "assets/images/deal/deal7.jpg"),
      DealModel("2", "assets/images/deal/deal8.jpg"),
    ];
    dealModels.forEach((dealModel) {
      Widget element = Container(
        margin: EdgeInsets.only(right: 0.0),
        child: GestureDetector(
          child: SpecialOfferCard(
            dealModel: dealModel,
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

class SpecialOfferCard extends StatefulWidget {
  DealModel dealModel;

  SpecialOfferCard({this.dealModel});

  @override
  _SpecialOfferCardState createState() => _SpecialOfferCardState();
}

class _SpecialOfferCardState extends State<SpecialOfferCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double localWidth = size.width * 0.75;
    return Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(0),
        width: 280,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(widget.dealModel.image),
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
                    widget.dealModel.id,
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
