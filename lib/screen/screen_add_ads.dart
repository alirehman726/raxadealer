import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_allAds.dart';
import 'package:raxaadmin/screen/screen_ads.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/myToasts.dart';

class ScreenAddAds extends StatefulWidget {
  final int id;
  final String name, date;

  const ScreenAddAds(
      {super.key, required this.id, required this.name, required this.date});

  @override
  State<ScreenAddAds> createState() => _ScreenAddAdsState();
}

class _ScreenAddAdsState extends State<ScreenAddAds> {
  @override
  void initState() {
    super.initState();

    loadUserData();
    // controllerViewAds.controllerViewAds(widget.id.toString());
  }

  List<File?> selectedImages = List.filled(5, null); // For 5 image slots

  Future<void> pickImage(int index) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImages[index] = File(picked.path);
      });
    }
  }

  String? username;
  String? email;
  String? user_type;
  String? user_id;
  String? city_id;

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'ADMIN';
      email = prefs.getString('email') ?? 'example@gmail.com';
      user_type = prefs.getString('user_type') ?? 'dealer';
      user_id = prefs.getString('user_id') ?? '0';
      city_id = prefs.getString('city_id') ?? '0';
    });
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
              "Add advertisement",
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
                // Get.back();
                uploadImagesAPI();
              },
              child: Container(
                alignment: Alignment.center,
                width: 130,
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xff3FCB1C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: selectedImages[index] == null
                              ? Center(
                                  child: Text('No image selected'),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    selectedImages[index]!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff01b8fa),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: () => pickImage(index),
                              icon: Icon(Icons.upload,
                                  color: Colors.white, size: 18),
                              label: Text(
                                'Upload Advertisement',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),

          // return Expanded(
          //   child: ListView.builder(
          //     // itemCount: controllerViewAds.viewAds.length,
          //     itemCount: 5,
          //     itemBuilder: (context, index) {
          //       return Column(
          //         children: [
          //           Stack(
          //             children: [
          //               // 📷 Image container
          //               Container(
          //                 margin: const EdgeInsets.symmetric(
          //                     horizontal: 20, vertical: 10),
          //                 height: 150,
          //                 width: double.infinity,
          //                 decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.circular(10),
          //                 ),
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(10),
          //                   child: Image.network(
          //                     controllerViewAds.viewAds[index].ads,
          //                     fit: BoxFit.cover,
          //                     width: double.infinity,
          //                   ),
          //                 ),
          //               ),

          //               Positioned.fill(
          //                 child: Center(
          //                   child: ElevatedButton.icon(
          //                     style: ElevatedButton.styleFrom(
          //                       backgroundColor: Color(0xff01b8fa),
          //                       // backgroundColor:
          //                       //     Colors.black.withOpacity(0.6),
          //                       padding: EdgeInsets.symmetric(
          //                           horizontal: 16, vertical: 10),
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(25),
          //                       ),
          //                     ),
          //                     onPressed: () {
          //                       print("Upload pressed for index $index");
          //                     },
          //                     icon: Icon(Icons.upload,
          //                         color: Colors.white, size: 18),
          //                     label: Text(
          //                       'Upload Advertisement',
          //                       style: TextStyle(
          //                         color: Colors.white,
          //                         fontWeight: FontWeight.w400,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       );
          //     },
          //   ),
          // );
        ],
      ),
    );
  }

  Future<void> uploadImagesAPI() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://raxaspread.com/API/api/upload-ads'),
    );

    request.fields['city'] = city_id.toString();
    request.fields['user_id'] = user_id ?? '0';

    for (int i = 0; i < selectedImages.length; i++) {
      if (selectedImages[i] != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'ad_${i + 1}', selectedImages[i]!.path));
      }
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Upload successful");
      // Get.snackbar("Success", "Ads uploaded successfully");
      Fluttertoast.showToast(
        msg: "Ads uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Get.offAll(() => ScreenAds());

      final controllerAllAds = Get.find<ControllerAllAds>();

      await controllerAllAds.controllerAllAds(user_id);
      controllerAllAds.update();
      // SnackbarCustom.error("Error", "Ads uploaded successfully");
    } else {
      print("Upload failed");
      // Get.snackbar("Error", "Failed to upload ads");
      Fluttertoast.showToast(
        msg: "All Image required",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // SnackbarCustom.error("Error", "Failed to upload ads");
    }
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
