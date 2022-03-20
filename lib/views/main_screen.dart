import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solution_challenge_2022/theme/theme_config.dart';
import 'package:solution_challenge_2022/util/dialogs.dart';
import 'package:solution_challenge_2022/views/explore/explore.dart';
import 'package:solution_challenge_2022/views/home/home.dart';
import 'package:solution_challenge_2022/views/settings/settings.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:solution_challenge_2022/views/videos/Videos.dart';

import '../commons/const.dart';
import '../controllers/FBCloudMessaging.dart';
import 'camera/Camera.dart';
import 'feed/Feed.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}
String? emailtopost;
Future <void >myEmail(String email) async {
  emailtopost = email;
}

class _MainScreenState extends State<MainScreen> {
  late MyProfileData myData;
  late PageController _pageController;
  bool _isLoading = false;
  int _page = 0;
  static String? realName;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Feather.camera, size:30, color: Colors.white),
      Icon(Feather.video, size:30, color: Colors.white),
      Icon(Feather.book_open, size:30, color: Colors.white),
      Icon(Feather.users, size:30, color: Colors.white),
      Icon(Feather.settings, size:30, color: Colors.white)
    ];
    return WillPopScope(
      onWillPop: () => Dialogs().showExitDialog(context),
      child: Scaffold(
        extendBody: true,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[Camera(), Videos(), Home(), Feed(), Profile()],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: Theme.of(context).primaryColor,
          items: items,
          height: 55,
          backgroundColor: Colors.transparent,

          // backgroundColor: Theme.of(context).primaryColor,
          // selectedItemColor: Theme.of(context).accentColor,
          // unselectedItemColor: Colors.grey[500],
          // elevation: 20,
          // type: BottomNavigationBarType.fixed,
          // items: <BottomNavigationBarItem>[
          //   BottomNavigationBarItem(
          //     icon: Icon(Feather.camera),
          //     label: 'Camera',
          //   ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Feather.video),
          //     label: 'Videos',
          //   ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Feather.book_open),
          //     label: 'Book',
          //   ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Feather.users),
          //     label: 'Feed',
          //   ),
          //   BottomNavigationBarItem(
          //     icon: Icon(Feather.settings),
          //     label: 'Settings',
          //   ),
          // ],
          onTap: navigationTapped,
          index: _page,
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
    FBCloudMessaging.instance.takeFCMTokenWhenAppLaunch();
    _pageController = PageController(initialPage: 0);
    setupMyName();
  }
  Future<void>setupMyName() async{
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('Users').doc(emailtopost).collection('Profile');
    collectionReference.snapshots().listen((snapshot) {
      print(snapshot.docs[0]['Name'].toString());
      realName = snapshot.docs[0]['Name'];
      _takeMyData();
    });
  }

  Future<void> _takeMyData() async{
    setState((){
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myThumbnail;
    String? myName;
    if (prefs.get('myThumbnail') == null) {
      String tempThumbnail = 'user.png';
      prefs.setString('myThumbnail',tempThumbnail);
      myThumbnail = tempThumbnail;
    }else{
      myThumbnail = 'user.png';
    }
    if (prefs.get('myName') == null){
      String tempName = realName!;
      prefs.setString('myName',tempName);
      myName = tempName;
    }else{
      myName = prefs.get('myName') as String?;}

    if(myName != realName){
      String tempName = realName!;
      prefs.setString('myName',tempName);
      myName = tempName;
    }
    setState(() {
      myData = MyProfileData(
        myThumbnail: myThumbnail,
        myName: myName!,
        myLikeList: prefs.getStringList('likeList')!,
        myLikeCommnetList: prefs.getStringList('likeCommnetList')!,
        myFCMToken: prefs.getString('FCMToken'),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
  void updateMyData(MyProfileData newMyData) {
    setState(() {
      myData = newMyData;
    });
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
