import 'package:raxaadmin/Model/menu_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Menu_tvs_Controller extends GetxController {
  RxList<MenuData> menuData = <MenuData>[].obs;
  RxList<MenuData> originalMenuData = <MenuData>[].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    menuController();
    super.onInit();
  }

  menuController() async {
    loading.value = true;
    var request = http.MultipartRequest(
        'GET', Uri.parse('https://thevegstory.com/tvsadmin/api/menu'));

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('AAAAAAAAAAAAAAAAAAAAAA  menu');
      loading.value = false;
      menuData.value = menuModelFromJson(response.body).data;
      originalMenuData.value = menuModelFromJson(response.body).data;
      print('pendingOrder_Data.value');
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}
