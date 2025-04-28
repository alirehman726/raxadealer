import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Apis/auth_apis.dart';
import 'package:raxaadmin/Controller/controller_allProducts.dart';
import 'package:raxaadmin/Controller/controller_allTrackorder.dart';
import 'package:raxaadmin/Widgets/logoutDialog.dart';
import 'package:raxaadmin/screen/screen_menu_item.dart';
import 'package:raxaadmin/screen/screen_trackOrder.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/myToasts.dart';

class ScreenProduct extends StatefulWidget {
  @override
  _ScreenProductState createState() => _ScreenProductState();
}

class _ScreenProductState extends State<ScreenProduct>
    with SingleTickerProviderStateMixin {
  final controllerAllProducts = Get.find<ControllerAllproducts>();
  TextEditingController searchController = TextEditingController();
  RxString searchQuery = "".obs;

  Map<String, String> amountMap = {};

  List<String> gadiLoad = [];
  List<String> productNames = [];
  List<String> productIds = [];

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

  Future<void> doCallAPILogin(
      List<String> filteredInputs,
      List<String> filteredProductNames,
      List<String> filteredProductIds) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    doStartLoader1(true);

    print(filteredInputs.join(', '));
    print(filteredProductNames.join(', '));
    print(filteredProductIds.join(', '));

    dio.FormData body = dio.FormData.fromMap({
      "user_id": prefs.getString('user_id'),
      "product_id": filteredProductIds.join(', '),
      "product_name": filteredProductNames.join(', '),
      "gadi_load": filteredInputs.join(', '),
    });
    // dio.FormData body = dio.FormData.fromMap({
    //   "user_id": prefs.getString('user_id'),
    //   "product_id": filteredProductIds,
    //   "product_name": filteredProductNames,
    //   "gadi_load": filteredInputs,
    // });
    var res = await AuthApis.orderDataAPI(body);

    if (res != null) {
      Map<String, dynamic> response = json.decode(res.toString());
      print(response);
      print(response['status']);
      if (response['status'] == true) {
        // Fluttertoast.showToast(
        //   msg: response['message'].toString(),
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        //   timeInSecForIosWeb: 1,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
        SnackbarCustom.success("Success", response['message'].toString());

        Get.offAll(() => ScreenTrackOrder());

        final controllerAllTrack = Get.find<ControllerAllTrack>();

        await controllerAllTrack.controllerAllTrack(prefs.getString('user_id'));
        controllerAllTrack.update();
      } else {
        doStartLoader1(false);
        SnackbarCustom.error("Error", response['message']);
        // Fluttertoast.showToast(
        //   msg: response['message'].toString(),
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        //   timeInSecForIosWeb: 1,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      }
    } else {
      doStartLoader1(false);
      SnackbarCustom.error("Error", "Please fill atlest one");
      // Fluttertoast.showToast(
      //   msg: "Something Error ",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 1,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
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
      body: SingleChildScrollView(
        child: Column(
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
                    ],
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controllerAllProducts.loading.value) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }

              var filteredProducts = controllerAllProducts.allProducts
                  .where((product) => product.productName
                      .trim()
                      .toLowerCase()
                      .contains(searchQuery.value.trim()))
                  .toList();

              if (filteredProducts.isEmpty) {
                return Center(
                  child: Text(
                    "No order found",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Table(
                      border: TableBorder.all(color: Colors.black),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(1),
                      },
                      children: [
                        // Header
                        TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xff01B8FA),
                          ),
                          children: [
                            _tableHeader("Product Name"),
                            _tableHeader("Flavore"),
                            _tableHeader("Qty"),
                            _tableHeader("Rate"),
                            _tableHeader("Amount"),
                          ],
                        ),

                        // Product Rows
                        ...List.generate(filteredProducts.length, (rowIndex) {
                          var product = filteredProducts[rowIndex];
                          String productId = product.id.toString();
                          String productName = product.productName ?? '';

                          // Initialize maps if not present
                          gadiLoadMap.putIfAbsent(productId, () => '');
                          productNamesMap.putIfAbsent(
                              productId, () => productName);
                          productIdsMap.putIfAbsent(productId, () => productId);
                          return TableRow(
                            children: [
                              _tableCell(product.productName ?? ''),
                              _tableCell(product.flavour?.toString() ?? ''),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: gadiLoadMap[productId],
                                    onChanged: (value) {
                                      setState(() {
                                        gadiLoadMap[productId] = value;

                                        double gadiLoad =
                                            double.tryParse(value) ?? 0.0;
                                        double price = double.tryParse(
                                                product.price?.toString() ??
                                                    '0') ??
                                            0.0;
                                        double amount = gadiLoad * price;

                                        amountMap[productId] =
                                            amount.toStringAsFixed(2);
                                      });
                                    },
                                    style: TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              _tableCell(product.price?.toString() ?? ''),
                              _tableCell(amountMap[productId] ?? '0'),
                            ],
                          );

                          // return TableRow(
                          //   children: [
                          //     _tableCell(product.productName ?? ''),
                          //     _tableCell(product.flavour?.toString() ?? ''),
                          //     Padding(
                          //       padding: const EdgeInsets.all(12.0),
                          //       child: Center(
                          //         child: TextFormField(
                          //           keyboardType: TextInputType.number,
                          //           initialValue: gadiLoadMap[productId],
                          //           onChanged: (value) {
                          //             setState(() {
                          //               gadiLoadMap[productId] = value;
                          //             });
                          //           },
                          //           style: TextStyle(fontSize: 16),
                          //           decoration: InputDecoration(
                          //             isDense: true,
                          //             contentPadding: EdgeInsets.symmetric(
                          //                 horizontal: 10, vertical: 8),
                          //             border: OutlineInputBorder(),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     _tableCell(product.price?.toString() ?? ''),
                          //     _tableCell(product.price?.toString() ?? ''),
                          //   ],
                          // );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(''),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "₹ ${calculateTotalAmount().toStringAsFixed(2)}", // ₹ symbol optional
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _actionButton('Cancel', Color(0xffFF8800), () {
                        Get.back();
                      }),
                      _actionButton('Submit', Color(0xff0158FA), () {
                        // print('User Inputs: ${gadiLoadMap.values.toList()}');
                        // print(
                        //     'Product Names: ${productNamesMap.values.toList()}');
                        // print('Product IDs: ${productIdsMap.values.toList()}');
                        final filteredEntries = gadiLoadMap.entries
                            .where((entry) => entry.value.trim().isNotEmpty)
                            .toList();

                        final filteredInputs =
                            filteredEntries.map((e) => e.value).toList();
                        final filteredProductIds =
                            filteredEntries.map((e) => e.key).toList();
                        final filteredProductNames = filteredProductIds
                            .map((id) => productNamesMap[id] ?? '')
                            .toList();

                        print('User Inputs: $filteredInputs');
                        print('Product Names: $filteredProductNames');
                        print('Product IDs: $filteredProductIds');

                        doCallAPILogin(filteredInputs, filteredProductNames,
                            filteredProductIds);
                      }),
                    ],
                  ),
                  SizedBox(height: 30),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  double calculateTotalAmount() {
    double total = 0.0;
    amountMap.forEach((key, value) {
      total += double.tryParse(value) ?? 0.0;
    });
    return total;
  }

  // Use Map for better data tracking
  Map<String, String> gadiLoadMap = {};
  Map<String, String> productNamesMap = {};
  Map<String, String> productIdsMap = {};

  // Helpers
  Widget _tableHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _tableCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _actionButton(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 80,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
