import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:raxaadmin/screen/screen_drawer.dart';
import 'package:raxaadmin/screen/screen_login.dart';
import 'package:raxaadmin/utils/db_helper.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dbHelper = DBHelper();

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Color(0xffccf1fe),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Align(
              alignment: AlignmentDirectional.center,
              child: Image.asset(
                Images.CENTER_ICON,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Align(
          //   alignment: AlignmentDirectional.bottomCenter,
          //   child: Image.asset(
          //     Images.CENTER_ICON111,
          //     height: 125,
          //     width: 125,
          //     fit: BoxFit.contain,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Gif(
                autostart: Autostart.loop,
                height: 40,
                width: 40,
                placeholder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                image: const AssetImage(Images.CENTER_ICON111),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onStart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('token'));
    print(
        "sharedPreferences__________sharedPreferences__________sharedPreferences__________sharedPreferences__________");

    if (sharedPreferences.getString('token') == null) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => ScreenLogin());
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => ScreenDrawer());
        // Get.offAll(() => Language());
      });
    }
    // Future.delayed(const Duration(seconds: 2), () {
    //   Get.offAll(() => ScreenLogin());
    // });
  }
}
