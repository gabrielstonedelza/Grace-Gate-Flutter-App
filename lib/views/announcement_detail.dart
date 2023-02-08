import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../constants/app_colors.dart';
import '../controllers/announcements_controller.dart';

class AnnouncementDetail extends StatefulWidget {
  final id;
  final title;
  final message;
  const AnnouncementDetail({Key? key,required this.id,required this.title,required this.message}) : super(key: key);

  @override
  State<AnnouncementDetail> createState() => _AnnouncementDetailState(id:this.id,title:this.title,message:this.message);
}

class _AnnouncementDetailState extends State<AnnouncementDetail> {
  final id;
  final title;
  final message;
  _AnnouncementDetailState({required this.id,required this.title,required this.message});
  AnnouncementController controller = Get.find();

  final storage = GetStorage();

  late String username = "";

  late String uToken = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    controller.getDetailAnnouncement(id,uToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(title)
      ),
      body: ListView(
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
