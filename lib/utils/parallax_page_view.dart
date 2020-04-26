import 'package:flutter/material.dart';
import 'package:flutterhotelbookingapp/utils/parallax_sliding_card.dart';

class ParallaxPageView extends StatefulWidget {
  final double viewportFraction;
  final int height;
  final List<ISlidingCard> data;
  final void Function(ISlidingCard) onCardTap;

  ParallaxPageView({
    this.viewportFraction = 1,
    this.height = 500,
    this.data,
    this.onCardTap,
  });

  @override
  _ParallaxPageViewState createState() => _ParallaxPageViewState(
      viewportFraction: viewportFraction, height: height, data: data);

  static RectTween createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }
}

class _ParallaxPageViewState extends State<ParallaxPageView>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  final double viewportFraction;
  final int height;
  final List<ISlidingCard> data;
  final void Function(ISlidingCard) onCardTap;

  _ParallaxPageViewState({
    this.viewportFraction,
    this.height,
    this.data,
    this.onCardTap,
  });

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: viewportFraction);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: Container(
        height: widget.height.toDouble(),
        child: AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              return PageView.builder(
                controller: pageController,
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  final page = (pageController.position.pixels == null ||
                          (pageController.position.minScrollExtent != null &&
                              pageController.position.maxScrollExtent != null)
                      ? pageController.page
                      : 0.0);
                  return SlidingCard(
                    height: widget.height,
                    viewportFraction: viewportFraction,
                    title: widget.data[index].cardTitle(),
                    subTitle: widget.data[index].cardSubTitle(),
                    imageAssetName: widget.data[index].cardImageAsset(),
                    offset: page - index,
                    position: index,
                    onCardTap: (position) =>
                        widget.onCardTap(widget.data[position]),
                  );
                },
              );
            }),
      ),
    );
  }
}

class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
