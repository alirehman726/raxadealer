import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raxaadmin/utils/images.dart';

reachargeDialogBox() {
  Get.dialog(
    AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '🎉 Success ',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
          Image.asset(
            Images.SUCCESS,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            'Recharge Success',
            style: TextStyle(
              color: Color(0xff04536C),
              fontFamily: "Roboto",
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'OK',
            style: TextStyle(
              color: Color(0xff5856D6),
              fontFamily: "Roboto",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Get.back();
          },
        )
      ],
    ),
    barrierDismissible: false,
  );
}
