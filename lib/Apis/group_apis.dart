import 'package:dio/dio.dart' as dio;
import 'package:raxaadmin/Model/group_model.dart';
import 'package:raxaadmin/service/http_service.dart';
import 'package:raxaadmin/service/url.dart';

class GroupApis {
  static FormServiceImpl formService = FormServiceImpl();

  // Create Group API
  static Future<dio.Response?> createGroup(
      dio.FormData body, String token) async {
    dio.Response res =
        await formService.postRequest(GROUP_URL, body, token, null);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    }
    return null;
  }

  // Edit Group API
  static Future<dio.Response?> updateGroup(
      dio.FormData body, String groupId, String token) async {
    dio.Response res =
        await formService.putRequest("$GROUP_URL/$groupId", body, token, null);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    }
    return null;
  }

  // Get Groups API
  static Future<List<GroupModel>> getGroupsApi(String token) async {
    dio.Response res = await formService.getRequest(GROUP_LIST_URL, token);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      if (res.data['status'] == true) {
        List<GroupModel> groups = groupModalFromJson(res.data['data']);
        return groups;
      }
    }
    return [];
  }

  // Delete Group API
  static Future<dio.Response?> deleteGroup(String token, String groupId) async {
    dio.Response res =
        await formService.deleteRequest("$GROUP_URL/$groupId", token);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    }
    return null;
  }

  // Get Group Detail API
  static Future<dio.Response?> getGroupDetail(
      String token, String groupId) async {
    dio.Response res =
        await formService.getRequest("$GROUP_URL/$groupId", token);
    if (res.statusCode! >= 200 && res.statusCode! <= 210) {
      return res;
    }
    return null;
  }
}
