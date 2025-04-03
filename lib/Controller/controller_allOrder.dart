import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_allOrder.dart';

class ControllerAllOrder extends GetxController {
  RxList<AllOrder> allOrder = <AllOrder>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    controllerAllOrder();
  }

  controllerAllOrder() async {
    try {
      loading.value = true;
      var request = http.MultipartRequest(
          'GET', Uri.parse('https://raxaspread.com/API/api/getorder'));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('ALL Orders API Call');
        loading.value = false;
        allOrder.value = modelAllOrderFromJson(response.body).data;
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
