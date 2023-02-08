import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  static NotificationController get to => Get.find<NotificationController>();
  late List allNotifications = [];
  bool isLoading = true;
  final storage = GetStorage();
  var username = "";
  late String uToken = "";
  late List yourNotifications = [];
  late List notRead = [];


  Future<void> getAllNotifications(String token) async {
    try{
      isLoading = true;
      const url = "https://havenslearningcenter.xyz/my_notifications/";
      var myLink = Uri.parse(url);
      final response =
      await http.get(myLink, headers: {"Authorization": "Token $token"});
      if (response.statusCode == 200) {
        final codeUnits = response.body.codeUnits;
        var jsonData = const Utf8Decoder().convert(codeUnits);
        allNotifications = json.decode(jsonData);
        print(allNotifications);
        update();
      } else {
        if (kDebugMode) {
          // print(response.body);
        }
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    finally {
      isLoading = false;
    }
  }

  Future<void> getAllUnReadNotifications(String token) async {
    const url = "https://havenslearningcenter.xyz/get_user_unread_notifications/";
    var myLink = Uri.parse(url);
    final response =
    await http.get(myLink, headers: {"Authorization": "Token $token"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      yourNotifications = json.decode(jsonData);
      notRead.assignAll(yourNotifications);
      update();
    }
  }

  Future<void> getUserReadNotifications(String token) async {
    const url = "https://taxinetghana.xyz/user_read_notifications/";
    var myLink = Uri.parse(url);
    final response =
    await http.get(myLink, headers: {"Authorization": "Token $token"});
    if(response.statusCode == 200){
      if (kDebugMode) {
        print(response.body);
      }
    }
    else{
      if (kDebugMode) {
        print(response.body);
      }
    }
  }
}
