import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rbocw/pages/profile.dart';
import 'package:rbocw/pages/setting.dart';
import 'package:rbocw/scoped-model/main.dart';

import '../providers/app_data.dart';
import 'EditUserRegister.dart';
import 'benificiary.dart';
import 'dashboardPage.dart';
import 'newUserRegister.dart';

class HomePage extends StatefulWidget {
  final MainModel model;
  const HomePage({Key key, this.model}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titles = ['Home', 'Benificiary', 'Profile', 'Edit'];
  //final colors = [Colors.purple, Colors.teal, Colors.green, Colors.cyan];
  final colors = [AppData.kPrimaryColor, AppData.kPrimaryColor, AppData.kPrimaryColor, AppData.kPrimaryColor];
  final icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_add,
    CupertinoIcons.profile_circled,
    CupertinoIcons.settings
  ];
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Bubbled Navigation Bar'),
        // ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            checkUserDragging(scrollNotification);
          },
          child: PageView(
            physics: new NeverScrollableScrollPhysics(),
            controller: _pageController,
            // children: colors.map((Color c) => Container(color: c)).toList(),
            children: <Widget>[
              DashboardPage(),
              BenificiaryPage(),
              ProfilePage(),
              //SettingPage()
              EditUserRegister()
            ],
            onPageChanged: (page) {},
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          controller: _menuPositionController,
          initialIndex: 0,
          itemMargin: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Colors.white,
          defaultBubbleColor: Colors.blue,
          onTap: (index) {
            _pageController.animateToPage(index,
                curve: Curves.easeInOutQuad,
                duration: Duration(milliseconds: 500));
          },
          items: titles.map((title) {
            var index = titles.indexOf(title);
            var color = colors[index];
            return BubbledNavigationBarItem(
              icon: getIcon(index, color),
              activeIcon: getIcon(index, Colors.white),
              bubbleColor: color,
              title: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          }).toList(),
        ));
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(icons[index], size: 30, color: color),
    );
  }
}
