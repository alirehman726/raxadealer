import 'package:dio/dio.dart' as dio;
import 'package:raxaadmin/service/http_service.dart';

import '../service/url.dart';

class PaymentApis {
  static FormServiceImpl formService = FormServiceImpl();

  // Record Payment API
  static Future<dio.Response?> recordPayment(dio.FormData body, token) async {
    dio.Response res =
        await formService.postRequest(PAYMENT_URL, body, token, null);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    }
    return null;
  }
}
