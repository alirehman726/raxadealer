import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:raxaadmin/Model/model_dealerReport.dart';

class ControllerDealerreport extends GetxController {
  RxList<Report> report = <Report>[].obs;
  // var table = [].obs;

  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // controllerViewOrder();
  }

  controllerDealerreport({required String month, required String year}) async {
    print(month);
    print(
        "month____yearmonth____year-------month____year-------month____year-------month____year-------month____year--------------");
    print(year);
    try {
      loading.value = true;

      // API URL me month aur year ko add karein
      var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://raxaspread.com/API/api/order-report?month=$month&year=$year'),
      );

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('Dealer Report API Call with month: $month and year: $year');
        loading.value = false;
        report.value = modelDealerReportFromJson(response.body).data;
        print(response.body);
      } else {
        print(response.body);
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("❌ Error fetching dealer report: $e");
    } finally {
      loading.value = false;
    }
  }

  // controllerDealerreport({required String month, required String year}) async {
  //   try {
  //     loading.value = true;
  //     var request = http.MultipartRequest(
  //         'GET',
  //         Uri.parse(
  //             'https://raxaspread.com/API/api/order-report?month=&year='));

  //     http.Response response =
  //         await http.Response.fromStream(await request.send());

  //     if (response.statusCode == 200) {
  //       print('Dealer Report API Call');
  //       loading.value = false;
  //       report.value = modelDealerReportFromJson(response.body).data;
  //       print(response.body);
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } catch (e) {
  //     print("❌ Error fetching tables: $e");
  //   } finally {
  //     loading.value = false;
  //   }
  // }
}
