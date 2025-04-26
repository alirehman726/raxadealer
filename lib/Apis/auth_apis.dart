import 'package:dio/dio.dart' as dio;
import 'package:raxaadmin/service/http_service.dart';

class AuthApis {
  static FormServiceImpl formService = FormServiceImpl();

  static Future<dio.Response?> APIlogin(dio.FormData body) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/user-login", body, null, null);
    print(res.data);
    print('res.data_________________________________');
    print("URL: HIT");
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> changeStatusAPI(dio.FormData body) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/change-user-stauts", body, null, null);
    print(res.data);
    print('res.data_________________________________');
    print("URL: HIT");
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> changePasswordAPI(dio.FormData body) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/change_password", body, null, null);
    print(res.data);
    print('res.data_________________________________');
    print("URL: HIT");
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> productStatusAPI(dio.FormData body) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/change-product-status",
        body,
        null,
        null);
    print(res.data);
    print('res.data_________________________________');
    print("URL: HIT");
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> orderDataAPI(dio.FormData body) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/store-order", body, null, null);
    print(res.data);
    print('res.data_________________________________');
    print("URL: HIT");
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> addDealerAPI(dio.FormData body) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/signup", body, null, null);
    print(res.data);
    print('res.data_____________Add Dealer____________________');
    print("URL: HIT");
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> chnageOrderStatusAPI(dio.FormData body) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/change-order-stauts", body, null, null);
    print(res.data);
    print('res.data_____________Add Dealer____________________');
    print("URL: HIT");
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> editDealerAPI(dio.FormData body, int id) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/edit_user/${id}", body, null, null);
    print(res.data);
    print('res.data_____________Edit Dealer____________________');
    print("URL: HIT");
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> changeStatus(dio.FormData body) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/changeStatus", body, null, null);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> addProductAPI(dio.FormData body) async {
    dio.Response res = await formService.postRequest(
        "https://raxaspread.com/API/api/add_product", body, null, null);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }

  static Future<dio.Response?> deleteOrderApi(int id) async {
    dio.Response res = await formService.deleteRequest(
        "https://raxaspread.com/API/api/delete_product/${id}", null);
    print(id);
    print('id');
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    } else if (res.statusCode! >= 400 && res.statusCode! <= 403) {
      return null;
    }
  }
}
