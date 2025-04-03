import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_viewAds.dart';

class ControllerViewAds extends GetxController {
  RxList<ViewAds> viewAds = <ViewAds>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // controllerViewAds();
  }

  controllerViewAds(String id) async {
    try {
      loading.value = true;
      var request = http.MultipartRequest('GET',
          Uri.parse('https://raxaspread.com/API/api/getAdsDetails/${id}'));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('View Ads API Call');
        loading.value = false;
        viewAds.value = modelAllAdsFromJson(response.body).data;
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
