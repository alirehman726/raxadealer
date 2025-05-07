import 'package:flutter/widgets.dart'; // 🔥 Required for addPostFrameCallback
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerAds extends GetxController {
  RxList<Ad> allAds = <Ad>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 100));
      controllerAds();
    });
  }

  Future<void> controllerAds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // token = prefs.getString('token');
    print(prefs.getString('token'));
    print("token");
    print(prefs.getString('city_id'));
    print("city_id");
    print(prefs.getString('login_city'));
    print("login_city");
    print(
        "Token_________Token_________Token_________Token_________Token_________Token_________");
    try {
      // ✅ Delay the first reactive update just a bit
      await Future.delayed(Duration(milliseconds: 10));
      loading.value = true;

      var request = http.MultipartRequest(
          'POST', Uri.parse('https://raxaspread.com/API/api/getAdsCityWise'));

      request.fields.addAll({
        'city': prefs.getString('token') == null
            ? prefs.getString('city_id').toString()
            : prefs.getString('login_city').toString()
      });

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('✅ ADS API Call Success');

        allAds.value = modelAdsFromJson(response.body).ads;

        print(response.body);
      } else {
        print("❌ ADS  API Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("❌ ADS  Error fetching products1: $e");
    } finally {
      // ✅ Delay to avoid Obx rebuilding too soon
      await Future.delayed(Duration(milliseconds: 300));
      loading.value = false;
    }
  }
}
