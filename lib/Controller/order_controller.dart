import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:raxaadmin/Model/order_model.dart';
import 'package:dio/dio.dart' as dio;

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class OrderController extends GetxController {
  RxList<DeliveryData> order_Data = <DeliveryData>[].obs;
  RxList<PendingOrder> pendingOrder_Data = <PendingOrder>[].obs;
  RxList<PendingOrder> deliveredCount_Data = <PendingOrder>[].obs;

  RxInt total_length = 0.obs;
  RxString deliveredCount = "0".obs;
  RxBool loading = false.obs;
  final LocalStorage storage = LocalStorage('localstorage_app');

  @override
  void onInit() {
    getNewOrder();
    super.onInit();
  }

  getNewOrder() async {
    loading.value = true;
    print('AGHARIA Zakirhussain Gulamhussain1');

    var headers = {
      'Authorization': 'Bearer ${storage.getItem('TOKEN')}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IlZJeHU1TjZ5ODQyOXU4enJGN2E1YlE9PSIsInZhbHVlIjoiSVhrQ0g3dS9vV3JzWWo0Q1Z2RUZ2ZGoveEZOeURFSE5PR25CaE5TeXRML1h3Y3dpZHp6Sk01bWhHanQycW9URzc3dzFMbnd5aERTRUxjbHpwQ1Y2SFBFSTU2UVlkaXNUOFVCaVhPcHFFdFRBL1ZqN1lTVjlzZkpDQ3hBT09xMWciLCJtYWMiOiJjMzlmZTcxNTkzYTI3YjkxNDg4YzM3ZTgyZWFjY2UwZjc3MjEyMTU5ZjFiMGJjZWZmNjg3Y2I2NzM0NmUzY2ZhIiwidGFnIjoiIn0%3D; wero_fit_session=eyJpdiI6IkhkL1NYYW04K205LzBURXEwNks1L0E9PSIsInZhbHVlIjoiSitKL1FOc1hOZGd1QjZWSGhHWWRzTXhqSDBDYk04aVpwZmFuRk44QlpyeGRGZDRJTWFCaExGYWdvVWdRYUlnamVHckorK3FQRjcyTklJNnJSYkVzRmxMQTJudEUzRkIwOWhXVDZPa1o4bnArSzdZQVlDb1loZ2JIZzExYmduaUwiLCJtYWMiOiI1MTAyNWVkYWZhNjBjYmJmMTkzNzJlMjE4OTA1NTk0YTQ4ZTA2ODgwMGY2Zjk0MDFkOTk1NWFiNTRmMmY5OTQ2IiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://goodgrown.in/event/api/delivery'));

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      loading.value = false;
      // print(await response.stream.bytesToString());
      order_Data.value = orderFormFromJson(response.body).deliveryData;
      pendingOrder_Data.value = orderFormFromJson(response.body).pendingOrder;
      deliveredCount_Data.value = orderFormFromJson(response.body).pendingOrder;
      deliveredCount.value = pendingOrder_Data[0].deliveredCount.toString();
      print(pendingOrder_Data.length);
      print('pendingOrder_Data.value');
      total_length.value = order_Data.length;
      print(order_Data.length);
      print('order_Data.length');
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}
