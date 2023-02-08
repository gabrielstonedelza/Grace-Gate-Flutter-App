import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/userController.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile')
      ),
      body: GetBuilder<UserController>(builder:(controller){
        return ListView.builder(
            itemCount: controller.profileDetails != null ? controller.profileDetails.length :0,
            itemBuilder: (context,index){
              items = controller.profileDetails[index];
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
                            leading: const CircleAvatar(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                child: Icon(Icons.person)
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                              child: Text(items['get_username'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:18)),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(items['get_full_name'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                                const SizedBox(height:10),
                                Text(items['get_email'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                                const SizedBox(height:10),
                                Text(items['get_phone_number'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                              ],
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
