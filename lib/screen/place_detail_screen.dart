import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/common/components/sliding_bottom_sheet.dart';
import 'package:flutterhotelbookingapp/common/widgets/blur_icon.dart';
import 'package:flutterhotelbookingapp/utils/parallax_page_view.dart';
import 'package:flutterhotelbookingapp/utils/theme.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:rect_getter/rect_getter.dart';

class PlaceDetailScreen extends StatefulWidget {
  final String heroTag;
  final String imageAsset;

  PlaceDetailScreen({
    this.heroTag,
    this.imageAsset,
  });

  @override
  _PlaceDetailScreenState createState() =>
      _PlaceDetailScreenState(heroTag: heroTag, imageAsset: imageAsset);
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen>
    with SingleTickerProviderStateMixin {
  final String heroTag;
  final String imageAsset;
  final double bottomSheetCornerRadius = 50;

  final Duration animationDuration = Duration(milliseconds: 600);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  _PlaceDetailScreenState({
    this.heroTag,
    this.imageAsset,
  });

  static double bookButtonBottomOffset = -60;
  double bookButtonBottom = bookButtonBottomOffset;
  AnimationController _bottomSheetController;
  @override
  void initState() {
    super.initState();
    _bottomSheetController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    Future.delayed(Duration(milliseconds: 700)).then((v) {
      setState(() {
        bookButtonBottom = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ApplicationThemeProvider.get();
    final coverImageHeightCalc =
        MediaQuery.of(context).size.height / 3 + bottomSheetCornerRadius;
    return WillPopScope(
      onWillPop: () async {
        if (_bottomSheetController.value <= 0.5) {
          setState(() {
            bookButtonBottom = bookButtonBottomOffset;
          });
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(),
            Hero(
              createRectTween: ParallaxPageView.createRectTween,
              tag: heroTag,
              child: Container(
                height: coverImageHeightCalc,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: PageIndicatorContainer(
                      align: IndicatorAlign.bottom,
                      length: 3,
                      indicatorSpace: 12.0,
                      padding: EdgeInsets.only(bottom: 60),
                      indicatorColor: themeData.indicatorColor,
                      indicatorSelectorColor: Colors.white,
                      shape: IndicatorShape.circle(size: 8),
                      child: PageView(
                        children: <Widget>[
                          Image.network(
                            imageAsset,
                            fit: BoxFit.cover,
                          ),
                          /*Image.asset(
                            "img/hotel_2.jpg", // <- stubbed data
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "img/hotel_3.jpg", // <- stubbed data
                            fit: BoxFit.cover,
                          ),*/
                        ],
                      ),
                    )),
              ),
            ),
            Positioned(
              top: 46,
              right: 24,
              child: Hero(
                tag: "${heroTag}heart",
                child: BlurIcon(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 15.2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 46,
              left: 24,
              child: Hero(
                tag: "${heroTag}chevron",
                child: GestureDetector(
                  onTap: () async {
                    await _bottomSheetController.animateTo(0,
                        duration: Duration(milliseconds: 150));
                    setState(() {
                      bookButtonBottom = bookButtonBottomOffset;
                    });
                    Navigator.pop(context);
                  },
                  child: BlurIcon(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            SlidingBottomSheet(
              controller: _bottomSheetController,
              cornerRadius: bottomSheetCornerRadius,
            ),
            _ripple(themeData),
          ],
        ),
      ),
    );
  }

  Widget _ripple(ThemeData themeData) {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeData.accentColor,
        ),
      ),
    );
  }
}
