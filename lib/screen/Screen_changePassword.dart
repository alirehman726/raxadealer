import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_AllDealer.dart';
import 'package:raxaadmin/Widgets/logoutDialog.dart';
import 'package:raxaadmin/screen/screen_drawer.dart';
import 'package:raxaadmin/screen/screen_menu_item.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenChangepassword extends StatefulWidget {
  @override
  _ScreenChangepasswordState createState() => _ScreenChangepasswordState();
}

class _ScreenChangepasswordState extends State<ScreenChangepassword>
    with SingleTickerProviderStateMixin {
  final controllerAllDealer = Get.find<ControllerAllDealer>();

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  RxString searchQuery = "".obs;

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery.value = query.toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();

    controllerAllDealer.controllerAllDealer();
    loadUserData();
  }

  late List<Map<String, dynamic>> menuItems;

  String? username;
  String? email;
  String? user_type;
  String? user_id;

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'ADMIN';
      email = prefs.getString('email') ?? 'example@gmail.com';
      user_type = prefs.getString('user_type') ?? 'dealer';
      user_id = prefs.getString('user_id') ?? '0';
      loadMenuItems();
    });
  }

  void loadMenuItems() async {
    String userType = "dealer"; // ya SharedPreferences se le lo
    menuItems = await getMenuItems(userType);
    setState(() {}); // UI update
  }

  void _launchURL() async {
    const url =
        'https://www.design-blitz.com/'; // 👈 Replace with your actual link
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  int selectedIndex = 0;
  bool isSwitched = false;
  Future<void> doCallAPILogin() async {
    doStartLoader(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.FormData body = dio.FormData.fromMap({
      "user_id": prefs.getString('user_id'),
      "new_password": nameController.text,
      "confrim_password": mobileController.text,
    });
    var res = await AuthApis.changePasswordAPI(body);

    if (res != null) {
      Map<String, dynamic> response = json.decode(res.toString());
      print(response);
      print(response['status']);
      if (response['status'] == true) {
        Fluttertoast.showToast(
          msg: response['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Get.offAll(() => ScreenDrawer());
      } else {
        doStartLoader(false);
        // SnackbarCustom.error("Error", response['message']);
        Fluttertoast.showToast(
          msg: response['message'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      doStartLoader(false);
      Fluttertoast.showToast(
        msg: "Something Error ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  bool isLoading = false;

  doStartLoader(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          // SystemNavigator.pop();
          Get.to(() => ScreenDrawer());
        } else if (Platform.isIOS) {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xffccf1fe),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff01B8FA),
          title: Text(
            "Change Password",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                Images.PROFILE_ICON,
                height: 35,
                width: 35,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20, left: 10),
                height: 120,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Images.PROFILE_ICON,
                          height: 60,
                          width: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                username ?? '',
                                // 'ADMIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Text(
                              email ?? '',
                              // 'example@gmail.com',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                height: 2,
              ),
              const SizedBox(height: 20),
              ...List.generate(menuItems.length, (index) {
                bool isSelected = selectedIndex == index;
                return InkWell(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 5,
                          height: 35,
                          decoration: BoxDecoration(
                            // color: isSelected ? Colors.red : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            onTap: () {
                              print(menuItems[index]["route"]());
                              print('Rehmanali');
                              Navigator.pop(context);
                              Get.to(menuItems[index]["route"]());
                            },
                            leading: Image.asset(
                              menuItems[index]["icon"],
                              height: 23,
                              width: 23,
                              color: primaryColor,
                            ),
                            title: Text(
                              menuItems[index]["title"],
                              style: TextStyle(
                                color: Color(0xff3C3D86),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                // color: isSelected ? Colors.red : Colors.black54,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: gradient2,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Spacer(),
              InkWell(
                onTap: () {
                  logoutDialog_logout(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Images.DRAWER_7,
                        height: 23,
                        width: 23,
                        color: primaryColor,
                        // color: isSelected ? Colors.red : Colors.black54,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Logout",
                        style: TextStyle(
                          color: Color(0xff3C3D86),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          // color: isSelected ? Colors.red : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(
                                text: 'All Right Reserved By ',
                                style: TextStyle(
                                  color: Color(0xFF3C3C90), // Dark purple-ish
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: 'Design-blitz',
                                style: const TextStyle(
                                  color: Colors
                                      .lightBlueAccent, // Light blue clickable
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _launchURL,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: 'App Version : 1.0',
                            style: TextStyle(
                              color: Color(0xFF3C3C90), // Dark purple-ish
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              color: Color(0xff01B8FA),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3C3E89),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Divider(
                              color: Color(0xff01B8FA),
                              height: 2,
                              thickness: 3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffe6f8ff),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "New Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff737c80),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please insert valid new password";
                        }
                        if (value.length < 3) {
                          return "Name should be min 3 characters long";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe6f8ff),
                        labelText: "Enter your New Password",
                        // labelStyle: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.black87,
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff737c80),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      obscureText: true,
                      controller: mobileController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please insert valid confirm password";
                        }
                        if (value.length < 3) {
                          return "Name should be min 3 characters long";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe6f8ff),
                        labelText: "Enter your Confirm Password",
                        // hintStyle: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.black87,
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        doCallAPILogin();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
