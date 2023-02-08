import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';
import '../controllers/checkin_controller.dart';

class MyCheckIns extends StatefulWidget {
  const MyCheckIns({Key? key}) : super(key: key);

  @override
  State<MyCheckIns> createState() => _MyCheckInsState();
}

class _MyCheckInsState extends State<MyCheckIns> {
  CheckInController cController = Get.find();
  final storage = GetStorage();
  late String uToken = "";
  var items;
  String cdate = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());
  String datetime = DateTime.now().toString();
  bool canCheckIn = false;

  checkIn() async {
    const updateUrl = "https://havenslearningcenter.xyz/check_in/";
    final myUrl = Uri.parse(updateUrl);
    http.Response response = await http.post(
      myUrl,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $uToken"
      },
      body: {

      },
    );
    if (response.statusCode == 201) {
      storage.write("hasCheckedIn", "hasCheckedIn");
      Get.snackbar("Hurray 😀", "your check in was sent for approval.",
          duration: const Duration(seconds: 6),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: snackColor,
          colorText: defaultTextColor1);


    } else {
      Get.snackbar("Sorry 😢", response.body,
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: defaultTextColor1);
    }
  }

  @override
  void initState(){
    super.initState();

    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<CheckInController>(builder:(controller){
          return Text("My CheckIns  (${controller.myApprovedCheckIns.length})");
        }),
      ),
      body :GetBuilder<CheckInController>(builder:(controller){
        return ListView.builder(
            itemCount: controller.myApprovedCheckIns != null ? controller.myApprovedCheckIns.length :0,
            itemBuilder: (context,index){
              items = controller.myApprovedCheckIns[index];
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
                              child: Row(
                                children: [
                                  const Text("Checked In: "),
                                  Text(items['has_checked_in'].toString()),
                                ],
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text("Time: "),
                                      Text(items['time_checked_in'].toString().split(".").first),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0),
                                    child: Row(
                                      children: [
                                        const Text("Date: "),
                                        Text(items['date_checked_in']),
                                      ],
                                    ),
                                  ),
                                  // Text(cdate.toString().split(",").first)
                                ],
                              ),
                            ),
                            trailing: items['has_checked_in'].toString() == "true" ? Image.asset("assets/images/verified.png",width:40,height:40):Image.asset("assets/images/cancel.png",width:40,height:40),
                          )
                      ),
                    ),
                  )
                ],
              );
            }
        );
      }),
      floatingActionButton: cdate.toString().split(",").first == "Sunday" ? FloatingActionButton(
        onPressed: (){
          if(storage.read("hasCheckedIn") == "hasCheckedIn"){
            Get.snackbar("Sorry 😢", "you have already checked in today and it's waiting approval.",
                duration: const Duration(seconds: 6),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: defaultTextColor1);
          }
          else{
            checkIn();
          }

        },
        child: const Icon(Icons.add_circle),
      ) : Container(),
    );
  }
}
