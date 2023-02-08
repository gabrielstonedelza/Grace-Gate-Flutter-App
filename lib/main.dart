import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ggc/views/splashscreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'constants/app_colors.dart';
import 'controllers/announcements_controller.dart';
import 'controllers/checkin_controller.dart';
import 'controllers/devotion_controller.dart';
import 'controllers/events_controller.dart';
import 'controllers/logincontroller.dart';
import 'controllers/notificationController.dart';
import 'controllers/registration_controller.dart';
import 'controllers/userController.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  Get.put(AnnouncementController());
  Get.put(CheckInController());
  Get.put(DevotionController());
  Get.put(EventController());
  Get.put(LoginController());
  Get.put(NotificationController());
  Get.put(MyRegistrationController());
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor:primaryColor,
          elevation: 0,
        ),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

