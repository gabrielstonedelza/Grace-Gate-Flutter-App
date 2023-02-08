import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../views/users_bottomnavigationbar copy.dart';



class LoginController extends GetxController{
  final storage= GetStorage();
  String username= "";
  String password= "";
  String deToken= "";
  String loggedInUserId = "";
  bool isUser = false;

  loginUser(String uname, String uPassword) async {
    const loginUrl = "https://havenslearningcenter.xyz/auth/token/login/";
    final myLogin = Uri.parse(loginUrl);

    http.Response response = await http.post(myLogin,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"username": uname, "password": uPassword});

    if (response.statusCode == 200) {
      final resBody = response.body;
      var jsonData = jsonDecode(resBody);
      var userToken = jsonData['auth_token'];
      var userId = jsonData['id'];
      loggedInUserId = userId.toString();
      deToken = userToken;
      storage.write("username", uname);
      storage.write("userToken", userToken);
      storage.write("userid", userId);
      username = uname;
      isUser = true;
      update();

      Timer(const Duration(seconds: 1),
              () => Get.offAll(() => const UsersBottomNavigationBar()));

    } else {
      Get.snackbar("Sorry 😢", "invalid details",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
  }

}