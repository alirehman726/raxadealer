import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_allProducts.dart';
import 'package:raxaadmin/Widgets/logoutDialog.dart';
import 'package:raxaadmin/Widgets/myToasts.dart';
import 'package:raxaadmin/screen/screen_ads.dart';
import 'package:raxaadmin/screen/screen_dealer.dart';
import 'package:raxaadmin/screen/screen_drawer.dart';
import 'package:raxaadmin/screen/screen_report.dart';
import 'package:raxaadmin/screen/screen_view_order.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenProduct extends StatefulWidget {
  @override
  _ScreenProductState createState() => _ScreenProductState();
}

class _ScreenProductState extends State<ScreenProduct>
    with SingleTickerProviderStateMixin {
  final controllerAllProducts = Get.find<ControllerAllproducts>();
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
    controllerAllProducts.controllerAllProducts();
    loadUserData();
  }

  List<Map<String, dynamic>> menuItems = [];
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
      buildMenuItems();
    });
  }

  void buildMenuItems() {
    menuItems = [
      {
        "icon": Images.DRAWER_1,
        "title": "Home",
        "route": () => ScreenDrawer(),
      },
      {
        "icon": Images.DRAWER_2,
        "title": "Add Order",
        "route": () => ScreenProduct(),
      },
      {
        "icon": Images.DRAWER_3,
        "title": "Track Order",
        "route": () => ScreenViewOrder(),
      },
      {
        "icon": Images.DRAWER_4,
        "title": "Add Advertisement",
        "route": () => ScreenAds(),
      },
      {
        "icon": Images.DRAWER_5,
        "title": user_type == "dealer" ? "Add Retailer" : "Add user",
        "route": () => ScreenDealer(),
      },
      {
        "icon": Images.DRAWER_6,
        "title": user_type == "dealer" ? "Retailer Sales" : "User Sales",
        "route": () => ScreenReport(),
      },
    ];
  }

  // List<Map<String, dynamic>> menuItems = [
  //   {
  //     "icon": Images.DRAWER_1,
  //     "title": "Home",
  //     "route": () => ScreenDrawer(),
  //   },
  //   {
  //     "icon": Images.DRAWER_2,
  //     "title": "Add Order",
  //     "route": () => ScreenProduct(),
  //   },
  //   {
  //     "icon": Images.DRAWER_3,
  //     "title": "Track Order",
  //     "route": () => ScreenViewOrder(),
  //   },
  //   {
  //     "icon": Images.DRAWER_4,
  //     "title": "Add Advertisement",
  //     "route": () => ScreenAds(),
  //   },
  //   {
  //     "icon": Images.DRAWER_5,
  //    "title": user_type == "dealer" ? "Add Retailer" : "Add user",
  //     "route": () => ScreenDealer(),
  //   },
  //   {
  //     "icon": Images.DRAWER_6,
  //     "title": "Retailer Sales",
  //     "route": () => ScreenReport(),
  //   },
  // ];

  int selectedIndex = 0;

  void deleteItem(int id) async {
    var res = await AuthApis.deleteOrderApi(id);

    if (res != null) {
      Map<String, dynamic> response = json.decode(res.toString());

      if (response['status'] == true) {
        // ✅ API Call करके डेटा अपडेट करो
        await controllerAllProducts.controllerAllProducts();

        // ✅ UI अपडेट करो
        setState(() {
          isLoading = false;
        });

        print("✅ Data refreshed successfully!");
        // if (controllerAllProducts.controllerAllProducts) {
        //   Get.back(); // ✅ Model Close
        // }
      } else {
        setState(() {
          isLoading = false;
        });
        SnackbarCustom.error("Error", response['message']);
      }
    } else {
      throw Exception("No Response from API");
    }
  }

  Future<void> doCallAPILogin(int id, String status) async {
    doStartLoader1(true);

    dio.FormData body = dio.FormData.fromMap({
      "product_id": id.toString(),
      "status": status.toString(),
    });
    var res = await AuthApis.productStatusAPI(body);

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
        doStartLoader1(false);
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
      doStartLoader1(false);
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
  bool isLoading1 = false;

  doStartLoader1(bool val) {
    setState(() {
      isLoading1 = val;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffccf1fe),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff01B8FA),
        title: Text(
          "Add Order",
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
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                  color: Color(0xff2596BE)
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Colors.blue,
                  //     Colors.lightBlueAccent
                  //   ], // Gradient background
                  //   begin: Alignment.centerLeft,
                  //   end: Alignment.centerRight,
                  // ),
                  ),
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: updateSearchQuery,
                      decoration: InputDecoration(
                        hintText: "Search Product",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none, // No underline
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Icon(Icons.search, color: Colors.white), // Search Icon
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
                          'All Order’s',
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
                    //     Get.to(() => ScreenAddProducts());
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
                    //           'ADD NEW PRODUCT',
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
            if (controllerAllProducts.loading.value) {
              return Center(
                  child: CircularProgressIndicator(color: Colors.red));
            }

            var filteredProducts = controllerAllProducts.allProducts
                .where((product) => product.productName
                    .trim()
                    .toLowerCase()
                    .contains(searchQuery.value.trim()))
                .toList();

            if (filteredProducts.isEmpty) {
              // ✅ Ensure search results are shown
              return Center(
                child: Text(
                  "No order found",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                // itemCount: filteredProducts.length,
                itemCount: 5,
                itemBuilder: (context, index) {
                  var product = filteredProducts[index];
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(
                                  "https://s3-alpha-sig.figma.com/img/a31e/7e5f/b52e4c3dc054a42d25af063bd8a87a6d?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=gPX2k4BgfXir5NCjhfoewKi9P4tDfxfqFqhHVoVViuFBvuRSN5LWaSvdx0Wg76OGrSGhOJl4kxN2L16FEdFd1VAs-HsViPGeus33BGWwTen8clYgf2URk9IvAuAhBgUOnD0AG5JObVCVFb8Jtv2ztpsztsbnOZNt~p7DnAyNjFMjTGlHrA0PXnQnX8ZYBZmR4DWJ5PzkLd6rb2GAglhItmXPaRbqpb4Q7TaL25MdnrQcXtr6iajdBkGvbLyLiS18D0t21mkVct9O6QibjVqm-jgj38Y7vaQPrqdeZdECouppA7zBZ3~FG-xUHq1hlOT3hCvIoNBJuLZsFFYSw5N0zA__"
                                      .toString(), // ✅ Correct product reference
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "JPSR Prabhu Shriram",
                                      // "${product.productName} - ${product.discription}",
                                      style: TextStyle(
                                          color: Color(0xff3C3D86),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    Text(
                                      "IN Stock : Yes",
                                      // "IN Stock : ${product.stock}",
                                      style: TextStyle(
                                          color: Color(0xff01B8FA),
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: InkWell(
                                            onTap: _decrement,
                                            child: Icon(Icons.minimize_sharp),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Container(
                                          child: Icon(
                                            Icons.delete_outline_outlined,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        InkWell(
                                          onTap: _increment,
                                          child: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Total: $_count',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }

  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }
}
