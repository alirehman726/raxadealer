import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:raxaadmin/screen/screen_drawer.dart';
import 'package:raxaadmin/utils/db_helper.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dbHelper = DBHelper();

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     onStart();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       backgroundColor: Color(0xffccf1fe),

//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 30, right: 30),
//             child: Align(
//               alignment: AlignmentDirectional.center,
//               child: Image.asset(
//                 Images.CENTER_ICON,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           // Align(
//           //   alignment: AlignmentDirectional.bottomCenter,
//           //   child: Image.asset(
//           //     Images.CENTER_ICON111,
//           //     height: 125,
//           //     width: 125,
//           //     fit: BoxFit.contain,
//           //   ),
//           // ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 30),
//             child: Align(
//               alignment: AlignmentDirectional.bottomCenter,
//               child: Gif(
//                 autostart: Autostart.loop,
//                 height: 40,
//                 width: 40,
//                 placeholder: (context) =>
//                     const Center(child: CircularProgressIndicator()),
//                 image: const AssetImage(Images.CENTER_ICON111),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void onStart() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     print(sharedPreferences.getString('token'));
//     print(
//         "sharedPreferences__________sharedPreferences__________sharedPreferences__________sharedPreferences__________");

//     if (sharedPreferences.getString('token') == null) {
//       Future.delayed(const Duration(seconds: 2), () {
//         Get.offAll(() => ScreenDrawer());
//         // Get.offAll(() => ScreenLogin());
//       });
//     } else {
//       Future.delayed(const Duration(seconds: 2), () {
//         Get.offAll(() => ScreenDrawer());
//       });
//     }
//     // Future.delayed(const Duration(seconds: 2), () {
//     //   Get.offAll(() => ScreenLogin());
//     // });
//   }
// }

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat zoom in/out

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    onStart();
  }

  void onStart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('token'));
    print(
        "sharedPreferences__________sharedPreferences__________sharedPreferences__________sharedPreferences__________");

    // if (sharedPreferences.getString('token') == null) {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     Get.offAll(() => ScreenLogin());
    //   });
    // } else {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     Get.offAll(() => ScreenDrawer());
    //     // Get.offAll(() => Language());
    //   });
    // }

    if (sharedPreferences.getString('token') == null) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => ScreenDrawer());
        // Get.offAll(() => ScreenLogin());
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => ScreenDrawer());
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffccf1fe),
      body: Stack(
        children: [
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.CENTER_ICON,
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0093e9),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 30, right: 30),
          //   child: Align(
          //     alignment: AlignmentDirectional.center,
          //     child: Image.asset(
          //       Images.CENTER_ICON,
          //       width: 150,
          //       height: 150,
          //       fit: BoxFit.contain,
          //     ),
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
}
