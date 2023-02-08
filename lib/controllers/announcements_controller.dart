import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class AnnouncementController extends GetxController {
  List announcements = [];
  bool isLoading = false;
  String title = "";
  String message = "";
  String dateAdded = "";
  List currentAnnouncement= [];


  Future<void> getAnnouncements(String token) async {
    try {
      isLoading = true;
      const walletUrl = "https://havenslearningcenter.xyz/announcements/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        announcements.assignAll(jsonData);
        currentAnnouncement.assign(announcements[0]);

        update();
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getDetailAnnouncement(String pk, String token) async {
    try {
      isLoading = true;
      final walletUrl = "https://havenslearningcenter.xyz/announcement_detail/$pk/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        final codeUnits = response.body;
        var jsonData = jsonDecode(codeUnits);
        title = jsonData['title'];
        message = jsonData['message'];
        dateAdded = jsonData['date_added'];
        update();
      }
    }
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
}