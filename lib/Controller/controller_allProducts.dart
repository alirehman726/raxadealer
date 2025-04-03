import 'package:flutter/widgets.dart'; // 🔥 Required for addPostFrameCallback
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/ModelAllProducts.dart';

class ControllerAllproducts extends GetxController {
  RxList<AllProducts> allProducts = <AllProducts>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 🔥 API कॉल को UI Build के बाद रन कराने के लिए
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllerAllProducts();
    });
  }

  Future<void> controllerAllProducts() async {
    try {
      loading.value = true;

      var request = http.MultipartRequest(
          'GET', Uri.parse('https://raxaspread.com/API/api/allproduct'));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('✅ API Call Success');

        var products = modelAllProductsFromJson(response.body).data;

        if (products.isNotEmpty) {
          allProducts.assignAll(products); // 🔥 Correct way to update
        } else {
          allProducts.clear(); // 🔥 If no products, clear list safely
        }
        print(response.body);
      } else {
        print("❌ API Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("❌ Error fetching products: $e");
    } finally {
        Future.delayed(Duration(milliseconds: 500), () {
          loading.value = false; // 🔥 Delay to ensure UI stability
        });
    }
  }
}
