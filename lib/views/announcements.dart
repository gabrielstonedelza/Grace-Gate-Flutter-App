import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";


import '../controllers/announcements_controller.dart';
import 'announcement_detail.dart';

class Announcements extends StatefulWidget {
  const Announcements({Key? key}) : super(key: key);

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Announcements"),

        ),
        body: GetBuilder<AnnouncementController>(builder:(controller){
          return ListView.builder(
              itemCount: controller.announcements != null ? controller.announcements.length :0,
              itemBuilder: (context,index){
                items = controller.announcements[index];
                return Column(
                  children: [
                    const SizedBox(height: 10,),
                    SlideInUp(
                      animate: true,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18,right: 18),
                        child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child:ListTile(
                              onTap: (){
                                Get.to(()=> AnnouncementDetail(id:controller.announcements[index]['id'].toString(),title:controller.announcements[index]['title'],message:controller.announcements[index]['message'],));
                              },
                              leading: const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  child: Icon(Icons.assessment)
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                                child: Text(items['title']),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(items['date_added'].toString().split(".").first),
                              ),
                            )
                        ),
                      ),
                    )
                  ],
                );

              }
          );
        }),
    );
  }
}