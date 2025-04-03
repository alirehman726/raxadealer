import 'package:get/get.dart';
import 'package:raxaadmin/Apis/support_apis.dart';
import 'package:raxaadmin/Model/ticket_model.dart';

class SupportController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TicketModel> ticketData = <TicketModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  getTicketList(token) async {
    isLoading.value = true;
    // Get Tickets
    var res = await SupportApis.getTicketsApi(token);
    ticketData.value = res;
    isLoading.value = false;
  }
}
