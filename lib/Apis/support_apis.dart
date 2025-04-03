import 'package:dio/dio.dart' as dio;
import 'package:raxaadmin/Model/ticket_model.dart';
import 'package:raxaadmin/Widgets/myToasts.dart';
import 'package:raxaadmin/service/http_service.dart';
import 'package:raxaadmin/service/url.dart';

class SupportApis {
  static FormServiceImpl formService = FormServiceImpl();

  static Future<List<TicketModel>> getTicketsApi(token) async {
    dio.Response res = await formService.getRequest(TICKETS_URL, token);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      if (res.data["status"] == true) {
        print(res.data["data"]);
        List<TicketModel> tickets = ticketModalFromJson(res.data["data"]);
        return tickets;
      }
    }
    return [];
  }

  static Future<TicketModel?> getTicketDetailApi(String ticketId, token) async {
    dio.Response res =
        await formService.getRequest("$GET_TICKET_DETAIL_URL/$ticketId", token);

    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      if (res.data["status"] == true) {
        return ticketModalObjFromJson(res.data["data"]);
      }
    }
    return null;
  }

  static Future<TicketModel?> createTicketApi(
      dio.FormData body, options) async {
    dio.Response res =
        await formService.postRequest(CREATE_TICKET, body, null, options);

    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      if (res.data["status"] == true) {
        return TicketModel.fromJson(res.data['data']);
      }
    } else if (res.statusCode == 700) {
      longToastMessage("Unknown error occured. Please try again.");
    } else {
      longToastMessage(
          "Unable to detect any error. Please contact system administrator.");
    }
    return null;
  }

  static Future<dio.Response?> replyToTicket(
      String ticketId, dio.FormData body, options) async {
    dio.Response res = await formService.postRequest(
        "$REPLY_TO_TICKET/$ticketId", body, null, options);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    }
    return null;
  }
}
