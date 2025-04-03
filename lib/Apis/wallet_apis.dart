import 'package:dio/dio.dart' as dio;
import 'package:raxaadmin/Model/payment_model.dart';
import 'package:raxaadmin/Widgets/myToasts.dart';
import 'package:raxaadmin/service/http_service.dart';
import 'package:raxaadmin/service/url.dart';

class WalletApis {
  static FormServiceImpl formService = FormServiceImpl();

  // Get Balance API
  static Future<int> getBalance(String token) async {
    dio.Response res =
        await formService.getRequest(REMAINING_CREDIT_URL, token);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      if (res.data['status'] == true) {
        return res.data['data']['credit'];
      }
      return 0;
    }

    return 0;
  }

  // Get Payments API
  static Future<List<PaymentModel>> getPayments(String token) async {
    dio.Response res = await formService.getRequest(USER_PAYMENT_URL, token);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      if (res.data['status'] == true) {
        return paymentModelFromJson(res.data['data']);
      }
    }
    return [];
  }

  static Future<dio.Response?> walletWithdrawApi(
      dio.FormData body, token) async {
    print('Ahmed1');
    dio.Response res =
        await formService.postRequest(WALLET_WITHDRAW_URL, body, token, null);
    print('Ahmed2');
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      print('Ahmed3');
      print(res.data);

      if (res.data["status"] == true) {
        return res;
      } else {
        var r = res.data["message"];
        longToastMessage("$r");
        return null;
      }
    } else if (res.statusCode == 700) {
      longToastMessage("Unkown error occured");
      return null;
    } else {
      var r = res.data["message"];
      longToastMessage("$r");

      return null;
    }
  }
}
