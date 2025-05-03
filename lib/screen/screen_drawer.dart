import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Controller/controller.ads.dart';
import 'package:raxaadmin/Controller/controller_allProducts.dart';
import 'package:raxaadmin/Model/ModelAllProducts.dart';
import 'package:raxaadmin/Widgets/logoutDialog.dart';
import 'package:raxaadmin/screen/screen_menu_item.dart';
import 'package:raxaadmin/screen/screen_products_details.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'userPopup.dart';

class ScreenDrawer extends StatefulWidget {
  @override
  _ScreenDrawerState createState() => _ScreenDrawerState();
}

class _ScreenDrawerState extends State<ScreenDrawer>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();
  final controllerAllProducts = Get.find<ControllerAllproducts>();
  final controllerAds = Get.find<ControllerAds>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controllerAllProducts.controllerAllProducts();
    controllerAds.controllerAds();

    loadUserData();
    dataGet();
    // userModel();
  }

  String? cityId;

  Future<void> dataGet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cityId = prefs.getString('city_id');

    // prefs.remove('city_id');

    if (cityId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) => UserFormPopup(),
        );
      });
    } else {}
  }

  late List<Map<String, dynamic>> menuItems;

  String? username;
  String? email;
  String? user_type;
  String? user_id;
  String? token;
  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

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
  Widget _buildProductGrid(RxList<AllProducts> allProducts) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemCount: allProducts.length,
        itemBuilder: (context, index) {
          return _buildProductCard(allProducts[index].toJson());
        },
      ),
    );
  }

  Widget _buildProductCard(product) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffccf1fe),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => ScreenProductsDetails(productsId: product['id']));
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product['image'].toString(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 100, // reduced for smaller width
                  ),
                ),
                Positioned(
                  bottom: -10,
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    alignment: Alignment.center,
                    child: Text(
                      "₹ ${product['price'].toString()}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              product['product_name'].toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Color(0xff3C3D86),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildProductGrid(RxList<AllProducts> allProducts) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 20, right: 20),
  //     child: GridView.builder(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 20,
  //         mainAxisSpacing: 20,
  //         childAspectRatio: 0.8,
  //       ),
  //       itemCount: allProducts.length,
  //       itemBuilder: (context, index) {
  //         return _buildProductCard(allProducts[index].toJson());
  //       },
  //     ),
  //   );
  // }

  // Widget _buildProductCard(product) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Color(0xffccf1fe),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             Get.to(() => ScreenProductsDetails(productsId: product['id']));
  //           },
  //           child: Stack(
  //             clipBehavior: Clip.none,
  //             children: [
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(12),
  //                 child: Image.network(
  //                   product['image'].toString(),
  //                   // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //                   fit: BoxFit.cover,
  //                   width: double.infinity,
  //                   height: 120,
  //                 ),
  //               ),
  //               Positioned(
  //                 bottom: -12,
  //                 left: 25,
  //                 right: 25,
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(20),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.black26,
  //                         blurRadius: 4,
  //                         spreadRadius: 1,
  //                       ),
  //                     ],
  //                   ),
  //                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
  //                   alignment: Alignment.center,
  //                   width: 80,
  //                   child: Text(
  //                     "₹ ${product['price'].toString()}",
  //                     style: TextStyle(
  //                       fontSize: 11,
  //                       fontWeight: FontWeight.w500,
  //                       color: Colors.blue,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 20), // Taaki name aur spacing maintain ho
  //         Text(
  //           product['product_name'].toString(),
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             fontSize: 12,
  //             fontWeight: FontWeight.bold,
  //             color: Color(0xff3C3D86),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Raxa Agarbatti"),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                ),
              )
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
                token != null
                    ? InkWell(
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
                      )
                    : Container(),
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
            () => controllerAllProducts.loading.value
                ? Center(child: CircularProgressIndicator(color: Colors.red))
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          // SizedBox(
                          //   height: 200,
                          //   child: ListView(
                          //     shrinkWrap: true,
                          //     physics: NeverScrollableScrollPhysics(),
                          //     children: [
                          //       CarouselSlider(
                          //         items: imageUrls.map((imageUrl) {
                          //           return Container(
                          //             margin: EdgeInsets.all(6.0),
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(8.0),
                          //               image: DecorationImage(
                          //                 image: NetworkImage(imageUrl),
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //           );
                          //         }).toList(),
                          //         options: CarouselOptions(
                          //           height: 180.0,
                          //           enlargeCenterPage: true,
                          //           autoPlay: true,
                          //           aspectRatio: 16 / 9,
                          //           autoPlayCurve: Curves.fastOutSlowIn,
                          //           enableInfiniteScroll: true,
                          //           autoPlayAnimationDuration:
                          //               Duration(milliseconds: 800),
                          //           viewportFraction: 0.8,
                          //           onPageChanged: (index, reason) {
                          //             setState(() {
                          //               _currentIndex = index;
                          //             });
                          //           },
                          //         ),
                          //       ),
                          //       SizedBox(height: 10),
                          //       Center(
                          //         child: AnimatedSmoothIndicator(
                          //           activeIndex: _currentIndex,
                          //           count: imageUrls.length,
                          //           effect: ExpandingDotsEffect(
                          //             dotHeight: 8,
                          //             dotWidth: 8,
                          //             activeDotColor: Colors.blue,
                          //             dotColor: Colors.grey,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 200,
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                CarouselSlider(
                                  items: controllerAds.allAds.map((image) {
                                    print(controllerAds.allAds[0].ads);
                                    return Container(
                                      margin: EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          image: NetworkImage(image.ads),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  options: CarouselOptions(
                                    height: 180.0,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                    aspectRatio: 16 / 9,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    viewportFraction: 0.8,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: AnimatedSmoothIndicator(
                                    activeIndex: _currentIndex,
                                    count: controllerAds.allAds.length,
                                    effect: ExpandingDotsEffect(
                                      dotHeight: 8,
                                      dotWidth: 8,
                                      activeDotColor: Colors.blue,
                                      dotColor: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // 'All Product’s',
                                  'Hi ${username}',
                                  style: TextStyle(
                                    fontSize: 24,
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
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                _buildProductGrid(
                                    controllerAllProducts.allProducts),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }
}
