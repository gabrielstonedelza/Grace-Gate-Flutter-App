import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class DevotionController extends GetxController{
  List devotions= [];
  bool isLoading=false;
  String  quotations= "";
  String title='';
  String message='';
  String dateCreated = "";
  List currentDevotion= [];

  Future<void> getDevotions(String token)async{
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
        devotions.assignAll(jsonData);
        currentDevotion.assign(devotions[0]);
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

  Future<void> getDetailDevotion(String pk,String token)async {
    try{
      isLoading = true;
      final walletUrl = "https://havenslearningcenter.xyz/devotion_detail/$pk/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        final codeUnits = response.body;
        var jsonData = jsonDecode(codeUnits);
        title = jsonData['title'];
        quotations = jsonData['quotations'];
        message = jsonData['message'];
        dateCreated = jsonData['date_created'];
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