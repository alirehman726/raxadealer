import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_retailer.dart';
import 'package:raxaadmin/Widgets/logoutDialog.dart';
import 'package:raxaadmin/screen/screen_drawer.dart';
import 'package:raxaadmin/screen/screen_menu_item.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenNearByRetailer extends StatefulWidget {
  @override
  _ScreenNearByRetailerState createState() => _ScreenNearByRetailerState();
}

class _ScreenNearByRetailerState extends State<ScreenNearByRetailer>
    with SingleTickerProviderStateMixin {
  final controllerAllRetailer = Get.find<ControllerAllRetailer>();
  TextEditingController searchController = TextEditingController();
  RxString searchQuery = "".obs;

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery.value = query.toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();

    apiPassData();
    loadUserData();
    loadMenuItems();
  }

  late List<Map<String, dynamic>> menuItems;
  void apiPassData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('city_id'));
    print(prefs.getString('login_city'));
    print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");

    setState(() {
      if (prefs.getString('token') == null) {
        controllerAllRetailer.controllerAllRetailer(prefs.getString('city_id'));
      } else {
        controllerAllRetailer
            .controllerAllRetailer(prefs.getString('login_city'));
      }
    }); // UI update
  }

  void loadMenuItems() async {
    String userType = "dealer"; // ya SharedPreferences se le lo
    menuItems = await getMenuItems(userType);
    setState(() {}); // UI update
  }

  List<Map<String, dynamic>> dealerData = [
    {
      "name": "Aditya Darji",
      "desc": "RAXADEAL001",
      "active": 1,
    },
    {
      "name": "Aditya Darji",
      "desc": "RAXADEAL002",
      "active": 0,
    },
    {
      "name": "Jay Darji",
      "desc": "RAXADEAL003",
      "active": 1,
    },
    {
      "name": "Pratik Darji",
      "desc": "RAXADEAL004",
      "active": 0,
    },
    {
      "name": "Bhautik Darji",
      "desc": "RAXADEAL005",
      "active": 0,
    },
    {
      "name": "Smit Darji",
      "desc": "RAXADEAL006",
      "active": 1,
    },
    {
      "name": "Smit Darji",
      "desc": "RAXADEAL007",
      "active": 1,
    },
    {
      "name": "Bhautik Darji",
      "desc": "RAXADEAL008",
      "active": 1,
    },
    {
      "name": "Jay Darji",
      "desc": "RAXADEAL009",
      "active": 0,
    },
    {
      "name": "Aditya Darji",
      "desc": "RAXADEAL010",
      "active": 0,
    },
  ];

  String getInitials(String name) {
    List<String> words = name.trim().split(" ");
    if (words.length == 1) {
      return words[0][0]
          .toUpperCase(); // Sirf ek word hai to uska pehla letter return karega
    } else {
      return (words[0][0] + words[1][0])
          .toUpperCase(); // Pehle aur doosre word ka first letter return karega
    }
  }

  int selectedIndex = 0;
  bool isSwitched = false;
  final Color fixedColor = getRandomColor();

  Future<void> doCallAPILogin(int id, String status) async {
    doStartLoader(true);

    dio.FormData body = dio.FormData.fromMap({
      "user_id": id.toString(),
      "status": status.toString(),
    });
    var res = await AuthApis.changeStatusAPI(body);

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
      // SnackbarCustom.error("Error",
      //     "Unable_to_login_at_the_moment_Please_try_again_after_sometime");
    }
  }

  bool isLoading = false;

  doStartLoader(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  String? username;
  String? email;

  void _launchURL() async {
    const url =
        'https://www.design-blitz.com/'; // 👈 Replace with your actual link
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'ADMIN';
      email = prefs.getString('email') ?? 'example@gmail.com';
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
            "Near By Retailer Page",
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
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 20),
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
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xff2596BE)),
                padding: EdgeInsets.only(left: 20, right: 20),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: updateSearchQuery,
                        decoration: InputDecoration(
                          hintText: "Search here",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.white),
                  ],
                ),
              ),
            ),
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
                            'Show All Retailer’s',
                            style: TextStyle(
                              fontSize: 20,
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
                      // InkWell(
                      //   onTap: () {
                      //     Get.to(() => ScreenAddDealer());
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      //       color: Color(0xff3C3E89),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius:
                      //                 BorderRadius.all(Radius.circular(20.0)),
                      //             color: Colors.white,
                      //           ),
                      //           child: Icon(
                      //             Icons.add,
                      //             color: Color(0xff3C3E89),
                      //             size: 20,
                      //           ),
                      //         ),
                      //         const SizedBox(width: 10),
                      //         Text(
                      //           'ADD NEW DILLER',
                      //           style:
                      //               TextStyle(color: Colors.white, fontSize: 11),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controllerAllRetailer.loading.value) {
                return Center(
                    child: CircularProgressIndicator(color: Colors.red));
              }

              var filteredProducts = controllerAllRetailer.allRetailer
                  .where((dealer) => dealer.name
                      .trim()
                      .toLowerCase()
                      .contains(searchQuery.value.trim()))
                  .toList();

              if (filteredProducts.isEmpty) {
                // ✅ Ensure search results are shown
                return Center(
                  child: Text(
                    "No Dealer data available",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              }

              // if (controllerAllDealer.allDealer.isEmpty) {
              //   return Center(
              //     child: Text(
              //       "No Dealer data available",
              //       style: TextStyle(color: Colors.red, fontSize: 16),
              //     ),
              //   );
              // }
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffe6f8ff),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  child: ListView.builder(
                    // itemCount: controllerAllDealer.allDealer.length,
                    itemCount: filteredProducts.length,

                    itemBuilder: (context, index) {
                      var dealer = filteredProducts[index];

                      return Column(
                        children: [
                          Row(
                            children: [
                              // Expanded(
                              //   flex: 1,
                              //   child: Container(
                              //     height: 60,
                              //     width: 60,
                              //     child: CircleAvatar(
                              //       radius: 60,
                              //       backgroundColor: (() {
                              //         Color randomColor = getRandomColor();
                              //         return randomColor.withOpacity(0.5);
                              //       })(),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8),
                              //         child: ClipOval(
                              //           child: CircleAvatar(
                              //             radius: 50,
                              //             backgroundColor: (() {
                              //               Color randomColor = getRandomColor();
                              //               return randomColor;
                              //             })(),
                              //             child: Text(
                              //               'AD',
                              //               style: TextStyle(
                              //                   fontSize: 20,
                              //                   color: Colors.white,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: getColorFromHex(
                                            controllerAllRetailer
                                                .allRetailer[index].colorCode)
                                        .withOpacity(0.5),
                                    // backgroundColor: fixedColor.withOpacity(
                                    //     0.5), // Fixed color with opacity
                                    // child: Padding(
                                    //   padding: const EdgeInsets.all(8),
                                    //   child: ClipOval(
                                    //     child: CircleAvatar(
                                    //       radius: 50,
                                    //       backgroundColor: getColorFromHex(
                                    //           controllerAllRetailer
                                    //               .allRetailer[index]
                                    //               .colorCode),
                                    //       // backgroundColor:
                                    //       //     fixedColor, // Fixed color
                                    //       child: Text(
                                    //         getInitials(dealer.name),
                                    //         // 'AD',
                                    //         style: TextStyle(
                                    //           fontSize: 20,
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ClipOval(
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: getColorFromHex(
                                            controllerAllRetailer
                                                .allRetailer[index].colorCode,
                                          ),
                                          child: Image.network(
                                            dealer.profileImage,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   dealer.name,
                                      //   // dealerData[index]['name'],
                                      //   style: TextStyle(
                                      //     fontSize: 17,
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Color(0xff3C3E89),
                                      //   ),
                                      // ),
                                      Text(
                                        dealer.name,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff3C3E89),
                                        ),
                                        maxLines: 1, // Maximum 2 lines
                                        overflow: TextOverflow
                                            .ellipsis, // 2nd line ke baad "..."
                                      ),

                                      Text(
                                        dealer.username,
                                        // dealerData[index]['desc'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                          color: Color(0xff3C3E89),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Divider(
                            color: Colors.black,
                            height: 2,
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor
        .replaceAll("#", "")
        .toUpperCase(); // "#" ko remove kare aur uppercase kare

    final validHex =
        RegExp(r'^[0-9A-Fa-f]{6}$'); // Sirf valid hex colors allow kare
    if (!validHex.hasMatch(hexColor)) {
      print("Invalid color code: $hexColor");
      return Colors.primaries[
          hexColor.hashCode % Colors.primaries.length]; // Random unique color
    }

    return Color(int.parse("0xff$hexColor"));
  }
}

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
