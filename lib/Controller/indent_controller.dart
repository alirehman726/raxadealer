import 'package:get/get.dart';
import 'package:raxaadmin/Model/indent_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class IndentController extends GetxController {
  RxList<ProductWise> productWise_Data = <ProductWise>[].obs;
  RxList<TextureWise> textureWise_Data = <TextureWise>[].obs;

  RxInt total_length_productWise = 0.obs;
  RxInt total_length_textureWise = 0.obs;
  RxBool loading = false.obs;
  final LocalStorage storage = LocalStorage('localstorage_app');
  String selectedDate = new DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void onInit() {
    indent(selectedDate);
    super.onInit();
  }

  indent(String selectedDate) async {
    loading.value = true;
    print('AGHARIA Zakirhussain Gulamhussain1');

    var headers = {
      'Authorization': 'Bearer ${storage.getItem('TOKEN')}',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IlZJeHU1TjZ5ODQyOXU4enJGN2E1YlE9PSIsInZhbHVlIjoiSVhrQ0g3dS9vV3JzWWo0Q1Z2RUZ2ZGoveEZOeURFSE5PR25CaE5TeXRML1h3Y3dpZHp6Sk01bWhHanQycW9URzc3dzFMbnd5aERTRUxjbHpwQ1Y2SFBFSTU2UVlkaXNUOFVCaVhPcHFFdFRBL1ZqN1lTVjlzZkpDQ3hBT09xMWciLCJtYWMiOiJjMzlmZTcxNTkzYTI3YjkxNDg4YzM3ZTgyZWFjY2UwZjc3MjEyMTU5ZjFiMGJjZWZmNjg3Y2I2NzM0NmUzY2ZhIiwidGFnIjoiIn0%3D; wero_fit_session=eyJpdiI6IkhkL1NYYW04K205LzBURXEwNks1L0E9PSIsInZhbHVlIjoiSitKL1FOc1hOZGd1QjZWSGhHWWRzTXhqSDBDYk04aVpwZmFuRk44QlpyeGRGZDRJTWFCaExGYWdvVWdRYUlnamVHckorK3FQRjcyTklJNnJSYkVzRmxMQTJudEUzRkIwOWhXVDZPa1o4bnArSzdZQVlDb1loZ2JIZzExYmduaUwiLCJtYWMiOiI1MTAyNWVkYWZhNjBjYmJmMTkzNzJlMjE4OTA1NTk0YTQ4ZTA2ODgwMGY2Zjk0MDFkOTk1NWFiNTRmMmY5OTQ2IiwidGFnIjoiIn0%3D'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://goodgrown.in/event/api/indent'));

    request.fields.addAll({'date': selectedDate.toString()});

    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      loading.value = false;
      // print(await response.stream.bytesToString());
      productWise_Data.value = indentDataFromJson(response.body).productWise;
      textureWise_Data.value = indentDataFromJson(response.body).textureWise;
      total_length_productWise.value = productWise_Data.length;
      total_length_textureWise.value = textureWise_Data.length;
      print(productWise_Data.length);
      print(textureWise_Data.length);
      print('pendingOrder_Data.value');
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}
