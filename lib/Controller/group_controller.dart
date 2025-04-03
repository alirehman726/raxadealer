import 'package:get/get.dart';
import 'package:raxaadmin/Apis/group_apis.dart';

import '../Model/group_model.dart';

class GroupController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<GroupModel> groupData = <GroupModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getGroupList(token) async {
    isLoading.value = true;
    // Get Groups
    var res = await GroupApis.getGroupsApi(token);
    print(
        "Group List=============================================================");
    print(res);
    print(
        "Group List=============================================================");
    groupData.value = res;
    isLoading.value = false;
  }
}
