import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_allAds.dart';
import 'package:raxaadmin/Controller/controller_viewAds.dart';
import 'package:raxaadmin/screen/screen_ads.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/myToasts.dart';

class ScreenViewAds extends StatefulWidget {
  final int id;
  final String name, date;

  const ScreenViewAds(
      {super.key, required this.id, required this.name, required this.date});

  @override
  State<ScreenViewAds> createState() => _ScreenViewAdsState();
}

class _ScreenViewAdsState extends State<ScreenViewAds> {
  final controllerViewAds = Get.find<ControllerViewAds>();

  @override
  void initState() {
    super.initState();

    loadUserData();
    // controllerViewAds.controllerViewAds(widget.id.toString());
  }

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
    });

    controllerViewAds.controllerViewAds(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffccf1fe),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff01B8FA),
                Color(0xff2596be),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Make AppBar transparent
            elevation: 0, // Remove shadow
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
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            title: Text(
              "View advertisement",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                // accept,reject
                // doCallAPILogin("accept");
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                width: 130,
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     // accept,reject
            //     doCallAPILogin("reject");
            //     // Get.back();
            //   },
            //   child: Container(
            //     alignment: Alignment.center,
            //     width: 130,
            //     padding:
            //         EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            //     decoration: BoxDecoration(
            //       color: Color(0xffFF0000),
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     child: Text(
            //       'Reject',
            //       style: TextStyle(
            //         fontSize: 10,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dealer Name : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3C3E89),
                      ),
                    ),
                    Text(
                      '${widget.name}',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff01733D),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date :  ',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3C3E89),
                      ),
                    ),
                    Text(
                      '${widget.date}',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff01733D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            if (controllerViewAds.loading.value) {
              return Center(
                  child: CircularProgressIndicator(color: Colors.red));
            }

            if (controllerViewAds.viewAds.isEmpty) {
              return Center(
                child: Text(
                  "No Ads data available",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: controllerViewAds.viewAds.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            controllerViewAds.viewAds[index].ads,
                            fit: BoxFit.cover,
                          ),
                          // child: Image.asset(
                          //   Images.ADS,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> doCallAPILogin(String status) async {
    doStartLoader(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.FormData body = dio.FormData.fromMap({
      "ads_id": widget.id,
      'status': status.toString(),
    });

    body.fields.forEach((field) {
      print("${field.key}: ${field.value}");
    });

    var res = await AuthApis.changeStatus(body);

    if (res != null) {
      Map<String, dynamic> response = json.decode(res.toString());
      print(response);
      print(response['status']); 
      if (response['status'] == true) {
        print('Rehmanali');
        print(response['message']);
        doStartLoader(false);
        SnackbarCustom.success("Success", response['message'].toString());

        Get.offAll(() => ScreenAds());

        final controllerAllAds = Get.find<ControllerAllAds>();

        await controllerAllAds.controllerAllAds(prefs.getString('user_id'));
        controllerAllAds.update();
      } else {
        doStartLoader(false);
        SnackbarCustom.error("Error", response['message']);
      }
    } else {
      doStartLoader(false);
      SnackbarCustom.error("Error",
          "Unable_to_login_at_the_moment_Please_try_again_after_sometime");
    }
  }

  doStartLoader(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  bool isLoading = false;
}
