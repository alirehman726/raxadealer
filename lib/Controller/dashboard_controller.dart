// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../Model/dashboard_model.dart';

// class DashboardController extends GetxController {
//   RxList<Data> data_history = <Data>[].obs;

//   RxString balance = ''.obs;
//   RxString income = ''.obs;
//   RxString expence = ''.obs;
//   RxString selectedDate1 = ''.obs;
//   RxBool loading = false.obs;
//   final LocalStorage storage = LocalStorage('localstorage_app');
//   String selectedDate = new DateFormat("yyyy-MM-dd").format(DateTime.now());

//   @override
//   void onInit() {
//     dashboardController(selectedDate);
//     super.onInit();
//   }

//   dashboardController(String selectedDate) async {
//     loading.value = true;
//     print(selectedDate);
//     print('AGHARIA Zakirhussain Gulamhussain1');

//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//     var headers = {
//       'Authorization': 'Bearer ${sharedPreferences.getString("token")}',
//       'Cookie': 'PHPSESSID=evqp10ug88bh0qcb19e11lheco'
//     };
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('https://goodgrown.in/api_tvs/history.php'));

//     request.fields.addAll({'selected_date': selectedDate.toString()});

//     request.headers.addAll(headers);

//     http.Response response =
//         await http.Response.fromStream(await request.send());

//     if (response.statusCode == 200) {
//       print(selectedDate);
//       print('AAAAAAAAAAAAAAAAAAAAAA');
//       loading.value = false;
//       // print(await response.stream.bytesToString());
//       data_history.value = expencesFromJson(response.body).data;
//       balance.value = expencesFromJson(response.body).balance;
//       income.value = expencesFromJson(response.body).income;
//       expence.value = expencesFromJson(response.body).expence;
//       selectedDate1.value = expencesFromJson(response.body).selectedDate;
//       print('pendingOrder_Data.value');
//       print(response.body);
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
// }
