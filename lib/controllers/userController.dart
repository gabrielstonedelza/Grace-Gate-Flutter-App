import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import 'package:dio/dio.dart';

import '../constants/app_colors.dart';


class UserController extends GetxController {
  final storage = GetStorage();
  var username = "";
  String uToken = "";
  String passengerProfileId = "";
  String passengerUsername = "";
  String profileImage = "";
  String nameOnGhanaCard = "";
  String email = "";
  String phoneNumber = "";
  String fullName = "";
  String nextOfKin = "";
  String nextOfKinPhoneNumber = "";
  String frontGhanaCard = "";
  String backGhanaCard = "";
  String referral = "";
  String uniqueCode = "";
  String promoterName = "";
  String promoter = "";
  late bool verified;
  bool isVerified = false;
  late String updateUserName;
  late String updateEmail;
  late String updatePhone;
  bool isUpdating = true;
  var dio = Dio();
  bool hasUploadedFrontCard = false;
  bool hasUploadedBackCard = false;

  late List profileDetails = [];

  late List allUsers = [];
  late List phoneNumbers = [];
  late List driversUniqueCodes = [];
  late List allDrivers = [];
  late List driversNames = [];
  late List passengerNames = [];
  late List passengersUniqueCodes = [];
  late List allPassengers = [];
  late List allUsersUniqueCodes = [];


  bool isLoading = true;
  bool isOpened = false;
  bool isUploading = false;
  late Timer _timer;
  File? image;
  late List profileDetails1 = [];


  Future<void> getUserProfile(String token) async {
    try {
      isLoading = true;
      update();
      const profileLink = "https://havenslearningcenter.xyz/user_profile/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        profileDetails = jsonData;
        update();
      }
      else{
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getAllUsers(String token) async {
    try {
      isLoading = true;
      const profileLink = "https://havenslearningcenter.xyz/users/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allUsers = jsonData;
        for (var i in allUsers) {
         if(!phoneNumbers.contains(i['phone_number'])){
           phoneNumbers.add(i['phone_number']);
         }
        }

        update();
      }
      else{
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
  Future<void> getMyAllUsers() async {
    try {
      isLoading = true;
      const profileLink = "https://havenslearningcenter.xyz/all_users/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allDrivers = jsonData;
        for (var i in allDrivers) {
          if(!allUsersUniqueCodes.contains(i['unique_code'])){
            allUsersUniqueCodes.add(i['unique_code']);
          }
        }
        update();

      }
      else{
        if (kDebugMode) {
          print("response.body");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
  Future<void> getUserDetails(String token) async {
    try {
      isLoading = true;
      const profileLink = "https://havenslearningcenter.xyz/get_user/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        profileDetails1 = jsonData;
        // print(profileDetails1);
        update();
      }
      else{
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
  updateProfileDetails(String updateUserName, String updateEmail,String fullName, String updatePhone) async {
    const updateUrl = "https://havenslearningcenter.xyz/update_username/";
    final myUrl = Uri.parse(updateUrl);
    http.Response response = await http.put(
      myUrl,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      },
      body: {
        "username": updateUserName,
        "email": updateEmail,
        "full_name": fullName,
        "phone_number": updatePhone
      },
    );
    if (response.statusCode == 200) {
      Get.snackbar("Hurray 😀", "Your profile was updated",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: defaultTextColor1);
      update();
      isUpdating = false;
    } else {
      Get.snackbar("Sorry 😢", response.body,
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: defaultTextColor1);
    }
  }


}
