import 'package:raxaadmin/Model/orderHistory_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderHistoryController extends GetxController {
  RxList<OrderHistory> orderHistory_data = <OrderHistory>[].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    orderHistoryController("2");
    super.onInit();
  }

  orderHistoryController(String index) async {
    loading.value = true;
    var request = http.MultipartRequest('POST',
        Uri.parse('https://thevegstory.com/tvsadmin/api/order_history'));

    request.fields.addAll({'table_id': index.toString()});
    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('OrderHistory ${response.body}');
      loading.value = false;
      orderHistory_data.value = orderHistoryModelFromJson(response.body).data;
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}
