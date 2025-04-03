import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/Controller/controller_AllDealer.dart';
import 'package:raxaadmin/Controller/controller_EditDealer.dart';
import 'package:raxaadmin/Controller/controller_OneProducts.dart';
import 'package:raxaadmin/Controller/controller_allAds.dart';
import 'package:raxaadmin/Controller/controller_allOrder.dart';
import 'package:raxaadmin/Controller/controller_allProducts.dart';
import 'package:raxaadmin/Controller/controller_dealerReport.dart';
import 'package:raxaadmin/Controller/controller_viewAds.dart';
import 'package:raxaadmin/screen/LacaleString.dart';
import 'package:raxaadmin/screen/splash_screen.dart';
import 'package:raxaadmin/utils/color.dart';

import 'Controller/controller_view_order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Screen Util Initialize
  await ScreenUtil.ensureScreenSize();
  HttpOverrides.global = MyHttpOverrides();

  // Get.put(DashboardController());
  Get.put(ControllerAllproducts());
  Get.put(ControllerOneproducts());
  Get.put(ControllerAllOrder());
  Get.put(ControllerViewOrder());
  Get.put(ControllerAllAds());
  Get.put(ControllerViewAds());
  Get.put(ControllerAllDealer());
  Get.put(ControllerEditDealer());
  Get.put(ControllerDealerreport());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return ScreenUtilInit(
      child: GetMaterialApp(
        title: "GG delivery",
        debugShowCheckedModeBanner: false,
        translations: LocaleString(),
        locale: Locale('en', 'US'),
        theme: ThemeData(
            fontFamily: "Poppins",
            primarySwatch: Colors.grey,
            scaffoldBackgroundColor: scaffoldColor,
            appBarTheme: AppBarTheme(
              color: white,
              centerTitle: true,
              elevation: 0,
            )),
        home: SplashScreen(),
        // home: ExpandableListView(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ExpandableListView extends StatefulWidget {
  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expandable List'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffE2EAF2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('Your Container Content Here'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ExpandedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Expanded Container',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
