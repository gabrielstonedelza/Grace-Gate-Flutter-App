import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ggc/views/users_bottomnavigationbar%20copy.dart';
import 'login/newlogin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final storage = GetStorage();
  late String username = "";
  late String token = "";
  bool hasToken = false;

  @override
  void initState() {
    super.initState();
    if (storage.read("username") != null) {
      username = storage.read("username");
      setState(() {
        hasToken = true;
      });
    }

    if (hasToken) {
      Timer(const Duration(seconds: 7),
              () => Get.offAll(() => const UsersBottomNavigationBar()));
    }
    else {
      Timer(const Duration(seconds: 7),
              () => Get.offAll(() => const NewLogin()));
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SlideInUp(
          animate: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:18.0,right:18),
                child: Image.asset("assets/images/gracegate.jpg",width: size.width * 1.2,),
              ),
            ],
          ),
        )
      ),
    );
  }
}
