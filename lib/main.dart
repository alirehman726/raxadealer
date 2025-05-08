import 'dart:convert';
import 'dart:io';

import 'package:cron/cron.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller.ads.dart';
import 'package:raxaadmin/Controller/controller_AllDealer.dart';
import 'package:raxaadmin/Controller/controller_EditDealer.dart';
import 'package:raxaadmin/Controller/controller_OneProducts.dart';
import 'package:raxaadmin/Controller/controller_allAds.dart';
import 'package:raxaadmin/Controller/controller_allOrder.dart';
import 'package:raxaadmin/Controller/controller_allProducts.dart';
import 'package:raxaadmin/Controller/controller_allTrackorder.dart';
import 'package:raxaadmin/Controller/controller_dealerReport.dart';
import 'package:raxaadmin/Controller/controller_retailer.dart';
import 'package:raxaadmin/Controller/controller_viewAds.dart';
import 'package:raxaadmin/screen/LacaleString.dart';
import 'package:raxaadmin/screen/screen_drawer.dart';
import 'package:raxaadmin/screen/splash_screen.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller/controller_view_order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Screen Util Initialize
  await ScreenUtil.ensureScreenSize();
  HttpOverrides.global = MyHttpOverrides();

  // All Get.puts
  Get.put(ControllerAllproducts());
  Get.put(ControllerAds());
  Get.put(ControllerOneproducts());
  Get.put(ControllerAllOrder());
  Get.put(ControllerViewOrder());
  Get.put(ControllerAllAds());
  Get.put(ControllerViewAds());
  Get.put(ControllerAllDealer());
  Get.put(ControllerEditDealer());
  Get.put(ControllerDealerreport());
  Get.put(ControllerAllRetailer());
  Get.put(ControllerAllTrack());

  runApp(const MyApp());

  // Post app load, setup cron
  WidgetsBinding.instance.addPostFrameCallback((_) {
    var cron = Cron();

    cron.schedule(Schedule.parse('*/01 * * * *'), () async {
      // await loginFun();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('token');
      try {
        if (token != null) {
          await loginFun();
        }
      } catch (e) {
        print("Error in loginFun: $e");
      }
      print('cron: login check run');
      print('every One minutes');
    });
  });
}

Future<void> loginFun() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString('token'));
  print("prefs.getString('token')1111111");

  dio.FormData body = dio.FormData.fromMap({
    "username": prefs.getString('email_id'),
    "password": prefs.getString('password'),
  });
  var res = await AuthApis.APIlogin(body);
  if (res != null) {
    Map<String, dynamic> response = json.decode(res.toString());
    print(response);
    print(response['status']);
    print("false_____________--");
    if (response['status'] == "false") {
      print("Rehmanali");
      prefs.remove("token");
      // Get.offAll(() => ScreenLogin());
      Get.offAll(() => ScreenDrawer());
    }
  }
}

// void main() async {
//   Future<void> loginFun() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // token = prefs.getString('token');
//     print(prefs.getString('token'));

//     dio.FormData body = dio.FormData.fromMap({
//       // "token": appToken,
//       "username": prefs.getString('email_id'),
//       "password": prefs.getString('password'),
//     });
//     var res = await AuthApis.APIlogin(body);
//     if (res != null) {
//       Map<String, dynamic> response = json.decode(res.toString());
//       print(response);
//       print(response['status']);
//       if (response['status'] == true) {
//         prefs.setString("token", response['token']);
//         prefs.setString("email", response['email']);
//         prefs.setString("username", response['username']);
//         prefs.setString("user_type", response['user_type']);
//         prefs.setString("login_city", response['city_id']);
//         prefs.setString("user_status", response['user_status']);
//         // "user_status": "1",
//         prefs.setString("user_id", int.parse(response['user_id']).toString());
//         // Get.to(() => ScreenDrawer());
//       } else if (response['status'] == false) {
//         Get.offAll(() => ScreenLogin());
//       }
//     } else {
//       Fluttertoast.showToast(
//         msg: "Someting went wrong".toString(),
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   var cron = new Cron();

//   cron.schedule(new Schedule.parse('*/1 * * * *'), () async {
//     // Get.put(OrderController());
//     // final controller = Get.find<OrderController>();
//     // controller.getNewOrder();
//     loginFun();
//     print('every One minutes');
//   });
//   Future.delayed(const Duration(hours: 24), () async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // token = prefs.getString('token');

//     // Get.offAll(() => const ScreenLogin());
//   });

//   WidgetsFlutterBinding.ensureInitialized();

//   // Screen Util Initialize
//   await ScreenUtil.ensureScreenSize();
//   HttpOverrides.global = MyHttpOverrides();

//   // Get.put(DashboardController());
//   Get.put(ControllerAllproducts());
//   Get.put(ControllerAds());
//   Get.put(ControllerOneproducts());
//   Get.put(ControllerAllOrder());
//   Get.put(ControllerViewOrder());
//   Get.put(ControllerAllAds());
//   Get.put(ControllerViewAds());
//   Get.put(ControllerAllDealer());
//   Get.put(ControllerEditDealer());
//   Get.put(ControllerDealerreport());
//   Get.put(ControllerAllRetailer());
//   Get.put(ControllerAllTrack());
//   runApp(const MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return ScreenUtilInit(
      child: GetMaterialApp(
        title: "Raxa Dealer",
        debugShowCheckedModeBanner: false,
        translations: LocaleString(),
        locale: Locale('en', 'US'),
        theme: ThemeData(
            fontFamily: "Poppins",
            primarySwatch: Colors.grey,
            scaffoldBackgroundColor: scaffoldColor,
            appBarTheme: AppBarTheme(
              color: white,
              centerTitle: true,
              elevation: 0,
            )),
        home: SplashScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
