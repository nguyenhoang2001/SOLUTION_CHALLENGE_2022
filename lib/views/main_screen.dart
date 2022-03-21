import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_2022/theme/theme_config.dart';
import 'package:solution_challenge_2022/util/dialogs.dart';
import 'package:solution_challenge_2022/views/explore/explore.dart';
import 'package:solution_challenge_2022/views/home/home.dart';
import 'package:solution_challenge_2022/views/settings/settings.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:solution_challenge_2022/views/videos/Videos.dart';

import 'camera/Camera.dart';
import 'feed/Feed.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Feather.camera, size:30, color: Colors.white),
      Icon(Feather.book_open, size:30, color: Colors.white),
      Icon(Feather.users, size:30, color: Colors.white),
      Icon(Feather.settings, size:30, color: Colors.white)
    ];
    return WillPopScope(
      onWillPop: () => Dialogs().showExitDialog(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: SafeArea(
          child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[Camera(), Home(), Feed(), Profile()],
        ),
        ),
        bottomNavigationBar: BottomNavyBar(
          showElevation: true,
          // color: Theme.of(context).primaryColor,
          // items: items,
          // height: 55,
          // backgroundColor: Colors.transparent,

          // backgroundColor: Theme.of(context).primaryColor,
          // selectedItemColor: Theme.of(context).accentColor,
          // unselectedItemColor: Colors.grey[500],
          // elevation: 20,
          // type: BottomNavigationBarType.fixed,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Feather.camera),
              title: Text('Camera'),
            ),
            BottomNavyBarItem(
              icon: Icon(Feather.book_open),
              title: Text('Book'),
            ),
            BottomNavyBarItem(
              icon: Icon(Feather.users),
              title: Text('Feed'),
            ),
            BottomNavyBarItem(
              icon: Icon(Feather.settings),
              title: Text('Settings'),
            ),
          ],
          onItemSelected: navigationTapped,
          selectedIndex: _page,
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
