import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raxaadmin/Controller/controller_allAds.dart';
import 'package:raxaadmin/Controller/controller_viewAds.dart';
import 'package:raxaadmin/Widgets/logoutDialog.dart';
import 'package:raxaadmin/screen/screen_drawer.dart';
import 'package:raxaadmin/screen/screen_menu_item.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenAddAds extends StatefulWidget {
  // final int id;
  // final String name, date;

  // const ScreenAddAds(
  //     {super.key, required this.id, required this.name, required this.date});

  @override
  State<ScreenAddAds> createState() => _ScreenAddAdsState();
}

class _ScreenAddAdsState extends State<ScreenAddAds> {
  final controllerViewAds = Get.find<ControllerViewAds>();
  @override
  void initState() {
    super.initState();

    loadUserData();
    // controllerViewAds.controllerViewAds(widget.id.toString());
  }

  late List<Map<String, dynamic>> menuItems;

  String? username;
  String? email;
  String? user_type;
  String? user_id;
  String? city_id;
  String? login_city;

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'ADMIN';
      email = prefs.getString('email') ?? 'example@gmail.com';
      user_type = prefs.getString('user_type') ?? 'dealer';
      user_id = prefs.getString('user_id') ?? '0';
      city_id = prefs.getString('city_id') ?? '0';
      login_city = prefs.getString('login_city') ?? '0';
      loadMenuItems();
    });
    controllerViewAds.controllerViewAds();
  }

  void loadMenuItems() async {
    String userType = "dealer"; // ya SharedPreferences se le lo
    menuItems = await getMenuItems(userType);
    setState(() {}); // UI update
  }

  int selectedIndex = 0;
  bool isSwitched = false;

  void _launchURL() async {
    const url =
        'https://www.design-blitz.com/'; // 👈 Replace with your actual link
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<File?> selectedImages = List.filled(5, null); // For 5 image slots

  // Future<void> pickImage(int index) async {
  //   final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (picked != null) {
  //     setState(() {
  //       selectedImages[index] = File(picked.path);
  //     });
  //   }
  // }

  Future<void> pickImage(int index) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final picked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  // if (picked != null) {
                  //   setState(() {
                  //     selectedImages[index] = File(picked.path);
                  //   });
                  // }
                  if (picked != null) {
                    File? croppedFile = await _cropImage(File(picked.path));
                    if (croppedFile != null) {
                      setState(() {
                        selectedImages[index] = croppedFile;
                      });
                    }
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final picked =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  // if (picked != null) {
                  //   setState(() {
                  //     selectedImages[index] = File(picked.path);
                  //   });
                  // }
                  if (picked != null) {
                    File? croppedFile = await _cropImage(File(picked.path));
                    if (croppedFile != null) {
                      setState(() {
                        selectedImages[index] = croppedFile;
                      });
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<File?> _cropImage(File imageFile) async {
    final cropped = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      // Optional: Set a fixed aspect ratio if needed
      // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),

      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    return cropped != null ? File(cropped.path) : null;
  }

  // Future<File?> _cropImage(File imageFile) async {
  //   final cropped = await ImageCropper().cropImage(
  //     sourcePath: imageFile.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.original,
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //         toolbarTitle: 'Crop Image',
  //         toolbarColor: Colors.deepOrange,
  //         toolbarWidgetColor: Colors.white,
  //       ),
  //       IOSUiSettings(
  //         title: 'Crop Image',
  //       ),
  //     ],
  //   );

  //   return cropped != null ? File(cropped.path) : null;
  // }

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
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xffccf1fe),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff01B8FA),
          title: Text(
            "Add advertisement",
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
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(kToolbarHeight),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [
        //           Color(0xff01B8FA),
        //           Color(0xff2596be),
        //         ],
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //       ),
        //     ),
        //     child: AppBar(
        //       backgroundColor: Colors.transparent, // Make AppBar transparent
        //       elevation: 0, // Remove shadow
        //       actions: [
        //         Padding(
        //           padding: const EdgeInsets.only(right: 10),
        //           child: Image.asset(
        //             Images.PROFILE_ICON,
        //             height: 35,
        //             width: 35,
        //           ),
        //         ),
        //       ],
        //       leading: IconButton(
        //         icon: Icon(
        //           Icons.arrow_back_ios_new_rounded,
        //           color: Colors.white,
        //         ),
        //         onPressed: () {
        //           Get.back();
        //         },
        //       ),
        //       centerTitle: true,
        //       title: Text(
        //         "Add advertisement",
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     ),
        //   ),
        // ),

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
                  onTap: () {
                    // setState(() {
                    //   selectedIndex = index;
                    //   print(selectedIndex);
                    //   if (selectedIndex == 7) {
                    //     logoutDialog_logout(context);
                    //   }
                    // });
                  },
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
                              // color: isSelected ? Colors.red : Colors.black54,
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
        body: Obx(() {
          if (controllerViewAds.loading.value) {
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }

          if (controllerViewAds.viewAds.isEmpty) {
            // return Center(
            //   child: Text(
            //     "No Ads data available",
            //     style: TextStyle(color: Colors.red, fontSize: 16),
            //   ),
            // );
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }
          return Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Dealer Name : ',
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontStyle: FontStyle.italic,
              //               fontWeight: FontWeight.bold,
              //               color: Color(0xff3C3E89),
              //             ),
              //           ),
              //           Text(
              //             '${widget.name}',
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontStyle: FontStyle.italic,
              //               fontWeight: FontWeight.bold,
              //               color: Color(0xff01733D),
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 10),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Date :  ',
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontStyle: FontStyle.italic,
              //               fontWeight: FontWeight.bold,
              //               color: Color(0xff3C3E89),
              //             ),
              //           ),
              //           Text(
              //             '${widget.date}',
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontStyle: FontStyle.italic,
              //               fontWeight: FontWeight.bold,
              //               color: Color(0xff01733D),
              //             ),
              //           ),
              //         ],
              //       ),

              //     ],
              //   ),
              // ),
              const SizedBox(height: 30),
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
                                  // ? Center(
                                  //     child: Text('No image selected'),
                                  //   )
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        controllerViewAds.viewAds[index].ads
                                            .toString(),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
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
          );
        }),
      ),
    );
  }

  Future<void> uploadImagesAPI() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://raxaspread.com/API/api/upload-ads'),
    );

    request.fields['city'] = login_city.toString();
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

      // Get.offAll(() => ScreenAds());
      Get.offAll(() => ScreenAddAds());

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

  doStartLoader(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  bool isLoading = false;
}
