import 'package:dio/dio.dart' as dio;
import 'package:raxaadmin/Model/event_model.dart';
import 'package:raxaadmin/service/http_service.dart';

import '../service/url.dart';

class EventApis {
  static FormServiceImpl formService = FormServiceImpl();

  // Get Events API
  static Future<List<EventModel>> getEventsApi(String token) async {
    dio.Response res = await formService.getRequest(EVENT_LIST_URL, token);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      if (res.data['status'] == true) {
        List<EventModel> events = eventModalFromJson(res.data['data']);
        return events;
      }
    }
    return [];
  }
}
