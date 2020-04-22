import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterhotelbookingapp/common/widgets/appbar_widget.dart';
import 'package:flutterhotelbookingapp/utils/theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _controller;
  final List<Widget> tabBarScreens = [
    Container(color: Colors.green),
    Container(color: Colors.lightBlueAccent),
    Container(color: Colors.lightBlue),
    Container(color: Colors.blue),
    Container(color: Colors.blueAccent),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(
        length: tabBarScreens.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black.withAlpha(50),
        statusBarIconBrightness: Brightness.light));
    final themeData = ApplicationThemeProvider.get();
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: appBarWidget(context),
      body: TabBarView(
        controller: _controller,
        children: tabBarScreens,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: TabBar(
        controller: _controller,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.transparent,
        isScrollable: false,
        tabs: [
          _buildTabIcon("assets/images/icons/ic_home.png", 0, themeData),
          _buildTabIcon("assets/images/icons/ic_delete.png", 1, themeData),
          _buildTabIcon("assets/images/icons/ic_cart.png", 2, themeData),
          _buildTabIcon("assets/images/icons/ic_near_by.png", 3, themeData),
          _buildTabIcon("assets/images/icons/ic_search_menu.png", 4, themeData),
        ],
        onTap: (index) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildTabIcon(String assetName, int index, ThemeData themeData) {
    return Tab(
      icon: Image.asset(
        assetName,
        color: index == _controller.index
            ? themeData.accentColor
            : themeData.primaryColorLight,
      ),
    );
  }
}
