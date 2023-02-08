import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import '../controllers/devotion_controller.dart';

import 'devotion_detail.dart';

class Devotions extends StatefulWidget {
  const Devotions({Key? key}) : super(key: key);

  @override
  State<Devotions> createState() => _DevotionsState();
}

class _DevotionsState extends State<Devotions> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Devotions"),
         
        ),
        body: GetBuilder<DevotionController>(builder:(controller){
          return ListView.builder(
              itemCount: controller.devotions != null ? controller.devotions.length :0,
              itemBuilder: (context,index){
                items = controller.devotions[index];
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
                                Get.to(()=> DevotionDetail(id:controller.devotions[index]['id'].toString(),title:controller.devotions[index]['title'],message:controller.devotions[index]['message'],quotations:controller.devotions[index]['quotations']));
                              },
                              leading: const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  child: Icon(Icons.message)
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                                child: Text(items['title']),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(items['date_created'].toString().split("T").first),
                              ),
                            )
                        ),
                      ),
                    )
                  ],
                );

              }
          );
        })
    );
  }
}