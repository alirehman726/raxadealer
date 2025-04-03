import 'package:get/get.dart';
import 'package:raxaadmin/Model/event_model.dart';

import '../Apis/event_apis.dart';

class EventController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<EventModel> eventData = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  setEventList(events) async {
    isLoading.value = true;
    eventData.value = events;
    isLoading.value = false;
  }

  getEventList(token) async {
    isLoading.value = true;
    // Get Events
    var res = await EventApis.getEventsApi(token);
    eventData.value = res;
    isLoading.value = false;
  }
}
