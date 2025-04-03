import 'package:get/get.dart';
import 'package:raxaadmin/Apis/wallet_apis.dart';
import 'package:raxaadmin/Model/payment_model.dart';

class WalletController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt remainingBalance = 0.obs;
  RxList<PaymentModel> payments = <PaymentModel>[].obs;

  getRemainingBalance(token) async {
    isLoading.value = true;
    // Get Remaining Balance
    var res = await WalletApis.getBalance(token);
    remainingBalance.value = res;
    isLoading.value = false;
  }

  getPaymentList(token) async {
    isLoading.value = true;
    // Get Payment List
    var res = await WalletApis.getPayments(token);
    print(
        "Payment List Data -------------------------------------------------------");
    print(res.toString());
    print(
        "Payment List Data -------------------------------------------------------");
    payments.value = res;
    isLoading.value = false;
  }
}
