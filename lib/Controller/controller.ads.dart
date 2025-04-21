import 'package:flutter/widgets.dart'; // 🔥 Required for addPostFrameCallback
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_ads.dart';

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
    try {
      // ✅ Delay the first reactive update just a bit
      await Future.delayed(Duration(milliseconds: 10));
      loading.value = true;

      var request = http.MultipartRequest(
          'POST', Uri.parse('https://raxaspread.com/API/api/getAdsCityWise'));

      request.fields.addAll({'city': ""});

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
