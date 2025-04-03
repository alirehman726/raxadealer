import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/screen/screen_drawer.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool processLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF01B8FA),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 80, left: 10, right: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Welcome to\nRaxa Spread Pvt Ltd.',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: Image.asset(
                          Images.LOGIN_MAIN_ICON,
                          height: 150,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Username / Email ID / Phone No",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (email) {
                            if (email!.isEmpty) {
                              return "Please_insert_email_address".tr;
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(email)) {
                              return "Please_insert_a_valid_email_address".tr;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "example@gmail.com",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (pass) {
                            if (pass!.isEmpty) {
                              return "Please_enter_your_password".tr;
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "********",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                          ),
                          onPressed: () {
                            loginFun();
                            // Get.to(() => ScreenDrawer());
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            // Register action
                          },
                          child: Text(
                            "New user ? Register Now",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginFun() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      processLoadingVal(true);

      dio.FormData body = dio.FormData.fromMap({
        // "token": appToken,
        "email": emailController.text,
        "password": passwordController.text
      });
      var res = await AuthApis.APIlogin(body);
      if (res != null) {
        processLoadingVal(false);
        Map<String, dynamic> response = json.decode(res.toString());
        print(response);
        print(response['status']);
        print('Hello TVS');
        if (response['status'] == true) {
          sharedPreferences.setString("token", response['token']);
          sharedPreferences.setString("email", response['email']);
          sharedPreferences.setString("username", response['username']);
          Get.to(() => ScreenDrawer());
          Fluttertoast.showToast(
            msg: "Login Successfully".toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          processLoadingVal(false);
          Fluttertoast.showToast(
            msg: "Someting went wrong".toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        processLoadingVal(false);
        Fluttertoast.showToast(
          msg: "Someting went wrong".toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      // longToastMessage("Please Enter Valid Mobile Number!");
      Fluttertoast.showToast(
        msg: "Please Enter Valid Email & Password".toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  processLoadingVal(bool val) {
    setState(() {
      processLoading = val;
    });
  }
}
