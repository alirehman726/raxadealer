import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:raxaadmin/screen/screen_login.dart';
import 'package:raxaadmin/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

logoutDialog_logout(context) {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  Get.dialog(
    AlertDialog(
      title: Text('Are You Sure You Want To Logout'),
      //content: Text("This should not be closed automatically"),
      actions: <Widget>[
        TextButton(
          child: Text('Yes'),
          onPressed: () async {
            Get.dialog(
              Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: darkButtonColor,
                  ),
                ),
              ),
              barrierDismissible: false,
            );

            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove("token");
            sharedPreferences.clear();
            Get.offAll(() => ScreenLogin());
          },
        ),
        TextButton(
          child: Text('No'),
          onPressed: () {
            Get.back();
          },
        )
      ],
    ),
    barrierDismissible: false,
  );
}
