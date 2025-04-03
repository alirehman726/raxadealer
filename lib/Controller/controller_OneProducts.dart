import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_OneProducts.dart';

class ControllerOneproducts extends GetxController {
  RxList<OneProduct> oneProducts = <OneProduct>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // controllerOneProducts();
  }

  controllerOneProducts(int productsId) async {
    try {
      loading.value = true;
      var request = http.MultipartRequest(
          'GET',
          Uri.parse(
              'https://raxaspread.com/API/api/sigleproduct/${productsId}'));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('One Products API Call');
        loading.value = false;
        oneProducts.value = [modelOneProductsFromJson(response.body).data];
        print(response.body);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("❌ Error fetching tables: $e");
    } finally {
      loading.value = false;
    }
  }
}
