import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_allOrder.dart';
import 'package:raxaadmin/Controller/controller_view_order.dart';
import 'package:raxaadmin/Widgets/logoutDialog.dart';
import 'package:raxaadmin/screen/screen_menu_item.dart';
import 'package:raxaadmin/screen/screen_order_master.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenViewOrder extends StatefulWidget {
  const ScreenViewOrder({super.key});

  @override
  State<ScreenViewOrder> createState() => _ScreenViewOrderState();
}

class _ScreenViewOrderState extends State<ScreenViewOrder> {
  final controllerViewProducts = Get.find<ControllerViewOrder>();

  @override
  void initState() {
    super.initState();

    controllerViewProducts.controllerViewOrder("1".toString());
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

  final List<Map<String, String>> data = [
    {"name": "Aditya Darji", "quntity": "10", "sales": "₹25000"},
    {"name": "Jay Darji", "quntity": "20", "sales": "₹70000"},
    {"name": "Kiran Patel", "quntity": "20", "sales": "₹2500"},
    {"name": "Bhautik Shah", "quntity": "25", "sales": "₹8000"},
  ];

  int selectedIndex = 0;

  String selectedValue = "pending";
  List<String> options = [
    "pending",
    "dispatch",
  ];

  Future<void> doCallAPILogin(String status) async {
    doStartLoader(true);

    dio.FormData body = dio.FormData.fromMap({
      "order_id": 2,
      "status": status.toString(),
    });
    var res = await AuthApis.chnageOrderStatusAPI(body);

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

        Get.offAll(() => ScreenOrderMaster());

        final controllerAllOrder = Get.find<ControllerAllOrder>();

        await controllerAllOrder.controllerAllOrder();
        controllerAllOrder.update();
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
      resizeToAvoidBottomInset: true, // Prevents keyboard overflow
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

            centerTitle: true,
            title: Text(
              "Track Order",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
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

      body: Obx(
        () {
          if (controllerViewProducts.loading.value) {
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }
          if (controllerViewProducts.viewOrder.isEmpty) {
            return Center(
              child: Text(
                "No Ads data available",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return Column(
            children: [
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
                              'Track Order Detail :-',
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
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      color: Color(0xff6f91c2),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Product",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          Text(
                            "Quantity",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          Text(
                            "Price",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    // Data Rows
                    SingleChildScrollView(
                      child: Column(
                        children: List.generate(data.length, (index) {
                          print(controllerViewProducts.viewOrder);
                          print("controllerViewProducts.viewOrder");
                          return Container(
                            color: index % 2 == 0
                                ? Colors.lightBlue[100]
                                : Colors.lightBlue[300],
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // controllerViewProducts
                                  //     .order[index].productName,
                                  data[index]["name"]!,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  // controllerViewProducts.order[index].quantity
                                  //     .toString(),
                                  data[index]["quntity"]!,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  // "₹  ${controllerViewProducts.order[index].price.toString()}",
                                  data[index]["sales"]!,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         // Get.back();
                    //         Get.dialog(
                    //           AlertDialog(
                    //             title: Text('Are You Sure You Want To change'),
                    //             //content: Text("This should not be closed automatically"),
                    //             actions: <Widget>[
                    //               TextButton(
                    //                 child: Text('Yes'),
                    //                 onPressed: () async {
                    //                   doCallAPILogin("approve");
                    //                 },
                    //               ),
                    //               TextButton(
                    //                 child: Text('No'),
                    //                 onPressed: () {
                    //                   Get.back();
                    //                 },
                    //               )
                    //             ],
                    //           ),
                    //           barrierDismissible: false,
                    //         );
                    //       },
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         width: 130,
                    //         padding: EdgeInsets.only(
                    //             left: 10, right: 10, top: 10, bottom: 10),
                    //         decoration: BoxDecoration(
                    //           color: Color(0xff3FCB1C),
                    //           borderRadius: BorderRadius.circular(7),
                    //         ),
                    //         child: Text(
                    //           'APPROVE',
                    //           style: TextStyle(
                    //             fontSize: 10,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         // Get.back();
                    //         Get.dialog(
                    //           AlertDialog(
                    //             title: Text('Are You Sure You Want To change'),
                    //             //content: Text("This should not be closed automatically"),
                    //             actions: <Widget>[
                    //               TextButton(
                    //                 child: Text('Yes'),
                    //                 onPressed: () async {
                    //                   doCallAPILogin("reject");
                    //                 },
                    //               ),
                    //               TextButton(
                    //                 child: Text('No'),
                    //                 onPressed: () {
                    //                   Get.back();
                    //                 },
                    //               )
                    //             ],
                    //           ),
                    //           barrierDismissible: false,
                    //         );
                    //       },
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         width: 130,
                    //         padding: EdgeInsets.only(
                    //             left: 10, right: 10, top: 10, bottom: 10),
                    //         decoration: BoxDecoration(
                    //           color: Color(0xffFF8800),
                    //           borderRadius: BorderRadius.circular(7),
                    //         ),
                    //         child: Text(
                    //           'REJECT',
                    //           style: TextStyle(
                    //             fontSize: 10,
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedValue,
                                    items: options.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue!;
                                      });
                                    },
                                    icon: Icon(Icons.arrow_drop_down,
                                        color: Colors.black), // Dropdown arrow
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //
                          //
                          //

                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  DateFormat('MM/dd/yyyy').format(
                                      controllerViewProducts
                                          .viewOrder[0].orderDate),

                                  // '03/01/2025',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff3C3D86),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //
                          //
                          //

                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Payment ID',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  controllerViewProducts.viewOrder[0].paymentId
                                      .toString(),
                                  // 'UTRN NO',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff3C3D86),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //
                          //
                          //

                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Action By',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  controllerViewProducts.viewOrder[0].paymentId
                                      .toString(),
                                  // 'RAXADEAL001',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff3C3D86),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(''),
                          //     InkWell(
                          //       onTap: () {
                          //         Get.back();
                          //       },
                          //       child: Container(
                          //         alignment: Alignment.center,
                          //         width: 130,
                          //         padding: EdgeInsets.only(
                          //             left: 10, right: 10, top: 10, bottom: 10),
                          //         decoration: BoxDecoration(
                          //           color: Color(0xff67a5fc),
                          //           borderRadius: BorderRadius.circular(7),
                          //         ),
                          //         child: Text(
                          //           'Submit',
                          //           style: TextStyle(
                          //             fontSize: 10,
                          //             fontWeight: FontWeight.bold,
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
