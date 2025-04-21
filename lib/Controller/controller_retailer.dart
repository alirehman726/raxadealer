import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_retailer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerAllRetailer extends GetxController {
  RxList<Retailer> allRetailer = <Retailer>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // controllerAllDealer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // controllerAllRetailer();
    });
  }

  controllerAllRetailer(String? city_Id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(city_Id);
    print('Khadim');
    try {
      loading.value = true;
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://raxaspread.com/API/api/getRetailerNear'));
      request.fields.addAll(
        {
          'city': '${city_Id}',
        },
      );

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('ALL Dealer API Call');
        loading.value = false;
        allRetailer.value = modelAllRetailerFromJson(response.body).data;
        print(response.body);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("❌ Error fetching tables: $e");
    } finally {
      // loading.value = false;
      Future.delayed(Duration(milliseconds: 500), () {
        loading.value = false; // 🔥 Delay to ensure UI stability
      });
    }
  }
}
