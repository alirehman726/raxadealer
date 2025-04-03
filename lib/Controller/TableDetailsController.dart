import 'package:get/get.dart';

class TableDetailsController extends GetxController {
  var selectedItems = <String, Map<String, dynamic>>{}.obs;

  void addItem(String itemName, Map<String, dynamic> itemData) {
    selectedItems[itemName] = itemData;
    update(); // UI update karega
  }

  void removeItem(String itemName) {
    selectedItems.remove(itemName);
    update(); // UI update karega
  }

  void setSelectedItems(Map<String, Map<String, dynamic>> newSelectedItems) {
    selectedItems.value = newSelectedItems;
    update();
  }
}
