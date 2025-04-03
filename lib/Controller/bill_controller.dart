import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:raxaadmin/Model/order_model.dart';
import 'package:dio/dio.dart' as dio;

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../Model/bill_model.dart';

class BillController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Bill> bill_Data = <Bill>[].obs;
  RxList<CustomerDetail> customer_detail_Data = <CustomerDetail>[].obs;
  RxList<OrderDetail> order_detail_Data = <OrderDetail>[].obs;
  RxString customerName = "".obs;
  RxString building = "".obs;
  RxString addressTitle = "".obs;
  RxString city = "".obs;
  RxString area = "".obs;
  RxString landmark = "".obs;
  RxInt pincode = 0.obs;
  RxString dateTime = "".obs;
  RxString delivery = "".obs;
  RxString payment_status = "".obs;
  RxString location = "".obs;
  RxString mobile_no = "".obs;
  RxString location_link = "".obs;
  RxInt orderId = 0.obs;
  RxInt total_price = 0.obs;
  RxInt discount = 0.obs;
  RxInt delivery_charge = 0.obs;
  RxInt total_payble_amount = 0.obs;
  RxBool loading = false.obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;
  final LocalStorage storage = LocalStorage('localstorage_app');

  // get order_Data => null;

  @override
  void onInit() {
    getBill();
    super.onInit();
  }

  getBill() async {
    loading.value = true;
    var headers = {
      'Authorization': 'Bearer ${storage.getItem('TOKEN')}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IndNWGNzN1BwNUxMcnFIWHFzU2E1SVE9PSIsInZhbHVlIjoiT3dlVHE0cFpZZ1BSRWdHVHBMVmdmaXVWUUpCRzk2TGRnTGk4eHBHZGdNVW5iOFNkU2tDRmFYdjVhbUJaNDBoc1lnd2t5MlpXOFVFUXNyNmpoTmMxeHpvdW1FRi9TOHNqYWtvZ2p0UkVSZzBpSlpFK1BEdG1udTB2MmdiQ21ISzMiLCJtYWMiOiI2NzZhMmQ2ODc5MWVjYzkyY2QwYTE5NGM5ZjhkMmM0ZTM2MTlhNjMyMWVlZWYzNTAyZjBkNDA1YTc3ZGY3ZjNiIiwidGFnIjoiIn0%3D; wero_fit_session=eyJpdiI6IjROQ1N2RktjWndzOGlYOVFwcmo4dVE9PSIsInZhbHVlIjoiVU96aTVjRTRxSEtvT3dvSjVmTE05YmZjN0loNWhReGpXTEV3a0pZRXRnelVtREgyblVwWFRsS0RweFNuOU1tblVackhITCtXbkRFWGhDZ0daUzN4U0c2SWFaZG1hcFNCNnlqaGNqTkZoaC9JcGNrYlFGNlZLZy9CVm1TazU0c0ciLCJtYWMiOiJhMTNjNjI2M2U2ZmU2NTJiZTJhY2FjOGM0MDMyOWFjN2FmNTQ3YmJiYzkyMDc4OGMyZDc3M2IxZGQzOTY3Njg3IiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://goodgrown.in/event/api/bill'));
    request.fields.addAll(
      {
        'order_id': '${storage.getItem('ORDERID')}',
        // 'order_id': '185'.toString(),
      },
    );
    print(storage.getItem('ORDERID'));
    print('storage.getItem');

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
      loading.value = false;
      order_detail_Data.value =
          billModelFromJson(response.body).bill.orderDetails;
      customer_detail_Data.value =
          billModelFromJson(response.body).bill.customerDetail;
      customerName.value = customer_detail_Data[0].firstName;
      orderId.value = customer_detail_Data[0].orderId;
      total_price.value = customer_detail_Data[0].discountPrice;
      discount.value = customer_detail_Data[0].promocodeDiscount;
      delivery_charge.value = customer_detail_Data[0].shippingCharge;
      total_payble_amount.value = customer_detail_Data[0].totalPaybleAmount;
      delivery.value = customer_detail_Data[0].orderStatus;
      payment_status.value = customer_detail_Data[0].paymentStatus;
      dateTime.value = customer_detail_Data[0].deliveryDate as String;
      location.value = customer_detail_Data[0].locationLink;
      mobile_no.value = customer_detail_Data[0].contactNo;
      building.value = customer_detail_Data[0].building;
      addressTitle.value = customer_detail_Data[0].addressTitle;
      city.value = customer_detail_Data[0].city;
      area.value = customer_detail_Data[0].area;
      landmark.value = customer_detail_Data[0].landmark;
      pincode.value = customer_detail_Data[0].pincode;
      location_link.value = customer_detail_Data[0].locationLink;
      latitude.value = customer_detail_Data.first.latitude;
      longitude.value = customer_detail_Data.first.longitude;

      print(order_detail_Data.length);
      print(customer_detail_Data.length);
      print(latitude);
      print(longitude);
      print('ssssssssssssssssssssssss');
      storage.deleteItem('ORDERID');
      // bill_Data.value = billModelFromJson(response.body).bill;
      // bill_Data.value = billModelFromJson(response.body).bill as List<Bill>;
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  // getBill() async {
  //   loading.value = true;
  //   var headers = {
  //     'Authorization': 'Bearer ${storage.getItem('TOKEN')}',
  // 'Cookie':
  //     'XSRF-TOKEN=eyJpdiI6IndNWGNzN1BwNUxMcnFIWHFzU2E1SVE9PSIsInZhbHVlIjoiT3dlVHE0cFpZZ1BSRWdHVHBMVmdmaXVWUUpCRzk2TGRnTGk4eHBHZGdNVW5iOFNkU2tDRmFYdjVhbUJaNDBoc1lnd2t5MlpXOFVFUXNyNmpoTmMxeHpvdW1FRi9TOHNqYWtvZ2p0UkVSZzBpSlpFK1BEdG1udTB2MmdiQ21ISzMiLCJtYWMiOiI2NzZhMmQ2ODc5MWVjYzkyY2QwYTE5NGM5ZjhkMmM0ZTM2MTlhNjMyMWVlZWYzNTAyZjBkNDA1YTc3ZGY3ZjNiIiwidGFnIjoiIn0%3D; wero_fit_session=eyJpdiI6IjROQ1N2RktjWndzOGlYOVFwcmo4dVE9PSIsInZhbHVlIjoiVU96aTVjRTRxSEtvT3dvSjVmTE05YmZjN0loNWhReGpXTEV3a0pZRXRnelVtREgyblVwWFRsS0RweFNuOU1tblVackhITCtXbkRFWGhDZ0daUzN4U0c2SWFaZG1hcFNCNnlqaGNqTkZoaC9JcGNrYlFGNlZLZy9CVm1TazU0c0ciLCJtYWMiOiJhMTNjNjI2M2U2ZmU2NTJiZTJhY2FjOGM0MDMyOWFjN2FmNTQ3YmJiYzkyMDc4OGMyZDc3M2IxZGQzOTY3Njg3IiwidGFnIjoiIn0%3D'
  //   };
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('https://goodgrown.in/event/api/bill'));
  //   request.fields.addAll({'order_id': '185'});

  //   request.headers.addAll(headers);

  //   http.Response response =
  //       await http.Response.fromStream(await request.send());

  //   if (response.statusCode == 200) {
  //     loading.value = false;
  //     customer_detail_Data.value =
  //         billModelFromJson(response.body).bill.customerDetail;
  //     customerName.value = customer_detail_Data[0].firstName;
  //     orderId.value = customer_detail_Data[0].orderId;
  //     total_price.value = customer_detail_Data[0].discountPrice;
  //     discount.value = customer_detail_Data[0].promocodeDiscount;
  //     delivery_charge.value = customer_detail_Data[0].shippingCharge;
  //     total_payble_amount.value = customer_detail_Data[0].totalPaybleAmount;
  //     delivery.value = customer_detail_Data[0].orderStatus;
  //     dateTime.value = customer_detail_Data[0].deliveryDate as String;
  //     order_detail_Data.value =
  //         billModelFromJson(response.body).bill.orderDetails;
  //     print(order_detail_Data.length);
  //     print(customer_detail_Data.length);
  //     print('ssssssssssssssssssssssss');
  //     storage.deleteItem('ORDERID');
  //     // bill_Data.value = billModelFromJson(response.body).bill;
  //     // bill_Data.value = billModelFromJson(response.body).bill as List<Bill>;
  //     print(response.body);
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
}
