import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class EventController extends GetxController{
  List events = [];
  bool isLoading=false;
  String eventTitle = "";
  String eventTime = "";
  String eventDate = "";
  String dateAdded = "";


  Future<void> getEvents(String token)async{
    try{
      isLoading=true;
      const walletUrl = "https://havenslearningcenter.xyz/devotions/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        events.assignAll(jsonData);
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

  Future<void> getDetailEvent(String pk,String token)async {
    try{
      isLoading = true;
      final walletUrl = "https://havenslearningcenter.xyz/event_detail/$pk/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        final codeUnits = response.body;
        var jsonData = jsonDecode(codeUnits);
        eventTitle = jsonData['event_title'];
        eventTime = jsonData['event_time'];
        eventDate = jsonData['event_date'];
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