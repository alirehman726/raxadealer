import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_AllDealer.dart';

class ControllerAllDealer extends GetxController {
  RxList<AllDealer> allDealer = <AllDealer>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // controllerAllDealer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllerAllDealer();
    });
  }

  controllerAllDealer() async {
    try {
      loading.value = true;
      var request = http.MultipartRequest(
          'GET', Uri.parse('https://raxaspread.com/API/api/getDealer'));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('ALL Dealer API Call');
        loading.value = false;
        allDealer.value = modelAllDealerFromJson(response.body).data;
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
