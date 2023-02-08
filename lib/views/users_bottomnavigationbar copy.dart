import 'dart:async';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';
import 'package:ggc/views/profile.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../constants/app_colors.dart';
import '../controllers/announcements_controller.dart';
import '../controllers/checkin_controller.dart';
import '../controllers/devotion_controller.dart';
import '../controllers/events_controller.dart';
import '../controllers/notificationController.dart';
import '../controllers/userController.dart';
import '../members/views/members_dashboard.dart';
import '../members/views/members_notifications.dart';
import 'announcements.dart';
import 'checkins.dart';
import 'devotions.dart';


class UsersBottomNavigationBar extends StatefulWidget {
  const UsersBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _UsersBottomNavigationBarState createState() => _UsersBottomNavigationBarState();
}

class _UsersBottomNavigationBarState extends State<UsersBottomNavigationBar> {
  final storage = GetStorage();
  late String username = "";
  late String uToken = "";
  int selectedIndex = 0;
  late PageController pageController;
  bool hasInternet = false;
  late StreamSubscription internetSubscription;
  NotificationController notificationController = Get.find();
  late List allBlockedUsers = [];
  late List blockedUsernames = [];
  late Timer _timer;
  bool isBlocked = false;
  final screens = [
    const Dashboard(),
    const MyCheckIns(),
    const Notifications(),
    const Profile(),
  ];

  void onSelectedIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetSubscription = InternetConnectionChecker().onStatusChange.listen((status){
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(()=> this.hasInternet = hasInternet);
    });
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    pageController = PageController(initialPage: selectedIndex);
    _timer = Timer.periodic(const Duration(seconds: 20), (timer){
    });
  }

  @override
  void dispose(){
    internetSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child:Scaffold(
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.white,
              labelTextStyle:  MaterialStateProperty.all(
                  const TextStyle(fontSize:12, fontWeight: FontWeight.bold,color: Colors.white)
              )
          ),
          child: NavigationBar(
            backgroundColor: primaryColor,
            animationDuration: const Duration(seconds: 3),
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) => setState((){
              selectedIndex = index;
            }),
            height: 60,
            // backgroundColor: Colors.white,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home,color: Colors.white,),
                selectedIcon: Icon(Icons.home),
                label: "Home",
              ),
              const NavigationDestination(
                icon: Icon(Icons.access_time_filled,color: Colors.white,),
                selectedIcon: Icon(Icons.access_time_filled),
                label: "Check Ins",
              ),
              GetBuilder<NotificationController>(builder: (controller){
                return NavigationDestination(
                  icon: badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -10, end: -12),
                      showBadge: true,
                      badgeAnimation: const badges.BadgeAnimation.rotation(
                        animationDuration: Duration(seconds: 1),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      badgeContent: Text("${notificationController.notRead.length}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:15)),
                      child: const Icon(Icons.notifications,color: Colors.white,)),
                  selectedIcon: const Icon(Icons.notifications),
                  label: "Alerts",
                );
              }),
              const NavigationDestination(
                icon: Icon(Icons.person,color: Colors.white,),
                selectedIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
        body: screens[selectedIndex],
      )
    );
  }
}
