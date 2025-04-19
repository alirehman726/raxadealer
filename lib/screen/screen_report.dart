import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Controller/controller_dealerReport.dart';
import 'package:raxaadmin/Widgets/logoutDialog.dart';
import 'package:raxaadmin/screen/screen_menu_item.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenReport extends StatefulWidget {
  @override
  _ScreenReportState createState() => _ScreenReportState();
}

class _ScreenReportState extends State<ScreenReport>
    with SingleTickerProviderStateMixin {
  final controllerDealerReport = Get.find<ControllerDealerreport>();
  @override
  void initState() {
    super.initState();

    // controllerDealerReport.controllerDealerreport();
    String currentMonth = DateTime.now().month.toString();
    String currentYear = DateTime.now().year.toString();

    // API call with current month and year
    controllerDealerReport.controllerDealerreport(
        month: currentMonth, year: currentYear);
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

  String selectedValue = "January";
  List<String> options = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String convertMonthToNumber(String month) {
    Map<String, String> monthMap = {
      "January": "01",
      "February": "02",
      "March": "03",
      "April": "04",
      "May": "05",
      "June": "06",
      "July": "07",
      "August": "08",
      "September": "09",
      "October": "10",
      "November": "11",
      "December": "12",
    };
    return monthMap[month] ?? "01"; // Default January
  }

  String selectedValue1 = "2025";
  List<String> options1 = [
    "2025",
    "2024",
    "2023",
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014"
  ];

  List<Map<String, dynamic>> orderMasterData = [
    {
      "name": "Aditya Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 1,
    },
    {
      "name": "Aditya Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 0,
    },
    {
      "name": "Jay Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 1,
    },
    {
      "name": "Pratik Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 0,
    },
    {
      "name": "Bhautik Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 0,
    },
    {
      "name": "Smit Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 1,
    },
    {
      "name": "Smit Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 1,
    },
    {
      "name": "Bhautik Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 1,
    },
    {
      "name": "Jay Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 0,
    },
    {
      "name": "Aditya Darji",
      "date": "DATE : 03/01/2025",
      "time": "TIME : 03:07 AM",
      "active": 0,
    },
  ];
  final List<Map<String, String>> data = [
    {"name": "Aditya Darji", "sales": "₹25000"},
    {"name": "Jay Darji", "sales": "₹70000"},
    {"name": "Kiran Patel", "sales": "₹2500"},
    {"name": "Bhautik Shah", "sales": "₹8000"},
    {"name": "Karan Panchal", "sales": "₹5000"},
    {"name": "Vishnu Prajapati", "sales": "₹790"},
    {"name": "Mayur Dave", "sales": "₹2400"},
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            iconTheme: IconThemeData(color: Colors.white),

            centerTitle: true,
            // title: Text(
            //   "Retailer Sales",
            //   style: TextStyle(color: Colors.white),
            // ),
            title: user_type == "dealer"
                ? Text(
                    "Retailer Sales",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  )
                : Text(
                    "User Sales",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w400),
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
      body: Column(
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
                          'You’re \n Doing Well',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3C3E89),
                          ),
                        ),
                        // SizedBox(
                        //   width: 100,
                        //   child: Divider(
                        //     color: Color(0xff01B8FA),
                        //     height: 2,
                        //     thickness: 3,
                        //   ),
                        // )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Color(0xff01B8FA),
                            border: Border.all(
                                color: Colors.blue, width: 2), // Blue border
                            borderRadius:
                                BorderRadius.circular(30), // Rounded corners
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedValue1,
                              items: options1.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue1 = newValue!;
                                  print(selectedValue1);
                                  print('selectedValue1');
                                });
                                controllerDealerReport.controllerDealerreport(
                                  month: convertMonthToNumber(
                                      selectedValue), // Function se month number convert hoga
                                  year:
                                      selectedValue1, // Selected year ko pass karein
                                );
                              },
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.black), // Dropdown arrow
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Color(0xff01B8FA),
                            border: Border.all(
                                color: Colors.blue, width: 2), // Blue border
                            borderRadius:
                                BorderRadius.circular(30), // Rounded corners
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
                                        fontSize: 15, color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  print(selectedValue);
                                  print('selectedValue');
                                });
                                controllerDealerReport.controllerDealerreport(
                                  month: convertMonthToNumber(
                                      selectedValue), // Function se month number convert hoga
                                  year:
                                      selectedValue1, // Selected year ko pass karein
                                );
                              },
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.black), // Dropdown arrow
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() {
                  if (controllerDealerReport.loading.value) {
                    return Center(
                        child: CircularProgressIndicator(color: Colors.red));
                  }
                  if (controllerDealerReport.report.isEmpty) {
                    return Center(
                      child: Text(
                        "No orders found for the given filters",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff01B8FA),
                              Color(0xff3C3D86),
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        color: Color(0xff6f91c2),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Dealer Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            Text(
                              "Sales",
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
                          children: List.generate(
                              controllerDealerReport.report.length, (index) {
                            return Container(
                              color: index % 2 == 0
                                  ? Colors.lightBlue[100]
                                  : Colors.lightBlue[300],
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controllerDealerReport
                                        .report[index].dealerName,
                                    // data[index]["name"]!,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    controllerDealerReport
                                        .report[index].totalPrice
                                        .toString(),
                                    // data[index]["sales"]!,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
