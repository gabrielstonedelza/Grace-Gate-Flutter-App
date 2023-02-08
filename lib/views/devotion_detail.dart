import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';

import '../constants/app_colors.dart';
import '../controllers/devotion_controller.dart';

class DevotionDetail extends StatefulWidget {
  final id;
  final title;
  final message;
  final quotations;
  const DevotionDetail({Key? key,required this.id,required this.title,required this.message,required this.quotations}) : super(key: key);

  @override
  State<DevotionDetail> createState() => _DevotionDetailState(id:this.id,title:this.title,message:this.message,quotations:this.quotations);
}

class _DevotionDetailState extends State<DevotionDetail> {
  final id;
  final title;
  final message;
  final quotations;
  _DevotionDetailState({required this.id,required this.title,required this.message,required this.quotations});
  DevotionController controller = Get.find();
  final storage = GetStorage();

  late String username = "";

  late String uToken = "";

  @override
  void initState(){
    super.initState();
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    controller.getDetailDevotion(id, uToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:ListView(
        children: [
          Card(
            color: secondaryColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:18.0,bottom:10),
                    child: Text("Quotations: $quotations",style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 20,color: Colors.white)),
                  ),
                  Text(message,style:const TextStyle(fontWeight:FontWeight.bold,fontSize: 16,color: Colors.white)),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
