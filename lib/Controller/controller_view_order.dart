import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_view_order.dart';

class ControllerViewOrder extends GetxController {
  RxList<ViewOrder> viewOrder = <ViewOrder>[].obs;
  RxList<Order> order = <Order>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // controllerViewOrder();
  }

  controllerViewOrder(String id) async {
    try {
      loading.value = true;
      var request = http.MultipartRequest('GET',
          Uri.parse('https://raxaspread.com/API/api/orderDetails/${id}'));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('ALL Orders API Call');
        loading.value = false;
        viewOrder.value = [modelViewOrderFromJson(response.body).data];
        order.value = modelViewOrderFromJson(response.body).data.order;
        print(viewOrder.value);
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
