import 'package:raxaadmin/Model/tableModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TableController extends GetxController {
  // RxList<Table> table = <Table>[].obs;
  var table = <TableData>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    tableController();
  }

  tableController() async {
    try {
      loading.value = true;
      var request = http.MultipartRequest(
          'GET', Uri.parse('https://thevegstory.com/tvsadmin/api/table'));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('AAAAAAAAAAAAAAAAAAAAAA');
        loading.value = false;
        table.value = tableModelFromJson(response.body).data;
        print('pendingOrder_Data.value');
        print(response.body);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("❌ Error fetching tables: $e");
    } finally {
      loading.value = false; // ✅ Data Load Complete
    }
  }
}
