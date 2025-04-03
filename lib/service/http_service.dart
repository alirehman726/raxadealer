import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:raxaadmin/service/url.dart';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HttpService {
  Future<Response> getRequest(String url);
  Future<Response> postRequest(String url, body);
  Future<Response> patchRequest(String url, body);
  Future<Response> putRequest(String url, dynamic body);
  Future<Response> deleteRequest(String url);
}

// An Api calling implement class
const String appToken = "fc37a415585e4f54590496ad09554e4f";

Response emptyRes = Response(
    data: "", statusCode: 700, requestOptions: RequestOptions(path: ""));

class HttpServiceImpl implements HttpService {
  HttpServiceImpl() {
    _dio = Dio(BaseOptions(
        baseUrl: BASE_URL, headers: {'Content-Type': 'application/json'}));
    initializeInterceptors();
  }
  late Dio _dio;
  initializeInterceptors() {
    _dio.interceptors.add(LogInterceptor(
      error: true,
      request: false,
      requestHeader: false,
      responseHeader: false,
      responseBody: false,
      requestBody: false,
      logPrint: (object) {
        print(object);
      },
    ));
  }

  // @override
  // void init() {
  //   _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: {'Authorization': getToken()}));

  // }

  @override
  Future<Response> getRequest(String url) async {
    Response response;
    try {
      response = await _dio.get(url);
    } on DioError catch (e) {
      print(e.message);
      response = emptyRes;
      throw Exception(e.message);
    }

    return response;
  }

  @override
  Future<Response> deleteRequest(String url) async {
    Response response;
    try {
      response = await _dio.delete(url);
    } on DioError catch (e) {
      print(e.message);
      response = emptyRes;
      throw Exception(e.message);
    }

    return response;
  }

  @override
  Future<Response> patchRequest(String url, body) async {
    Response response;
    try {
      response = await _dio.patch(url, data: body);
    } on DioError catch (e) {
      print(e.message);
      response = emptyRes;
      throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> postRequest(String url, body) async {
    Response response;
    try {
      response = await _dio.post(url, data: jsonEncode(body));
    } on DioError catch (e) {
      print(e.message);
      response = emptyRes;
      // throw Exception(e.message);
    }

    return response;
  }

  @override
  Future<Response> putRequest(String url, body) async {
    Response response;
    try {
      response = await _dio.put(url, data: body);
    } on DioError catch (e) {
      print(e.message);
      response = emptyRes;
      throw Exception(e.message);
    }

    return response;
  }
}

class FormServiceImpl {
  FormServiceImpl() {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: {
      'Content-Type': 'application/json',
    }));
    initializeInterceptors();
  }
  late Dio _dio;
  initializeInterceptors() async {
    _dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
      requestBody: true,
      logPrint: (object) {
        if (kDebugMode) {
          print(object.toString());
        }
      },
    ));
  }

  Future<Response> getRequest(String url, String? token) async {
    Response response;
    final LocalStorage storage = LocalStorage('localstorage_app');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (token != null) {
        _dio.options = BaseOptions(baseUrl: BASE_URL, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
        });
      }
      response = await _dio.get(url);
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) {
        response = e.response!;
      } else {
        response = emptyRes;
      }
    }

    return response;
  }

  Future<Response> deleteRequest(String url, String? token) async {
    Response response;
    final LocalStorage storage = LocalStorage('localstorage_app');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (token != null) {
        _dio.options = BaseOptions(baseUrl: BASE_URL, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
        });
      }
      response = await _dio.delete(url);
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) {
        response = e.response!;
      } else {
        response = emptyRes;
      }
    }

    return response;
  }

  Future<Response> patchRequest(
      String url, FormData body, String? token) async {
    Response response;
    final LocalStorage storage = LocalStorage('localstorage_app');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (token != null) {
        _dio.options = BaseOptions(baseUrl: BASE_URL, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
        });
      }
      response = await _dio.patch(url, data: body);
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) {
        response = e.response!;
      } else {
        response = emptyRes;
      }
    }
    return response;
  }

  Future<Response> postRequest(
      String url, FormData? body, String? token, BaseOptions? options) async {
    Response response;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString('token'));
    print(postRequest);
    try {
      if (token != null) {
        _dio.options = BaseOptions(baseUrl: BASE_URL, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
        });
      }
      if (options != null) {
        _dio.options = options;
      }
      if (body != null) {
        response = await _dio.post(url, data: body);
      } else {
        response = await _dio.post(url);
      }
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) {
        response = e.response!;
      } else {
        response = emptyRes;
      } // throw Exception(e.message);
    }

    return response;
  }

  Future<Response> putRequest(
      String url, FormData body, String? token, BaseOptions? options) async {
    Response response;
    final LocalStorage storage = LocalStorage('localstorage_app');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      if (token != null) {
        _dio.options = BaseOptions(baseUrl: BASE_URL, headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
        });
      }
      if (options != null) {
        _dio.options = options;
      }
      response = await _dio.put(url, data: body);
    } on DioError catch (e) {
      print(e.message);
      if (e.response != null) {
        response = e.response!;
      } else {
        response = emptyRes;
      }
    }

    return response;
  }
}
