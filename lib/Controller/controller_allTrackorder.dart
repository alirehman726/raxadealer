import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_trackOrder.dart';

class ControllerAllTrack extends GetxController {
  RxList<TrackOrder> alltrack = <TrackOrder>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // controllerAllTrack();
  }

  controllerAllTrack(String? user_id) async {
    try {
      loading.value = true;
      var request = http.MultipartRequest(
          'GET',
          Uri.parse(
              'https://raxaspread.com/API/api/getDealerOrder?user_id=$user_id'));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('ALL Track API Call');
        loading.value = false;
        alltrack.value = modelAllTrackOrderFromJson(response.body).data;
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
