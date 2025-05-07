import 'package:raxaadmin/screen/Screen_changePassword.dart';
import 'package:raxaadmin/screen/Screen_near_by_retailer.dart';
import 'package:raxaadmin/screen/screen_add_ads.dart';
import 'package:raxaadmin/screen/screen_dealer.dart';
import 'package:raxaadmin/screen/screen_drawer.dart';
import 'package:raxaadmin/screen/screen_login.dart';
import 'package:raxaadmin/screen/screen_product.dart';
import 'package:raxaadmin/screen/screen_trackOrder.dart';
import 'package:raxaadmin/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> getMenuItems(String userType) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');

  if (token == null) {
    return [
      {
        "icon": Images.DRAWER_1,
        "title": "Home",
        "route": () => ScreenDrawer(),
      },
      {
        "icon": Images.DRAWER_3,
        "title": "Near by retailer",
        "route": () => ScreenNearByRetailer(),
      },
      {
        "icon": Images.DRAWER_7,
        "title": "Login",
        "route": () => ScreenLogin(),
      },
    ];
  } else {
    return [
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
        "route": () => ScreenTrackOrder(),
      },
      {
        "icon": Images.DRAWER_3,
        "title": "Near by retailer",
        "route": () => ScreenNearByRetailer(),
      },
      {
        "icon": Images.DRAWER_4,
        "title": "Add Advertisement",
        // "route": () => ScreenAds(),
        "route": () => ScreenAddAds(),
      },
      {
        "icon": Images.DRAWER_5,
        "title": userType == "dealer" ? "Add Retailer" : "Add User",
        "route": () => ScreenDealer(),
      },
      {
        "icon": Images.DRAWER_5,
        "title": "Change Password",
        "route": () => ScreenChangepassword(),
      },
      // {
      //   "icon": Images.DRAWER_6,
      //   "title": userType == "dealer" ? "Retailer Sales" : "User Sales",
      //   "route": () => ScreenReport(),
      // },
    ];
  }
}
