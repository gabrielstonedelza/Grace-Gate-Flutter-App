import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggc/views/users_bottomnavigationbar%20copy.dart';
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';
import '../controllers/userController.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  deleteUser(String id)async{
    final url = "https://havenslearningcenter.xyz/delete_user/$id";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);

    if(response.statusCode == 204){
      Get.snackbar(
          "Success", "member was deleted",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          duration: const Duration(seconds: 5)
      );
      Get.offAll(() => const UsersBottomNavigationBar());
    }
    else{
      if (kDebugMode) {
        print(response.body);
      }
    }
  }
  var items;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile')
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 400,
            child: GetBuilder<UserController>(builder:(controller){
              return ListView.builder(
                  itemCount: controller.profileDetails != null ? controller.profileDetails.length :0,
                  itemBuilder: (context,index){
                    items = controller.profileDetails[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(items['get_full_name'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                                      const SizedBox(height:10),
                                      Text(items['get_email'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                                      const SizedBox(height:10),
                                      Text(items['get_phone_number'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              buttonColor: primaryColor,
                                              title: "Confirm Delete",
                                              middleText: "Are you sure you want delete your account and all your data?",
                                              middleTextStyle: const TextStyle(color: defaultTextColor2),
                                              content: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: RawMaterialButton(
                                                        shape: const StadiumBorder(),
                                                        fillColor: Colors.red,
                                                        onPressed: (){
                                                          deleteUser(controller.profileDetails[index]['id'].toString());
                                                          // Get.back();
                                                        }, child: const Text("Yes",style: TextStyle(color: Colors.white),)),
                                                  ),
                                                  const SizedBox(width:10),
                                                  Expanded(
                                                    child: RawMaterialButton(
                                                        shape: const StadiumBorder(),
                                                        fillColor: primaryColor,
                                                        onPressed: (){Get.back();},
                                                        child: const Text("Cancel",style: TextStyle(color: Colors.white),)),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          elevation: 8,
                                          fillColor: Colors.red,
                                          splashColor: splashColor,
                                          child: const Text(
                                            "Delete my data",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: defaultTextColor1),
                                          ),
                                        ),
                                      ),
                                      const Text("NB: Clicking on delete my data will delete your account and all your personal data.",style:TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                                      const SizedBox(height:10),
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
            }),
          ),

        ],
      )
    );
  }
}
