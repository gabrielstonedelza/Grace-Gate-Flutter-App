import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class MyRegistrationController extends GetxController{
  static MyRegistrationController get to => Get.find<MyRegistrationController>();

  registerUser(String uname,String email,String fName,String phoneNumber,String uPassword, String uRePassword,String homeAddress,String digitalAddress) async {
    const loginUrl = "https://havenslearningcenter.xyz/auth/users/";
    final myLogin = Uri.parse(loginUrl);

    http.Response response = await http.post(myLogin,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"username": uname,"email":email,"full_name":fName,"phone_number":phoneNumber, "password": uPassword,"re_password":uRePassword,"home_address":homeAddress,"digital_address":digitalAddress});

    if (response.statusCode == 201) {
      Get.snackbar(
          "Success", "member registered successfully",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          duration: const Duration(seconds: 5)
      );
    }
      else {
        Get.snackbar(
            "Error 😢", response.body.toString(),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5)
        );
        return;
      }
    }
  }
