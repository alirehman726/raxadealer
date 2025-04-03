import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_EditDealer.dart';

class ControllerEditDealer extends GetxController {
  RxList<EditDealer> editDealer = <EditDealer>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // controllerEditDealer();
  }

  controllerEditDealer(int id) async {
    try {
      loading.value = true;
      var request = http.MultipartRequest('GET',
          Uri.parse('https://raxaspread.com/API/api/getDealerDetails/${id}'));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('Edit Dealer API Call');
        loading.value = false;
        editDealer.value = modelEditDealerFromJson(response.body).data;
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
